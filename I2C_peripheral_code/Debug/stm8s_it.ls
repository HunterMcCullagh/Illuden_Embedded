   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  71                     	bsct
  72  0000               _Slave_Buffer_Rx:
  73  0000 00            	dc.b	0
  74  0001 000000000000  	ds.b	29
  75  001e               _Tx_Idx:
  76  001e 00            	dc.b	0
  77  001f               _Rx_Idx:
  78  001f 00            	dc.b	0
  79  0020               _Event:
  80  0020 0000          	dc.w	0
 111                     ; 72 @far @interrupt void NonHandledInterrupt(void)
 111                     ; 73 {
 112                     	switch	.text
 113  0000               f_NonHandledInterrupt:
 117                     ; 77 	test_var[0] = 5;
 119  0000 35050001      	mov	_test_var,#5
 120                     ; 78 }
 123  0004 80            	iret
 146                     ; 85 @far @interrupt void TRAP_IRQHandler(void)
 146                     ; 86 {
 147                     	switch	.text
 148  0005               f_TRAP_IRQHandler:
 152                     ; 90 	test_var[0] = 5;
 154  0005 35050001      	mov	_test_var,#5
 155                     ; 91 }
 158  0009 80            	iret
 181                     ; 114 void TLI_IRQHandler(void)
 181                     ; 115 {
 182                     	switch	.text
 183  000a               f_TLI_IRQHandler:
 187                     ; 119 	test_var[0] = 5;
 189  000a 35050001      	mov	_test_var,#5
 190                     ; 120 }
 193  000e 80            	iret
 216                     ; 129 void AWU_IRQHandler(void)
 216                     ; 130 {
 217                     	switch	.text
 218  000f               f_AWU_IRQHandler:
 222                     ; 134 	test_var[0] = 5;
 224  000f 35050001      	mov	_test_var,#5
 225                     ; 135 }
 228  0013 80            	iret
 251                     ; 144 void CLK_IRQHandler(void)
 251                     ; 145 {
 252                     	switch	.text
 253  0014               f_CLK_IRQHandler:
 257                     ; 149 	test_var[0] = 5;
 259  0014 35050001      	mov	_test_var,#5
 260                     ; 150 }
 263  0018 80            	iret
 287                     ; 159 void EXTI_PORTA_IRQHandler(void)
 287                     ; 160 {
 288                     	switch	.text
 289  0019               f_EXTI_PORTA_IRQHandler:
 293                     ; 164 	test_var[0] = 5;
 295  0019 35050001      	mov	_test_var,#5
 296                     ; 165 }
 299  001d 80            	iret
 323                     ; 173 void EXTI_PORTB_IRQHandler(void)
 323                     ; 174 {
 324                     	switch	.text
 325  001e               f_EXTI_PORTB_IRQHandler:
 329                     ; 178 	test_var[0] = 5;
 331  001e 35050001      	mov	_test_var,#5
 332                     ; 179 }
 335  0022 80            	iret
 359                     ; 188 void EXTI_PORTC_IRQHandler(void)
 359                     ; 189 {
 360                     	switch	.text
 361  0023               f_EXTI_PORTC_IRQHandler:
 365                     ; 193 	test_var[0] = 5;
 367  0023 35050001      	mov	_test_var,#5
 368                     ; 194 }
 371  0027 80            	iret
 395                     ; 203 void EXTI_PORTD_IRQHandler(void)
 395                     ; 204 {
 396                     	switch	.text
 397  0028               f_EXTI_PORTD_IRQHandler:
 401                     ; 208     if ((GPIOD->IDR & (1 << 2)) == 0) 
 403  0028 c65010        	ld	a,20496
 404  002b a504          	bcp	a,#4
 405  002d 2604          	jrne	L151
 406                     ; 213 				test_var[0] = 5;
 408  002f 35050001      	mov	_test_var,#5
 409  0033               L151:
 410                     ; 216 }
 413  0033 80            	iret
 437                     ; 225 void EXTI_PORTE_IRQHandler(void)
 437                     ; 226 {
 438                     	switch	.text
 439  0034               f_EXTI_PORTE_IRQHandler:
 443                     ; 230 	test_var[0] = 5;
 445  0034 35050001      	mov	_test_var,#5
 446                     ; 231 }
 449  0038 80            	iret
 472                     ; 282 void SPI_IRQHandler(void)
 472                     ; 283 {
 473                     	switch	.text
 474  0039               f_SPI_IRQHandler:
 478                     ; 287 	test_var[0] = 5;
 480  0039 35050001      	mov	_test_var,#5
 481                     ; 288 }
 484  003d 80            	iret
 508                     ; 297 void TIM1_UPD_OVF_TRG_BRK_IRQHandler(void) //timer counter done interrupt
 508                     ; 298 {
 509                     	switch	.text
 510  003e               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 514                     ; 302 	test_var[0] = 5;
 516  003e 35050001      	mov	_test_var,#5
 517                     ; 303 	GPIOC->ODR ^= (1 << 7);
 519  0042 901e500a      	bcpl	20490,#7
 520                     ; 347 }
 523  0046 80            	iret
 547                     ; 356 void TIM1_CAP_COM_IRQHandler(void)
 547                     ; 357 {
 548                     	switch	.text
 549  0047               f_TIM1_CAP_COM_IRQHandler:
 553                     ; 361 	test_var[0] = 5;
 555  0047 35050001      	mov	_test_var,#5
 556                     ; 362 }
 559  004b 80            	iret
 583                     ; 398  void TIM2_UPD_OVF_BRK_IRQHandler(void)
 583                     ; 399 {
 584                     	switch	.text
 585  004c               f_TIM2_UPD_OVF_BRK_IRQHandler:
 589                     ; 403 	test_var[0] = 5;
 591  004c 35050001      	mov	_test_var,#5
 592                     ; 404 }
 595  0050 80            	iret
 619                     ; 413  void TIM2_CAP_COM_IRQHandler(void)
 619                     ; 414 {
 620                     	switch	.text
 621  0051               f_TIM2_CAP_COM_IRQHandler:
 625                     ; 418 	test_var[0] = 5;
 627  0051 35050001      	mov	_test_var,#5
 628                     ; 419 }
 631  0055 80            	iret
 655                     ; 460  void UART1_TX_IRQHandler(void)
 655                     ; 461 {
 656                     	switch	.text
 657  0056               f_UART1_TX_IRQHandler:
 661                     ; 465 	test_var[0] = 5;
 663  0056 35050001      	mov	_test_var,#5
 664                     ; 466 }
 667  005a 80            	iret
 691                     ; 475  void UART1_RX_IRQHandler(void)
 691                     ; 476 {
 692                     	switch	.text
 693  005b               f_UART1_RX_IRQHandler:
 697                     ; 480 	test_var[0] = 5;
 699  005b 35050001      	mov	_test_var,#5
 700                     ; 481 }
 703  005f 80            	iret
 732                     ; 491 @interrupt void I2C_IRQHandler(void)
 732                     ; 492 {
 733                     	switch	.text
 734  0060               f_I2C_IRQHandler:
 736  0060 8a            	push	cc
 737  0061 84            	pop	a
 738  0062 a4bf          	and	a,#191
 739  0064 88            	push	a
 740  0065 86            	pop	cc
 741  0066 3b0002        	push	c_x+2
 742  0069 be00          	ldw	x,c_x
 743  006b 89            	pushw	x
 744  006c 3b0002        	push	c_y+2
 745  006f be00          	ldw	x,c_y
 746  0071 89            	pushw	x
 749                     ; 494   if ((I2C->SR2) != 0)
 751  0072 725d5218      	tnz	21016
 752  0076 2704          	jreq	L772
 753                     ; 497     I2C->SR2 = 0;
 755  0078 725f5218      	clr	21016
 756  007c               L772:
 757                     ; 503   Event = I2C_GetLastEvent();
 759  007c cd0000        	call	_I2C_GetLastEvent
 761  007f bf20          	ldw	_Event,x
 762                     ; 518   switch (Event)
 764  0081 be20          	ldw	x,_Event
 766                     ; 561     default:
 766                     ; 562       break;
 767  0083 1d0010        	subw	x,#16
 768  0086 272c          	jreq	L362
 769  0088 1d0230        	subw	x,#560
 770  008b 270d          	jreq	L162
 771  008d 1d0442        	subw	x,#1090
 772  0090 262c          	jrne	L303
 773                     ; 522     case I2C_EVENT_SLAVE_TRANSMITTER_ADDRESS_MATCHED:
 773                     ; 523       Tx_Idx = 0;
 775  0092 3f1e          	clr	_Tx_Idx
 776                     ; 524       break;
 778  0094 2028          	jra	L303
 779  0096               L552:
 780                     ; 527     case I2C_EVENT_SLAVE_BYTE_TRANSMITTING:
 780                     ; 528       /* Transmit data */
 780                     ; 529 			//Slave_Buffer_Rx[0] = 0x10; //for testing
 780                     ; 530       //I2C_SendData(Slave_Buffer_Rx[Tx_Idx++]);
 780                     ; 531 			//test_var[0]=5;
 780                     ; 532       break;
 782  0096 2026          	jra	L303
 783  0098               L752:
 784                     ; 535     case I2C_EVENT_SLAVE_RECEIVER_ADDRESS_MATCHED:
 784                     ; 536       break;
 786  0098 2024          	jra	L303
 787  009a               L162:
 788                     ; 539     case I2C_EVENT_SLAVE_BYTE_RECEIVED:
 788                     ; 540 			//test_var[0] = I2C_ReceiveData();
 788                     ; 541 			if(!I2C_data_received)
 790  009a 3d00          	tnz	_I2C_data_received
 791  009c 2611          	jrne	L503
 792                     ; 543 				Slave_Buffer_Rx[Rx_Idx++] = I2C_ReceiveData();
 794  009e b61f          	ld	a,_Rx_Idx
 795  00a0 97            	ld	xl,a
 796  00a1 3c1f          	inc	_Rx_Idx
 797  00a3 9f            	ld	a,xl
 798  00a4 5f            	clrw	x
 799  00a5 97            	ld	xl,a
 800  00a6 89            	pushw	x
 801  00a7 cd0000        	call	_I2C_ReceiveData
 803  00aa 85            	popw	x
 804  00ab e700          	ld	(_Slave_Buffer_Rx,x),a
 806  00ad 200f          	jra	L303
 807  00af               L503:
 808                     ; 547 				I2C_ReceiveData();
 810  00af cd0000        	call	_I2C_ReceiveData
 812  00b2 200a          	jra	L303
 813  00b4               L362:
 814                     ; 554     case (I2C_EVENT_SLAVE_STOP_DETECTED):
 814                     ; 555 			/* write to CR2 to clear STOPF flag */
 814                     ; 556 			I2C->CR2 |= I2C_CR2_ACK;
 816  00b4 72145211      	bset	21009,#2
 817                     ; 557 			I2C_data_received = 1;
 819  00b8 35010000      	mov	_I2C_data_received,#1
 820                     ; 558 			Rx_Idx = 0;
 822  00bc 3f1f          	clr	_Rx_Idx
 823                     ; 559       break;
 825  00be               L562:
 826                     ; 561     default:
 826                     ; 562       break;
 828  00be               L303:
 829                     ; 565 }
 832  00be 85            	popw	x
 833  00bf bf00          	ldw	c_y,x
 834  00c1 320002        	pop	c_y+2
 835  00c4 85            	popw	x
 836  00c5 bf00          	ldw	c_x,x
 837  00c7 320002        	pop	c_x+2
 838  00ca 80            	iret
 861                     ; 643  void ADC1_IRQHandler(void)
 861                     ; 644 {
 862                     	switch	.text
 863  00cb               f_ADC1_IRQHandler:
 867                     ; 648 		test_var[0] = 5;
 869  00cb 35050001      	mov	_test_var,#5
 870                     ; 649 }
 873  00cf 80            	iret
 897                     ; 673  void TIM4_UPD_OVF_IRQHandler(void)
 897                     ; 674 {
 898                     	switch	.text
 899  00d0               f_TIM4_UPD_OVF_IRQHandler:
 903                     ; 678 	test_var[0] = 5;
 905  00d0 35050001      	mov	_test_var,#5
 906                     ; 679 }
 909  00d4 80            	iret
 933                     ; 689 void EEPROM_EEC_IRQHandler(void)
 933                     ; 690 {
 934                     	switch	.text
 935  00d5               f_EEPROM_EEC_IRQHandler:
 939                     ; 694 	test_var[0] = 5;
 941  00d5 35050001      	mov	_test_var,#5
 942                     ; 695 }
 945  00d9 80            	iret
 988                     	xref.b	_I2C_data_received
 989                     	switch	.ubsct
 990  0000               _RGB_status:
 991  0000 00            	ds.b	1
 992                     	xdef	_RGB_status
 993  0001               _test_var:
 994  0001 000000000000  	ds.b	10
 995                     	xdef	_test_var
 996                     	xdef	f_EEPROM_EEC_IRQHandler
 997                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 998                     	xdef	f_ADC1_IRQHandler
 999                     	xdef	f_I2C_IRQHandler
