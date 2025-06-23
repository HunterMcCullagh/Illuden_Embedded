/**
  ******************************************************************************
	//Firmware for the LED Modules of the Illuden Project
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"
#include "stm8s_eval.h"
#include "main.h"
#include <stdbool.h>


#define AFR ((volatile unsigned char*)0x50E0) //Alternate function register


uint8_t address_found = 0x00;

volatile uint8_t RGB_total_count = 0;//number of interrupts required to send a bit
volatile uint8_t RGB_high_count = 0;


//I2C related variables
volatile uint8_t I2C_data_received = 0;
extern uint8_t Slave_Buffer_Rx[];

uint8_t pwm_2700k = 0;
uint8_t pwm_5000k = 0;
uint8_t pwm_6500k = 0;
uint8_t RGB_red = 0;
uint8_t RGB_green = 0;
uint8_t RGB_blue = 0;



/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/* Public functions ----------------------------------------------------------*/

void GPIO_Init_PD2(void) {
    // Set pin PD2 as input with pull-up and interrupt enabled
		GPIOD->DDR &= ~(1 << 2);  // Configure PD2 as input (DDR = 0)
		GPIOD->CR1 |= (1 << 2);   // Enable internal pull-up for PD2
    GPIOD->CR2 |= (1 << 2);   // Enable interrupt for PD2
}

void EXTI_Config(void) {
    EXTI_CR1 |= (0x02 << 4); // Set PORTD sensitivity to falling edge (bits 4-5 for PORTD)
}

void I2C_interrupt_init(void){
	I2C->ITR = I2C_ITR_ITBUFEN | I2C_ITR_ITEVTEN | I2C_ITR_ITERREN;
	
	GPIOB->DDR &= ~((1 << 4) | (1 << 5)); // PB4 (SDA) and PB5 (SCL) as input
	GPIOB->CR1 |= (1 << 4) | (1 << 5);   // Enable pull-up resistors
	GPIOB->CR2 |= (1 << 4) | (1 << 5);   // Enable fast mode

}

//Initialize I2C 
void initI2c(void) {
  // set I2C (IRQ19) software interrupt priority to 2 (next to lowest)
  ITC->ISPR5 = (ITC->ISPR5 & ~0xc0) | 0x00; // 0b00 => level 2
  I2C->CR1 &= ~I2C_CR1_PE;  // start with peripheral off (PE = 0)
 
  // I2C_CR1_NOSTRETCH  |   // 0x80  Clock Stretching Disable (Stretching enabled)
  // I2C_CR1_ENGC       |   // 0x40  General Call Enable (master only)
  // I2C_CR1_PE         |   // 0x01  Peripheral Enable (set at end)
  I2C->CR1 = 0;
 
  // I2C_CR2_SWRST  |   // 0x80  Software Reset
  // I2C_CR2_POS    |   // 0x08  Acknowledge (ACK is for current byte)
  // I2C_CR2_ACK    |   // 0x04  Acknowledge Enable (set at end)
  // I2C_CR2_STOP   |   // 0x02  Stop Generation  (1 => send stop  -- not used)
  // I2C_CR2_START  |   // 0x01  Start Generation (1 => send start -- not used)
  I2C->CR2 = 0;
 
  I2C->FREQR = 16; // I2C frequency register, 16MHz {>= 4MHz for 400k}
 
  // I2C_OARL_ADD, addr = 0x20
  // I2C_OARL_ADD0  Interface Address bit0 (not used in 7-bit addr)
  I2C->OARL = 0x29 << 1;  // I2C own address register LSB, this matches the address on my scope
 
  // I2C_OARH_ADDMODE  | // 0x80  Addressing Mode (7-bit addr)
  // I2C_OARH_ADD      | // 0x06  Interface Address bits [9..8] (for 10-bit addr)
  I2C->OARH = I2C_OARH_ADDCONF; // Address Mode Configuration (must be 1 for some odd reason)
 
  I2C->ITR =  // I2C interrupt register -- all type ints enabled
    I2C_ITR_ITBUFEN   |   // 0x04  Buffer Interrupt Enable
    I2C_ITR_ITEVTEN   |   // 0x02  Event Interrupt Enable
    I2C_ITR_ITERREN;      // 0x01  Error Interrupt Enable
 
  // I2C->CCRL       // I2C clock control register low  (master only)
  // I2C->CCRH       // I2C clock control register high (master only)
  // I2C->TRISER     // I2C maximum rise time register  (master only)
 
  I2C->CR1 |= I2C_CR1_PE;  // 0x01  Peripheral Enable (enable pins)
  I2C->CR2 |= I2C_CR2_ACK; //send ack every byte (why must this be last?) 
}


