/**
  ******************************************************************************
  * @file     stm8s_it.c
  * @author   MCD Application Team
  * @version  V2.0.4
  * @date     26-April-2018
  * @brief    Main Interrupt Service Routines.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */ 

/* Includes ------------------------------------------------------------------*/
#include "stm8s_it.h"
#include "stm8s_eval.h"
#include "main.h"



/** @addtogroup I2C_TwoBoards
  * @{
  */

/** @addtogroup I2C_DataExchange
  * @{
  */
/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
uint8_t test_var[10];
volatile uint8_t Slave_Buffer_Rx[30] = {0}; //was 255
volatile uint8_t Tx_Idx = 0, Rx_Idx = 0;
volatile uint16_t Event = 0x00;
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/* Public functions ----------------------------------------------------------*/
extern uint8_t RGB_high_count;
extern uint8_t RGB_total_count;

extern void tim1_disable(void); //remove later

extern uint8_t RGBSIG_ReadLevel(void);
extern void RGBSIG_SetLow(void);
extern void RGBSIG_SetHigh(void);
volatile uint8_t RGB_status;
//uint8_t *RGB_count_ptr = &RGB_high_count;

extern uint8_t I2C_data_received;

#ifdef _COSMIC_
/**
  * @brief  Dummy interrupt routine
  * @param  None
  * @retval None
  */
@far @interrupt void NonHandledInterrupt(void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	test_var[0] = 5;
}

/**
  * @brief  TRAP interrupt routine
  * @param  None
  * @retval None
  */
@far @interrupt void TRAP_IRQHandler(void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	test_var[0] = 5;
}
#else /*_RAISONANCE_*/

/**
  * @brief  TRAP interrupt routine
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /*_COSMIC_*/

/**
  * @brief  Top Level Interrupt routine
  * @param None
  * @retval
  * None
  */
//INTERRUPT_HANDLER(TLI_IRQHandler, 0)
void TLI_IRQHandler(void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	test_var[0] = 5;
}

/**
  * @brief  Auto Wake Up Interrupt routine
  * @param None
  * @retval
  * None
  */
//INTERRUPT_HANDLER(AWU_IRQHandler, 1)	
void AWU_IRQHandler(void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	test_var[0] = 5;
}

/**
  * @brief  Clock Controller Interrupt routine
  * @param None
  * @retval
  * None
  */
//INTERRUPT_HANDLER(CLK_IRQHandler, 2)
void CLK_IRQHandler(void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	test_var[0] = 5;
}

/**
  * @brief  External Interrupt PORTA Interrupt routine
  * @param None
  * @retval
  * None
  */
//INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
void EXTI_PORTA_IRQHandler(void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	test_var[0] = 5;
}

/**
  * @brief  External Interrupt PORTB Interrupt routine
  * @param  None
  * @retval None
  */
//INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
void EXTI_PORTB_IRQHandler(void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	test_var[0] = 5;
}

/**
  * @brief  External Interrupt PORTC Interrupt routine
  * @param None
  * @retval
  * None
  */
//INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
void EXTI_PORTC_IRQHandler(void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	test_var[0] = 5;
}

/**
  * @brief  External Interrupt PORTD Interrupt routine
  * @param None
  * @retval
  * None
  */
//INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
void EXTI_PORTD_IRQHandler(void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
    if ((GPIOD->IDR & (1 << 2)) == 0) 
		{
        // Handle falling edge on PD2
        // For example: Toggle an LED
        //GPIO_WriteReverse(GPIOC, GPIO_PIN_5); // Toggle LED on PC5
				test_var[0] = 5;
    }	
	
}

/**
  * @brief  External Interrupt PORTE Interrupt routine
  * @param None
  * @retval
  * None
  */
//INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
void EXTI_PORTE_IRQHandler(void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	test_var[0] = 5;
}
#ifdef STM8S903
/**
  * @brief  External Interrupt PORTF Interrupt routine
  * @param None
  * @retval
  * None
  */
 INTERRUPT_HANDLER(EXTI_PORTF_IRQHandler, 8)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /*STM8S903*/

#ifdef STM8S208
/**
  * @brief  CAN RX Interrupt routine
  * @param None
  * @retval
  * None
  */
 INTERRUPT_HANDLER(CAN_RX_IRQHandler, 8)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
  * @brief  CAN TX Interrupt routine
  * @param None
  * @retval
  * None
  */
 INTERRUPT_HANDLER(CAN_TX_IRQHandler, 9)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /*STM8S208 || STM8AF52Ax */

/**
  * @brief  SPI Interrupt routine
  * @param None
  * @retval
  * None
  */