1000                     	xdef	f_UART1_RX_IRQHandler
1001                     	xdef	f_UART1_TX_IRQHandler
1002                     	xdef	f_TIM2_CAP_COM_IRQHandler
1003                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1004                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1005                     	xdef	f_TIM1_CAP_COM_IRQHandler
1006                     	xdef	f_SPI_IRQHandler
1007                     	xdef	f_EXTI_PORTE_IRQHandler
1008                     	xdef	f_EXTI_PORTD_IRQHandler
1009                     	xdef	f_EXTI_PORTC_IRQHandler
1010                     	xdef	f_EXTI_PORTB_IRQHandler
1011                     	xdef	f_EXTI_PORTA_IRQHandler
1012                     	xdef	f_CLK_IRQHandler
1013                     	xdef	f_AWU_IRQHandler
1014                     	xdef	f_TLI_IRQHandler
1015                     	xdef	f_TRAP_IRQHandler
1016                     	xdef	f_NonHandledInterrupt
1017                     	xdef	_Event
1018                     	xdef	_Rx_Idx
1019                     	xdef	_Tx_Idx
1020                     	xdef	_Slave_Buffer_Rx
1021                     	xref	_I2C_GetLastEvent
1022                     	xref	_I2C_ReceiveData
1023                     	xref.b	c_x
1024                     	xref.b	c_y
1044                     	end