//Initialize Tim1
void tim1_init(void)
{
    // Step 1: Enable clock for TIM1
    CLK->PCKENR1 |= CLK_PCKENR1_TIM1; // Enable TIM1 clock in peripheral clock register

    // Step 2: De-initialize TIM1 (reset its settings)
    TIM1->CR1 = 0x00;   // Reset control register 1
    TIM1->CR2 = 0x00;   // Reset control register 2
    TIM1->SMCR = 0x00;  // Disable the slave mode control register
    TIM1->IER = 0x00;   // Disable all interrupts
    TIM1->SR1 = 0x00;   // Clear interrupt status flags
    TIM1->SR2 = 0x00;   // Clear additional status flags

    // Step 3: Set the prescaler value
    TIM1->PSCRH = 0x00; // High byte of prescaler = 0
    TIM1->PSCRL = 0x00; // Low byte of prescaler = 0 (Prescaler = 1)

    // Step 4: Set the auto-reload value (defines the timer period)
    TIM1->ARRH = 0x00;  // High byte of ARR (auto-reload)
    TIM1->ARRL = 0x01;  // Low byte of ARR (example: ARR = 0)

    // Step 5: Enable update interrupt if needed
    TIM1->IER |= TIM1_IER_UIE; // Enable update interrupt

    // Step 6: Enable TIM1 counter
    //TIM1->CR1 |= TIM1_CR1_CEN; // Set CEN bit to start the counter
}
void tim1_enable(void)
{
	//TIM1_Cmd(ENABLE);
	TIM1->CR1 |= TIM1_CR1_CEN;
}

void tim1_disable(void)
{
	//TIM1_Cmd(DISABLE);
	TIM1->CR1 &= ~TIM1_CR1_CEN;
	TIM1->SR1 &= ~TIM1_SR1_UIF; // Clear the update interrupt flag
}

//Assembly instructions to write a 1 to the RGB LED
//Required to use assembly as higher level commands were too slow
void WRITE_HIGH_BIT(void)
{
	//GPIOC->ODR |= (1 << 7);
	GPIOC->ODR &= ~(1 << 7);
	__asm("nop"); 
	__asm("nop");
	__asm("nop");
	__asm("nop");
	__asm("nop");
	__asm("nop"); 
	__asm("nop");
	__asm("nop");
	__asm("nop");
	__asm("nop");
	
	//GPIOC->ODR &= ~(1 << 7);
	GPIOC->ODR |= (1 << 7);
	__asm("nop");		
	__asm("nop");
	__asm("nop");
	__asm("nop");
	__asm("nop");
	__asm("nop");	
	__asm("nop");
	__asm("nop");	
	__asm("nop");
}

//Assembly instructions to write a 0 to the RGB LED
void WRITE_LOW_BIT(void)
{
	GPIOC->ODR &= ~(1 << 7);
	__asm("nop"); 
	__asm("nop");
	__asm("nop");
	__asm("nop");
	
	GPIOC->ODR |= (1 << 7);
	__asm("nop");		
}