//INTERRUPT_HANDLER(SPI_IRQHandler, 10)
void SPI_IRQHandler(void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	test_var[0] = 5;
}

/**
  * @brief  Timer1 Update/Overflow/Trigger/Break Interrupt routine
  * @param None
  * @retval
  * None
  */
//INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
void TIM1_UPD_OVF_TRG_BRK_IRQHandler(void) //timer counter done interrupt
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	test_var[0] = 5;
	GPIOC->ODR ^= (1 << 7);
	
	//check to see if total count > 0
	//If high count > 0, check if high, if not set high
	//if high count = 0, check if low, set low
	/*
	if(RGB_total_count >0)
	{
		if(RGB_high_count > 0) //GPIO should be high
		{
			RGB_status = RGBSIG_ReadLevel();
			if(RGB_status != 1)
			{
				RGBSIG_SetHigh();
			}
			RGB_high_count--;
		}
		else
		{
			RGB_status = RGBSIG_ReadLevel();
			if(RGB_status != 0)
			{
				RGBSIG_SetLow();
			}
		}
		RGB_total_count--;
	}
	else
	{
		//tim1_disable();
	}
	
	/*
	if(RGB_high_count > 0)
	{
		RGB_high_count-=1;
	}
	else
	{
		//tim1_disable();
	}
	*/
	
	
}

/**
  * @brief  Timer1 Capture/Compare Interrupt routine
  * @param None
  * @retval
  * None
  */
//INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
void TIM1_CAP_COM_IRQHandler(void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	test_var[0] = 5;
}

#ifdef STM8S903
/**
  * @brief  Timer5 Update/Overflow/Break/Trigger Interrupt routine
  * @param None
  * @retval
  * None
  */
 INTERRUPT_HANDLER(TIM5_UPD_OVF_BRK_TRG_IRQHandler, 13)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
/**
  * @brief  Timer5 Capture/Compare Interrupt routine
  * @param None
  * @retval
  * None
  */
 INTERRUPT_HANDLER(TIM5_CAP_COM_IRQHandler, 14)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

#else /*STM8S208, STM8S207, STM8S105 or STM8S103 or STM8S001 or STM8AF62Ax or STM8AF52Ax or STM8AF626x */
/**
  * @brief  Timer2 Update/Overflow/Break Interrupt routine
  * @param None
  * @retval
  * None
  */
 //INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 void TIM2_UPD_OVF_BRK_IRQHandler(void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	test_var[0] = 5;
}

/**
  * @brief  Timer2 Capture/Compare Interrupt routine
  * @param None
  * @retval
  * None
  */
 //INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 void TIM2_CAP_COM_IRQHandler(void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	test_var[0] = 5;
}
#endif /*STM8S903*/

#if defined(STM8S208) || defined(STM8S207) || defined(STM8S007) || defined(STM8S105) || \
    defined(STM8S005) || defined(STM8AF62Ax) || defined(STM8AF52Ax) || defined(STM8AF626x)
/**
  * @brief  Timer3 Update/Overflow/Break Interrupt routine
  * @param None
  * @retval
  * None
  */
 INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
  * @brief  Timer3 Capture/Compare Interrupt routine
  * @param None
  * @retval
  * None
  */
 INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /*STM8S208, STM8S207 or STM8S105 or STM8AF62Ax or STM8AF52Ax or STM8AF626x */

#if defined(STM8S208) || defined(STM8S207) || defined(STM8S007) || defined(STM8S103) || \
    defined(STM8S003) || defined(STM8S001) || defined(STM8AF62Ax) || defined(STM8AF52Ax) || defined(STM8S903)
/**
  * @brief  UART1 TX Interrupt routine
  * @param None
  * @retval
  * None
  */
 //INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 void UART1_TX_IRQHandler(void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	test_var[0] = 5;
}

/**
  * @brief  UART1 RX Interrupt routine
  * @param None
  * @retval
  * None
  */
 //INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 void UART1_RX_IRQHandler(void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	test_var[0] = 5;
}
#endif /*STM8S208, STM8S207 or STM8S103 or STM8AF62Ax or STM8AF52Ax or STM8S903 */

/**
  * @brief  I2C Interrupt routine
  * @param None
  * @retval
  * None
  */
