   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               _LED_PORT:
  16  0000 5000          	dc.w	20480
  17  0002 5000          	dc.w	20480
  18  0004 5000          	dc.w	20480
  19  0006 5000          	dc.w	20480
  20                     .const:	section	.text
  21  0000               _LED_PIN:
  22  0000 08            	dc.b	8
  23  0001 04            	dc.b	4
  24  0002 02            	dc.b	2
  25  0003 01            	dc.b	1
  26                     	bsct
  27  0008               _BUTTON_PORT:
  28  0008 500a          	dc.w	20490
  29  000a 5005          	dc.w	20485
  30  000c 5005          	dc.w	20485
  31  000e 5005          	dc.w	20485
  32  0010 5005          	dc.w	20485
  33  0012 500f          	dc.w	20495
  34                     	switch	.const
  35  0004               _BUTTON_PIN:
  36  0004 01            	dc.b	1
  37  0005 20            	dc.b	32
  38  0006 10            	dc.b	16
  39  0007 40            	dc.b	64
  40  0008 80            	dc.b	128
  41  0009 80            	dc.b	128
  42  000a               _BUTTON_EXTI:
  43  000a 02            	dc.b	2
  44  000b 01            	dc.b	1
  45  000c 01            	dc.b	1
  46  000d 01            	dc.b	1
  47  000e 01            	dc.b	1
  48  000f 03            	dc.b	3
 133                     ; 103 void STM_EVAL_LEDInit(Led_TypeDef Led)
 133                     ; 104 {
 135                     	switch	.text
 136  0000               _STM_EVAL_LEDInit:
 138  0000 88            	push	a
 139       00000000      OFST:	set	0
 142                     ; 106   GPIO_Init(LED_PORT[Led], (GPIO_Pin_TypeDef)LED_PIN[Led], GPIO_MODE_OUT_PP_HIGH_FAST);
 144  0001 4bf0          	push	#240
 145  0003 5f            	clrw	x
 146  0004 97            	ld	xl,a
 147  0005 d60000        	ld	a,(_LED_PIN,x)
 148  0008 88            	push	a
 149  0009 7b03          	ld	a,(OFST+3,sp)
 150  000b 5f            	clrw	x
 151  000c 97            	ld	xl,a
 152  000d 58            	sllw	x
 153  000e ee00          	ldw	x,(_LED_PORT,x)
 154  0010 cd0000        	call	_GPIO_Init
 156  0013 85            	popw	x
 157                     ; 107 }
 160  0014 84            	pop	a
 161  0015 81            	ret
 198                     ; 119 void STM_EVAL_LEDOn(Led_TypeDef Led)
 198                     ; 120 {
 199                     	switch	.text
 200  0016               _STM_EVAL_LEDOn:
 202  0016 88            	push	a
 203       00000000      OFST:	set	0
 206                     ; 121   LED_PORT[Led]->ODR |= (uint8_t)LED_PIN[Led];
 208  0017 5f            	clrw	x
 209  0018 97            	ld	xl,a
 210  0019 58            	sllw	x
 211  001a ee00          	ldw	x,(_LED_PORT,x)
 212  001c 7b01          	ld	a,(OFST+1,sp)
 213  001e 905f          	clrw	y
 214  0020 9097          	ld	yl,a
 215  0022 f6            	ld	a,(x)
 216  0023 90da0000      	or	a,(_LED_PIN,y)
 217  0027 f7            	ld	(x),a
 218                     ; 122 }
 221  0028 84            	pop	a
 222  0029 81            	ret
 259                     ; 134 void STM_EVAL_LEDOff(Led_TypeDef Led)
 259                     ; 135 {
 260                     	switch	.text
 261  002a               _STM_EVAL_LEDOff:
 263  002a 88            	push	a
 264       00000000      OFST:	set	0
 267                     ; 136   LED_PORT[Led]->ODR &= (uint8_t)~LED_PIN[Led];
 269  002b 5f            	clrw	x
 270  002c 97            	ld	xl,a
 271  002d 58            	sllw	x
 272  002e ee00          	ldw	x,(_LED_PORT,x)
 273  0030 7b01          	ld	a,(OFST+1,sp)
 274  0032 905f          	clrw	y
 275  0034 9097          	ld	yl,a
 276  0036 90d60000      	ld	a,(_LED_PIN,y)
 277  003a 43            	cpl	a
 278  003b f4            	and	a,(x)
 279  003c f7            	ld	(x),a
 280                     ; 137 }
 283  003d 84            	pop	a
 284  003e 81            	ret
 321                     ; 149 void STM_EVAL_LEDToggle(Led_TypeDef Led)
 321                     ; 150 {
 322                     	switch	.text
 323  003f               _STM_EVAL_LEDToggle:
 325  003f 88            	push	a
 326       00000000      OFST:	set	0
 329                     ; 151   LED_PORT[Led]->ODR ^= (uint8_t)LED_PIN[Led];
 331  0040 5f            	clrw	x
 332  0041 97            	ld	xl,a
 333  0042 58            	sllw	x
 334  0043 ee00          	ldw	x,(_LED_PORT,x)
 335  0045 7b01          	ld	a,(OFST+1,sp)
 336  0047 905f          	clrw	y
 337  0049 9097          	ld	yl,a
 338  004b f6            	ld	a,(x)
 339  004c 90d80000      	xor	a,(_LED_PIN,y)
 340  0050 f7            	ld	(x),a
 341                     ; 152 }
 344  0051 84            	pop	a
 345  0052 81            	ret
 463                     ; 170 void STM_EVAL_PBInit(Button_TypeDef Button, ButtonMode_TypeDef Button_Mode)
 463                     ; 171 {
 464                     	switch	.text
 465  0053               _STM_EVAL_PBInit:
 467  0053 89            	pushw	x
 468       00000000      OFST:	set	0
 471                     ; 173   if (Button_Mode == BUTTON_MODE_EXTI)
 473  0054 9f            	ld	a,xl
 474  0055 a101          	cp	a,#1
 475  0057 2622          	jrne	L171
 476                     ; 176     GPIO_Init(BUTTON_PORT[Button], (GPIO_Pin_TypeDef)BUTTON_PIN[Button], GPIO_MODE_IN_FL_IT);
 478  0059 4b20          	push	#32
 479  005b 9e            	ld	a,xh
 480  005c 5f            	clrw	x
 481  005d 97            	ld	xl,a
 482  005e d60004        	ld	a,(_BUTTON_PIN,x)
 483  0061 88            	push	a
 484  0062 7b03          	ld	a,(OFST+3,sp)
 485  0064 5f            	clrw	x
 486  0065 97            	ld	xl,a
 487  0066 58            	sllw	x
 488  0067 ee08          	ldw	x,(_BUTTON_PORT,x)
 489  0069 cd0000        	call	_GPIO_Init
 491  006c 85            	popw	x
 492                     ; 177     EXTI_SetExtIntSensitivity((EXTI_Port_TypeDef)BUTTON_EXTI[Button], EXTI_SENSITIVITY_FALL_LOW);
 494  006d 7b01          	ld	a,(OFST+1,sp)
 495  006f 5f            	clrw	x
 496  0070 97            	ld	xl,a
 497  0071 d6000a        	ld	a,(_BUTTON_EXTI,x)
 498  0074 5f            	clrw	x
 499  0075 95            	ld	xh,a
 500  0076 cd0000        	call	_EXTI_SetExtIntSensitivity
 503  0079 2015          	jra	L371
 504  007b               L171:
 505                     ; 181     GPIO_Init(BUTTON_PORT[Button], (GPIO_Pin_TypeDef)BUTTON_PIN[Button], GPIO_MODE_IN_FL_NO_IT);
 507  007b 4b00          	push	#0
 508  007d 7b02          	ld	a,(OFST+2,sp)
 509  007f 5f            	clrw	x
 510  0080 97            	ld	xl,a
 511  0081 d60004        	ld	a,(_BUTTON_PIN,x)
 512  0084 88            	push	a
 513  0085 7b03          	ld	a,(OFST+3,sp)
 514  0087 5f            	clrw	x
 515  0088 97            	ld	xl,a
 516  0089 58            	sllw	x
 517  008a ee08          	ldw	x,(_BUTTON_PORT,x)
 518  008c cd0000        	call	_GPIO_Init
 520  008f 85            	popw	x
 521  0090               L371:
 522                     ; 183 }
 525  0090 85            	popw	x
 526  0091 81            	ret
 565                     ; 197 uint8_t STM_EVAL_PBGetState(Button_TypeDef Button)
 565                     ; 198 {
 566                     	switch	.text
 567  0092               _STM_EVAL_PBGetState:
 569  0092 88            	push	a
 570       00000000      OFST:	set	0
 573                     ; 199   return GPIO_ReadInputPin(BUTTON_PORT[Button], (GPIO_Pin_TypeDef)BUTTON_PIN[Button]);
 575  0093 5f            	clrw	x
 576  0094 97            	ld	xl,a
 577  0095 d60004        	ld	a,(_BUTTON_PIN,x)
 578  0098 88            	push	a
 579  0099 7b02          	ld	a,(OFST+2,sp)
 580  009b 5f            	clrw	x
 581  009c 97            	ld	xl,a
 582  009d 58            	sllw	x
 583  009e ee08          	ldw	x,(_BUTTON_PORT,x)
 584  00a0 cd0000        	call	_GPIO_ReadInputPin
 586  00a3 5b01          	addw	sp,#1
 589  00a5 5b01          	addw	sp,#1
 590  00a7 81            	ret
 616                     ; 208 void SD_LowLevel_DeInit(void)
 616                     ; 209 {
 617                     	switch	.text
 618  00a8               _SD_LowLevel_DeInit:
 622                     ; 210   SPI_Cmd(DISABLE); /*!< SD_SPI disable */
 624  00a8 4f            	clr	a
 625  00a9 cd0000        	call	_SPI_Cmd
 627                     ; 213   CLK_PeripheralClockConfig(SD_SPI_CLK, DISABLE);
 629  00ac ae0100        	ldw	x,#256
 630  00af cd0000        	call	_CLK_PeripheralClockConfig
 632                     ; 216   GPIO_Init(SD_SPI_SCK_GPIO_PORT, SD_SPI_SCK_PIN, GPIO_MODE_IN_FL_NO_IT);
 634  00b2 4b00          	push	#0
 635  00b4 4b20          	push	#32
 636  00b6 ae500a        	ldw	x,#20490
 637  00b9 cd0000        	call	_GPIO_Init
 639  00bc 85            	popw	x
 640                     ; 219   GPIO_Init(SD_SPI_MISO_GPIO_PORT, SD_SPI_MISO_PIN, GPIO_MODE_IN_FL_NO_IT);
 642  00bd 4b00          	push	#0
 643  00bf 4b80          	push	#128
 644  00c1 ae500a        	ldw	x,#20490
 645  00c4 cd0000        	call	_GPIO_Init
 647  00c7 85            	popw	x
 648                     ; 222   GPIO_Init(SD_SPI_MOSI_GPIO_PORT, SD_SPI_MOSI_PIN, GPIO_MODE_IN_FL_NO_IT);
 650  00c8 4b00          	push	#0
 651  00ca 4b40          	push	#64
 652  00cc ae500a        	ldw	x,#20490
 653  00cf cd0000        	call	_GPIO_Init
 655  00d2 85            	popw	x
 656                     ; 225   GPIO_Init(SD_CS_GPIO_PORT, SD_CS_PIN, GPIO_MODE_IN_FL_NO_IT);
 658  00d3 4b00          	push	#0
 659  00d5 4b20          	push	#32
 660  00d7 ae5014        	ldw	x,#20500
 661  00da cd0000        	call	_GPIO_Init
 663  00dd 85            	popw	x
 664                     ; 228   GPIO_Init(SD_DETECT_GPIO_PORT, SD_DETECT_PIN, GPIO_MODE_IN_FL_NO_IT);
 666  00de 4b00          	push	#0
 667  00e0 4b10          	push	#16
 668  00e2 ae5014        	ldw	x,#20500
 669  00e5 cd0000        	call	_GPIO_Init
 671  00e8 85            	popw	x
 672                     ; 229 }
 675  00e9 81            	ret
 703                     ; 236 void SD_LowLevel_Init(void)
 703                     ; 237 {
 704                     	switch	.text
 705  00ea               _SD_LowLevel_Init:
 709                     ; 239   CLK_PeripheralClockConfig(SD_SPI_CLK, ENABLE);
 711  00ea ae0101        	ldw	x,#257
 712  00ed cd0000        	call	_CLK_PeripheralClockConfig
 714                     ; 242   GPIO_ExternalPullUpConfig(SD_SPI_SCK_GPIO_PORT, (GPIO_Pin_TypeDef)(SD_SPI_MISO_PIN | SD_SPI_MOSI_PIN | \
 714                     ; 243                             SD_SPI_SCK_PIN), ENABLE);
 716  00f0 4b01          	push	#1
 717  00f2 4be0          	push	#224
 718  00f4 ae500a        	ldw	x,#20490
 719  00f7 cd0000        	call	_GPIO_ExternalPullUpConfig
 721  00fa 85            	popw	x
 722                     ; 246   SPI_Init( SPI_FIRSTBIT_MSB, SPI_BAUDRATEPRESCALER_2, SPI_MODE_MASTER,
 722                     ; 247            SPI_CLOCKPOLARITY_HIGH, SPI_CLOCKPHASE_2EDGE, SPI_DATADIRECTION_2LINES_FULLDUPLEX,
 722                     ; 248            SPI_NSS_SOFT, 0x07);
 724  00fb 4b07          	push	#7
 725  00fd 4b02          	push	#2
 726  00ff 4b00          	push	#0
 727  0101 4b01          	push	#1
 728  0103 4b02          	push	#2
 729  0105 4b04          	push	#4
 730  0107 5f            	clrw	x
 731  0108 cd0000        	call	_SPI_Init
 733  010b 5b06          	addw	sp,#6
 734                     ; 252   SPI_Cmd( ENABLE);
 736  010d a601          	ld	a,#1
 737  010f cd0000        	call	_SPI_Cmd
 739                     ; 255   GPIO_Init(SD_CS_GPIO_PORT, SD_CS_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);
 741  0112 4bd0          	push	#208
 742  0114 4b20          	push	#32
 743  0116 ae5014        	ldw	x,#20500
 744  0119 cd0000        	call	_GPIO_Init
 746  011c 85            	popw	x
 747                     ; 256 }
 750  011d 81            	ret
 778                     ; 263 void sEE_LowLevel_DeInit(void)
 778                     ; 264 {
 779                     	switch	.text
 780  011e               _sEE_LowLevel_DeInit:
 784                     ; 266   I2C_Cmd(DISABLE);
 786  011e 4f            	clr	a
 787  011f cd0000        	call	_I2C_Cmd
 789                     ; 269   I2C_DeInit();
 791  0122 cd0000        	call	_I2C_DeInit
 793                     ; 272   CLK_PeripheralClockConfig(sEE_I2C_CLK, DISABLE);
 795  0125 5f            	clrw	x
 796  0126 cd0000        	call	_CLK_PeripheralClockConfig
 798                     ; 276   GPIO_Init(sEE_I2C_SCL_GPIO_PORT, sEE_I2C_SCL_PIN, GPIO_MODE_IN_PU_NO_IT);
 800  0129 4b40          	push	#64
 801  012b 4b02          	push	#2
 802  012d ae5014        	ldw	x,#20500
 803  0130 cd0000        	call	_GPIO_Init
 805  0133 85            	popw	x
 806                     ; 279   GPIO_Init(sEE_I2C_SDA_GPIO_PORT, sEE_I2C_SDA_PIN, GPIO_MODE_IN_PU_NO_IT);
 808  0134 4b40          	push	#64
 809  0136 4b04          	push	#4
 810  0138 ae5014        	ldw	x,#20500
 811  013b cd0000        	call	_GPIO_Init
 813  013e 85            	popw	x
 814                     ; 280 }
 817  013f 81            	ret
 841                     ; 287 void sEE_LowLevel_Init(void)
 841                     ; 288 {
 842                     	switch	.text
 843  0140               _sEE_LowLevel_Init:
 847                     ; 290   CLK_PeripheralClockConfig(sEE_I2C_CLK, ENABLE);
 849  0140 ae0001        	ldw	x,#1
 850  0143 cd0000        	call	_CLK_PeripheralClockConfig
 852                     ; 292 }
 855  0146 81            	ret
 978                     	xdef	_BUTTON_EXTI
 979                     	xdef	_BUTTON_PIN
 980                     	xdef	_BUTTON_PORT
 981                     	xdef	_LED_PIN
 982                     	xdef	_LED_PORT
 983                     	xdef	_sEE_LowLevel_Init
 984                     	xdef	_sEE_LowLevel_DeInit
 985                     	xdef	_SD_LowLevel_Init
 986                     	xdef	_SD_LowLevel_DeInit
 987                     	xdef	_STM_EVAL_PBGetState
 988                     	xdef	_STM_EVAL_PBInit
 989                     	xdef	_STM_EVAL_LEDToggle
 990                     	xdef	_STM_EVAL_LEDOff
 991                     	xdef	_STM_EVAL_LEDOn
 992                     	xdef	_STM_EVAL_LEDInit
 993                     	xref	_SPI_Cmd
 994                     	xref	_SPI_Init
 995                     	xref	_I2C_Cmd
 996                     	xref	_I2C_DeInit
 997                     	xref	_GPIO_ExternalPullUpConfig
 998                     	xref	_GPIO_ReadInputPin
 999                     	xref	_GPIO_Init
1000                     	xref	_EXTI_SetExtIntSensitivity
1001                     	xref	_CLK_PeripheralClockConfig
1020                     	end