//RGB LED requires a 24 bit 1 wire protocol message using a timing encoding
//The reason the code is wrote without loops is due to the limitations of the max STM8S frequency and available clock cycles
void send_RGB_message(uint8_t red, uint8_t blue, uint8_t green)
{
	//uint8_t i;
	__asm("SIM"); // Disable interrupts (for STM8)
	
	((red >> (7)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((red >> (6)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((red >> (5)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((red >> (4)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((red >> (3)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((red >> (2)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((red >> (1)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((red >> (0)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();	
	
	((blue >> (7)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((blue >> (6)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((blue >> (5)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((blue >> (4)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((blue >> (3)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((blue >> (2)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((blue >> (1)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((blue >> (0)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();	
	
	((green >> (7)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((green >> (6)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((green >> (5)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((green >> (4)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((green >> (3)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((green >> (2)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((green >> (1)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
	((green >> (0)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();	
	
	__asm("RIM"); // Enable interrupts again
}



// Initialize PC7 as output
void PC7_Init(void) {
    // Set PC7 to output mode
    GPIOC->DDR |= (1 << 7); // Data Direction Register: 1 = Output
    GPIOC->CR1 |= (1 << 7); // Control Register 1: Push-pull mode
    GPIOC->CR2 |= (1 << 7); // Control Register 2: High speed
    //GPIOC->ODR &= ~(1 << 7); // Output Data Register: Initialize to LOW
		GPIOC->ODR |= (1 << 7); //init high bc converter
}

//Initialize PWM signals for the 3 LEDs
void TIM1_PWM_Init(void)
{
	
		SPI->CR1 = 0x00; // Disable SPI
		SPI->CR2 = 0x00;

		AFR[2] |= (1 << 6);  // Set PC6 alternate function (AFR for Port C)
		
		
		CLK->PCKENR1 |= (1 << CLK_PCKENR1_TIM1); 

    // Configure GPIO for TIM1_CH3 (PC3)
    GPIOC->DDR |= (1 << 3);  // Set PC3 as output
    GPIOC->CR1 |= (1 << 3);  // Push-pull mode
    GPIOC->CR2 |= (1 << 3);  // Fast mode

		//PC6 TIM1_CH1 (PC6)
		GPIOC->DDR |= (1 << 6);  // Set PC6 as output
		GPIOC->CR1 |= (1 << 6);  // Set PC6 to push-pull mode
		GPIOC->CR2 |= (1 << 6);  // Enable fast mode

    // Configure GPIO for TIM1_CH4 (PC4)
    GPIOC->DDR |= (1 << 4);  // Set PC4 as output
    GPIOC->CR1 |= (1 << 4);  // Push-pull mode
    GPIOC->CR2 |= (1 << 4);  // Fast mode

    // Reset TIM1 configuration
    TIM1->CR1 = 0x00;

    // Set TIM1 to up-counting mode
    TIM1->CR1 |= TIM1_CR1_CEN;  // Enable the counter

    // Set prescaler to divide the clock frequency
    TIM1->PSCRH = 0x00; // High byte of prescaler
    TIM1->PSCRL = 0x00; // Low byte of prescaler (prescaler = 1)

    // Set auto-reload value (frequency)
    TIM1->ARRH = 0x03;  // High byte (e.g., 0x03E8 for a 1 kHz PWM frequency)
    TIM1->ARRL = 0xE8;  // Low byte

    // Set duty cycle for Channel 3 (e.g., 50%)
    TIM1->CCR3H = 0x01; // High byte
    TIM1->CCR3L = 0xF4; // Low byte (e.g., 0x01F4 for 50% of 0x03E8)

		// Set duty cycle for Channel 1 (e.g., 50%)
		TIM1->CCR1H = 0x02; // High byte
		TIM1->CCR1L = 0xBC; // Low byte

    // Set duty cycle for Channel 4 (e.g., 75%)
    TIM1->CCR4H = 0x02; // High byte
    TIM1->CCR4L = 0xBC; // Low byte (e.g., 0x02BC for 75% of 0x03E8)

    // Configure PWM mode 1 on Channel 3
    TIM1->CCMR3 = TIM1_OCMODE_PWM1; // Set output compare mode to PWM1
    TIM1->CCER2 |= TIM1_CCER2_CC3E; // Enable the output on Channel 3

		// Configure PWM mode 1 on Channel 1
		TIM1->CCMR1 = TIM1_OCMODE_PWM1; // Set output compare mode to PWM1
		TIM1->CCER1 |= TIM1_CCER1_CC1E; // Enable the output on Channel 1

    // Configure PWM mode 1 on Channel 4
    TIM1->CCMR4 = TIM1_OCMODE_PWM1; // Set output compare mode to PWM1
    TIM1->CCER2 |= TIM1_CCER2_CC4E; // Enable the output on Channel 4

    // Enable TIM1
    TIM1->BKR |= TIM1_BKR_MOE; // Enable main output
    TIM1->CR1 |= TIM1_CR1_CEN; // Enable the timer counter

}

//set PWM of the GPIO connected to LED1
void set_LED1_PWM(uint8_t pwm)
{
	uint8_t factor;
	uint16_t newValue;
	
	newValue = pwm*10;
	
	TIM1->CCR3H = (newValue >>8) & 0xFF; // High byte
	TIM1->CCR3L = (newValue) & 0xFF; // Low byte (e.g., 0x01F4 for 50% of 0x03E8)
}

void set_LED2_PWM(uint8_t pwm)
{
	uint8_t factor;
	uint16_t newValue;
	
	newValue = pwm*10;
	
	TIM1->CCR4H = (newValue >>8) & 0xFF; // High byte
	TIM1->CCR4L = (newValue) & 0xFF; // Low byte (e.g., 0x01F4 for 50% of 0x03E8)
}

void set_LED3_PWM(uint8_t pwm)
{
	uint8_t factor;
	uint16_t newValue;
	
	newValue = pwm*10;
	
	TIM1->CCR1H = (newValue >>8) & 0xFF; // High byte
	TIM1->CCR1L = (newValue) & 0xFF; // Low byte (e.g., 0x01F4 for 50% of 0x03E8)
}

//A function required to ensure alternate function of GPIO function properly
void flash_fix(void) 
{
	
		const uint32_t AFR_DATA_ADDRESS = 0x4803;
    const uint32_t AFR_REQUIRED_VALUE = 0x1; // Enable TIM1_CH1 pin

    const uint16_t valueAndComplement = FLASH_ReadOptionByte(AFR_DATA_ADDRESS);
    const uint8_t currentValue = valueAndComplement >> 8;

    // Update value if the current option byte is corrupt or the wrong value
    if (valueAndComplement == 0 || currentValue != AFR_REQUIRED_VALUE) {
        FLASH_Unlock(FLASH_MEMTYPE_DATA);
        FLASH_ProgramOptionByte(AFR_DATA_ADDRESS, AFR_REQUIRED_VALUE);
        FLASH_Lock(FLASH_MEMTYPE_DATA);
    }
}


void parse_i2c_data(void) 
{
	if(pwm_2700k != Slave_Buffer_Rx[0])
	{
		pwm_2700k = Slave_Buffer_Rx[0];
		set_LED3_PWM(pwm_2700k);
	}
	
	if(pwm_5000k != Slave_Buffer_Rx[1])
	{
		pwm_5000k = Slave_Buffer_Rx[1];
		set_LED2_PWM(pwm_5000k);
	}
	
	if(pwm_6500k != Slave_Buffer_Rx[2])
	{
		pwm_6500k = Slave_Buffer_Rx[2];
		set_LED1_PWM(pwm_6500k);
	}

	if(RGB_red != Slave_Buffer_Rx[3] || RGB_green != Slave_Buffer_Rx[4] || RGB_blue != Slave_Buffer_Rx[5])
	{
		RGB_red 	= Slave_Buffer_Rx[3];
		RGB_green = Slave_Buffer_Rx[4];
		RGB_blue 	= Slave_Buffer_Rx[5];
		send_RGB_message(RGB_red,RGB_green,RGB_blue);
	}

}



/**
  * @brief  Main program.
  * @param  None
  * @retval None
  */
void main(void)
{
	uint8_t counter = 0;
	
	//uint8_t data[] = {0x01, 0x02, 0x03}; // Data to send
	//uint8_t slave_address = 0x50;        // Slave device address
	
	bool timer_started = false;
	
  /* system_clock / 1 */
  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
	
	// Optional: Verify that HSI is ready and stable
	while ((CLK->ICKR & CLK_ICKR_HSIRDY) == 0);

	// Ensure HSI is the active clock source (if not already)
  CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
  
	//GPIO Interrupt
	GPIO_Init_PD2();
	EXTI_Config();
	
	initI2c();
	
	PC7_Init();
	

  /* Enable general interrupts */
  enableInterrupts();

	//flash_fix(); //required for first time programming a STM8S device
	TIM1_PWM_Init();
	
	set_LED1_PWM(2); //6500
	set_LED2_PWM(2); //5000
	set_LED3_PWM(2); //2700
	


  /*Main Loop */
  while (1)
  {
		
		if(I2C_data_received)
		{
			parse_i2c_data();
			I2C_data_received = 0;
		}

  }
}

#ifdef  USE_FULL_ASSERT
/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t* file, uint32_t line)
{
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {}
}
#endif

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
