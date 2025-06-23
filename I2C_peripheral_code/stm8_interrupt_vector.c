/*	BASIC INTERRUPT VECTOR TABLE FOR STM8 devices
 *	Copyright (c) 2007 STMicroelectronics
 */

typedef void @far (*interrupt_handler_t)(void);

struct interrupt_vector {
	unsigned char interrupt_instruction;
	interrupt_handler_t interrupt_handler;
};

extern @far @interrupt void TLI_IRQHandler(void); //0
extern @far @interrupt void AWU_IRQHandler(void); //1
extern @far @interrupt void CLK_IRQHandler(void); //2
extern @far @interrupt void EXTI_PORTA_IRQHandler(void); //3
extern @far @interrupt void EXTI_PORTB_IRQHandler(void); //4
extern @far @interrupt void EXTI_PORTC_IRQHandler(void); //5
extern @far @interrupt void EXTI_PORTD_IRQHandler(void); //6
extern @far @interrupt void EXTI_PORTE_IRQHandler(void); //7
extern @far @interrupt void SPI_IRQHandler(void); //10
extern @far @interrupt void TIM1_UPD_OVF_TRG_BRK_IRQHandler(void); //11
extern @far @interrupt void TIM1_CAP_COM_IRQHandler(void); //12
extern @far @interrupt void TIM2_UPD_OVF_BRK_IRQHandler(void); //13
extern @far @interrupt void TIM2_CAP_COM_IRQHandler(void); //14
extern @far @interrupt void UART1_TX_IRQHandler(void); //17
extern @far @interrupt void UART1_RX_IRQHandler(void); //18
extern @far @interrupt void I2C_IRQHandler(void); //19
extern @far @interrupt void ADC1_IRQHandler(void); //22
extern @far @interrupt void TIM4_UPD_OVF_IRQHandler(void); //23
extern @far @interrupt void EEPROM_EEC_IRQHandler(void); //24

extern @far @interrupt void TRAP_IRQHandler(void);

extern @far @interrupt void NonHandledInterrupt (void);
//{
	/* in order to detect unexpected events during development, 
	   it is recommended to set a breakpoint on the following instruction
	*/
//	return;
//}

extern void _stext();     /* startup routine */

struct interrupt_vector const _vectab[] = {
	{0x82, (interrupt_handler_t)_stext}, /* reset */
	{0x82, (interrupt_handler_t)TRAP_IRQHandler}, /* trap  */
	{0x82, (interrupt_handler_t)TLI_IRQHandler}, /* irq0  */
	{0x82, (interrupt_handler_t)AWU_IRQHandler}, /* irq1  */
	{0x82, (interrupt_handler_t)CLK_IRQHandler}, /* irq2  */
	{0x82, (interrupt_handler_t)EXTI_PORTA_IRQHandler}, /* irq3  */
	{0x82, (interrupt_handler_t)EXTI_PORTB_IRQHandler}, /* irq4  */
	{0x82, (interrupt_handler_t)EXTI_PORTC_IRQHandler}, /* irq5  */
	{0x82, (interrupt_handler_t)EXTI_PORTD_IRQHandler}, /* irq6  */
	{0x82, (interrupt_handler_t)EXTI_PORTE_IRQHandler}, /* irq7  */
	{0x82, NonHandledInterrupt}, /* irq8  */
	{0x82, NonHandledInterrupt}, /* irq9  */
	{0x82, (interrupt_handler_t)SPI_IRQHandler}, /* irq10 */
	{0x82, (interrupt_handler_t)TIM1_UPD_OVF_TRG_BRK_IRQHandler}, /* irq11 */
	{0x82, (interrupt_handler_t)TIM1_CAP_COM_IRQHandler}, /* irq12 */
	{0x82, (interrupt_handler_t)TIM2_UPD_OVF_BRK_IRQHandler}, /* irq13 */
	{0x82, (interrupt_handler_t)TIM2_CAP_COM_IRQHandler}, /* irq14 */
	{0x82, NonHandledInterrupt}, /* irq15 */
	{0x82, NonHandledInterrupt}, /* irq16 */
	{0x82, (interrupt_handler_t)UART1_TX_IRQHandler}, /* irq17 */
	{0x82, (interrupt_handler_t)UART1_RX_IRQHandler}, /* irq18 */
	{0x82, (interrupt_handler_t)I2C_IRQHandler}, /* irq19 */
	{0x82, NonHandledInterrupt}, /* irq20 */
	{0x82, NonHandledInterrupt}, /* irq21 */
	{0x82, (interrupt_handler_t)ADC1_IRQHandler}, /* irq22 */
	{0x82, (interrupt_handler_t)TIM4_UPD_OVF_IRQHandler}, /* irq23 */
	{0x82, (interrupt_handler_t)EEPROM_EEC_IRQHandler}, /* irq24 */
	{0x82, NonHandledInterrupt}, /* irq25 */
	{0x82, NonHandledInterrupt}, /* irq26 */
	{0x82, NonHandledInterrupt}, /* irq27 */
	{0x82, NonHandledInterrupt}, /* irq28 */
	{0x82, NonHandledInterrupt}, /* irq29 */
};