//INTERRUPT_HANDLER(I2C_IRQHandler, 19)
@interrupt void I2C_IRQHandler(void)
{
  /* Read SR2 register to get I2C error */
  if ((I2C->SR2) != 0)
  {
    /* Clears SR2 register */
    I2C->SR2 = 0;

    /* Set LED2 */
    //STM_EVAL_LEDOn(LED2);

  }
  Event = I2C_GetLastEvent();
	
	/*if(Event != 514)
	{
		test_var[0] = 1;
	}
	else
	{
		test_var[0] = 0;		
	}
	if(Rx_Idx > 10)
	{
		Rx_Idx++;
	}*/
	
  switch (Event)
  {
      /******* Slave transmitter ******/
      /* check on EV1 */
    case I2C_EVENT_SLAVE_TRANSMITTER_ADDRESS_MATCHED:
      Tx_Idx = 0;
      break;

      /* check on EV3 */
    case I2C_EVENT_SLAVE_BYTE_TRANSMITTING:
      /* Transmit data */
			//Slave_Buffer_Rx[0] = 0x10; //for testing
      //I2C_SendData(Slave_Buffer_Rx[Tx_Idx++]);
			//test_var[0]=5;
      break;
      /******* Slave receiver **********/
      /* check on EV1*/
    case I2C_EVENT_SLAVE_RECEIVER_ADDRESS_MATCHED:
      break;

      /* Check on EV2*/
    case I2C_EVENT_SLAVE_BYTE_RECEIVED:
			//test_var[0] = I2C_ReceiveData();
			if(!I2C_data_received)
			{
				Slave_Buffer_Rx[Rx_Idx++] = I2C_ReceiveData();
			}
			else
			{
				I2C_ReceiveData();
			}
			
      
      break; //got here, will debug later

      /* Check on EV4 */
    case (I2C_EVENT_SLAVE_STOP_DETECTED):
			/* write to CR2 to clear STOPF flag */
			I2C->CR2 |= I2C_CR2_ACK;
			I2C_data_received = 1;
			Rx_Idx = 0;
      break;

    default:
      break;
  }

}

#if defined(STM8S105) || defined(STM8S005) ||  defined (STM8AF626x)
/**
  * @brief  UART2 TX interrupt routine.
  * @param None
  * @retval
  * None
  */
 INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
{
    /* In order to detect unexpected events during development,
       it is recommended to set a breakpoint on the following instruction.
    */
}

/**
  * @brief  UART2 RX interrupt routine.
  * @param None
  * @retval
  * None
  */
 INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
{
    /* In order to detect unexpected events during development,
       it is recommended to set a breakpoint on the following instruction.
    */
}
#endif /* STM8S105*/

#if defined(STM8S207) || defined(STM8S007) || defined(STM8S208) || defined (STM8AF52Ax) || defined (STM8AF62Ax)
/**
  * @brief  UART3 TX interrupt routine.
  * @param None
  * @retval
  * None
  */
 INTERRUPT_HANDLER(UART3_TX_IRQHandler, 20)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
  * @brief  UART3 RX interrupt routine.
  * @param None
  * @retval
  * None
  */
 INTERRUPT_HANDLER(UART3_RX_IRQHandler, 21)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /*STM8S208 or STM8S207 or STM8AF52Ax or STM8AF62Ax */

#if defined(STM8S207) || defined(STM8S007) || defined(STM8S208) || defined (STM8AF52Ax) || defined (STM8AF62Ax)
/**
  * @brief  ADC2 interrupt routine.
  * @param None
  * @retval
  * None
  */
 INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
{
    /* In order to detect unexpected events during development,
       it is recommended to set a breakpoint on the following instruction.
    */
}
#else /*STM8S105, STM8S103 or STM8S903 or STM8AF626x */
/**
  * @brief  ADC1 interrupt routine.
  * @param  None
  * @retval None
  */
 //INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 void ADC1_IRQHandler(void)
{
    /* In order to detect unexpected events during development,
       it is recommended to set a breakpoint on the following instruction.
    */
		test_var[0] = 5;
}
#endif /*STM8S208 or STM8S207 or STM8AF52Ax or STM8AF62Ax */

#ifdef STM8S903
/**
  * @brief  Timer6 Update/Overflow/Trigger Interrupt routine
  * @param None
  * @retval
  * None
  */
INTERRUPT_HANDLER(TIM6_UPD_OVF_TRG_IRQHandler, 23)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#else /*STM8S208, STM8S207, STM8S105 or STM8S103 or STM8S001 or STM8AF62Ax or STM8AF52Ax or STM8AF626x */
/**
  * @brief  Timer4 Update/Overflow Interrupt routine
  * @param None
  * @retval
  * None
  */
 //INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 void TIM4_UPD_OVF_IRQHandler(void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	test_var[0] = 5;
}
#endif /*STM8S903*/

/**
  * @brief  Eeprom EEC Interrupt routine
  * @param None
  * @retval
	* None
  */
//INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
void EEPROM_EEC_IRQHandler(void)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	test_var[0] = 5;
}

/**
  * @}
  */

/**
  * @}
  */
 
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/