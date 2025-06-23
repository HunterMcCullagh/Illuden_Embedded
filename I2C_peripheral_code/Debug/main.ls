   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               _address_found:
  16  0000 00            	dc.b	0
  17  0001               _RGB_total_count:
  18  0001 00            	dc.b	0
  19  0002               _RGB_high_count:
  20  0002 00            	dc.b	0
  21  0003               _I2C_data_received:
  22  0003 00            	dc.b	0
  23  0004               _pwm_2700k:
  24  0004 00            	dc.b	0
  25  0005               _pwm_5000k:
  26  0005 00            	dc.b	0
  27  0006               _pwm_6500k:
  28  0006 00            	dc.b	0
  29  0007               _RGB_red:
  30  0007 00            	dc.b	0
  31  0008               _RGB_green:
  32  0008 00            	dc.b	0
  33  0009               _RGB_blue:
  34  0009 00            	dc.b	0
  63                     ; 44 void GPIO_Init_PD2(void) {
  65                     	switch	.text
  66  0000               _GPIO_Init_PD2:
  70                     ; 46 		GPIOD->DDR &= ~(1 << 2);  // Configure PD2 as input (DDR = 0)
  72  0000 72155011      	bres	20497,#2
  73                     ; 47 		GPIOD->CR1 |= (1 << 2);   // Enable internal pull-up for PD2
  75  0004 72145012      	bset	20498,#2
  76                     ; 48     GPIOD->CR2 |= (1 << 2);   // Enable interrupt for PD2
  78  0008 72145013      	bset	20499,#2
  79                     ; 49 }
  82  000c 81            	ret
 105                     ; 51 void EXTI_Config(void) {
 106                     	switch	.text
 107  000d               _EXTI_Config:
 111                     ; 52     EXTI_CR1 |= (0x02 << 4); // Set PORTD sensitivity to falling edge (bits 4-5 for PORTD)
 113  000d 721a50a0      	bset	20640,#5
 114                     ; 53 }
 117  0011 81            	ret
 140                     ; 55 void I2C_interrupt_init(void){
 141                     	switch	.text
 142  0012               _I2C_interrupt_init:
 146                     ; 56 	I2C->ITR = I2C_ITR_ITBUFEN | I2C_ITR_ITEVTEN | I2C_ITR_ITERREN;
 148  0012 3507521a      	mov	21018,#7
 149                     ; 58 	GPIOB->DDR &= ~((1 << 4) | (1 << 5)); // PB4 (SDA) and PB5 (SCL) as input
 151  0016 c65007        	ld	a,20487
 152  0019 a4cf          	and	a,#207
 153  001b c75007        	ld	20487,a
 154                     ; 59 	GPIOB->CR1 |= (1 << 4) | (1 << 5);   // Enable pull-up resistors
 156  001e c65008        	ld	a,20488
 157  0021 aa30          	or	a,#48
 158  0023 c75008        	ld	20488,a
 159                     ; 60 	GPIOB->CR2 |= (1 << 4) | (1 << 5);   // Enable fast mode
 161  0026 c65009        	ld	a,20489
 162  0029 aa30          	or	a,#48
 163  002b c75009        	ld	20489,a
 164                     ; 62 }
 167  002e 81            	ret
 190                     ; 65 void initI2c(void) {
 191                     	switch	.text
 192  002f               _initI2c:
 196                     ; 67   ITC->ISPR5 = (ITC->ISPR5 & ~0xc0) | 0x00; // 0b00 => level 2
 198  002f c67f74        	ld	a,32628
 199  0032 a43f          	and	a,#63
 200  0034 c77f74        	ld	32628,a
 201                     ; 68   I2C->CR1 &= ~I2C_CR1_PE;  // start with peripheral off (PE = 0)
 203  0037 72115210      	bres	21008,#0
 204                     ; 73   I2C->CR1 = 0;
 206  003b 725f5210      	clr	21008
 207                     ; 80   I2C->CR2 = 0;
 209  003f 725f5211      	clr	21009
 210                     ; 82   I2C->FREQR = 16; // I2C frequency register, 16MHz {>= 4MHz for 400k}
 212  0043 35105212      	mov	21010,#16
 213                     ; 86   I2C->OARL = 0x29 << 1;  // I2C own address register LSB, this matches the address on my scope
 215  0047 35525213      	mov	21011,#82
 216                     ; 90   I2C->OARH = I2C_OARH_ADDCONF; // Address Mode Configuration (must be 1 for some odd reason)
 218  004b 35405214      	mov	21012,#64
 219                     ; 92   I2C->ITR =  // I2C interrupt register -- all type ints enabled
 219                     ; 93     I2C_ITR_ITBUFEN   |   // 0x04  Buffer Interrupt Enable
 219                     ; 94     I2C_ITR_ITEVTEN   |   // 0x02  Event Interrupt Enable
 219                     ; 95     I2C_ITR_ITERREN;      // 0x01  Error Interrupt Enable
 221  004f 3507521a      	mov	21018,#7
 222                     ; 101   I2C->CR1 |= I2C_CR1_PE;  // 0x01  Peripheral Enable (enable pins)
 224  0053 72105210      	bset	21008,#0
 225                     ; 102   I2C->CR2 |= I2C_CR2_ACK; //send ack every byte (why must this be last?) 
 227  0057 72145211      	bset	21009,#2
 228                     ; 103 }
 231  005b 81            	ret
 254                     ; 107 void tim1_init(void)
 254                     ; 108 {
 255                     	switch	.text
 256  005c               _tim1_init:
 260                     ; 110     CLK->PCKENR1 |= CLK_PCKENR1_TIM1; // Enable TIM1 clock in peripheral clock register
 262  005c 721e50c7      	bset	20679,#7
 263                     ; 113     TIM1->CR1 = 0x00;   // Reset control register 1
 265  0060 725f5250      	clr	21072
 266                     ; 114     TIM1->CR2 = 0x00;   // Reset control register 2
 268  0064 725f5251      	clr	21073
 269                     ; 115     TIM1->SMCR = 0x00;  // Disable the slave mode control register
 271  0068 725f5252      	clr	21074
 272                     ; 116     TIM1->IER = 0x00;   // Disable all interrupts
 274  006c 725f5254      	clr	21076
 275                     ; 117     TIM1->SR1 = 0x00;   // Clear interrupt status flags
 277  0070 725f5255      	clr	21077
 278                     ; 118     TIM1->SR2 = 0x00;   // Clear additional status flags
 280  0074 725f5256      	clr	21078
 281                     ; 121     TIM1->PSCRH = 0x00; // High byte of prescaler = 0
 283  0078 725f5260      	clr	21088
 284                     ; 122     TIM1->PSCRL = 0x00; // Low byte of prescaler = 0 (Prescaler = 1)
 286  007c 725f5261      	clr	21089
 287                     ; 125     TIM1->ARRH = 0x00;  // High byte of ARR (auto-reload)
 289  0080 725f5262      	clr	21090
 290                     ; 126     TIM1->ARRL = 0x01;  // Low byte of ARR (example: ARR = 0)
 292  0084 35015263      	mov	21091,#1
 293                     ; 129     TIM1->IER |= TIM1_IER_UIE; // Enable update interrupt
 295  0088 72105254      	bset	21076,#0
 296                     ; 133 }
 299  008c 81            	ret
 322                     ; 134 void tim1_enable(void)
 322                     ; 135 {
 323                     	switch	.text
 324  008d               _tim1_enable:
 328                     ; 137 	TIM1->CR1 |= TIM1_CR1_CEN;
 330  008d 72105250      	bset	21072,#0
 331                     ; 138 }
 334  0091 81            	ret
 357                     ; 140 void tim1_disable(void)
 357                     ; 141 {
 358                     	switch	.text
 359  0092               _tim1_disable:
 363                     ; 143 	TIM1->CR1 &= ~TIM1_CR1_CEN;
 365  0092 72115250      	bres	21072,#0
 366                     ; 144 	TIM1->SR1 &= ~TIM1_SR1_UIF; // Clear the update interrupt flag
 368  0096 72115255      	bres	21077,#0
 369                     ; 145 }
 372  009a 81            	ret
 415                     ; 149 void WRITE_HIGH_BIT(void)
 415                     ; 150 {
 416                     	switch	.text
 417  009b               _WRITE_HIGH_BIT:
 421                     ; 152 	GPIOC->ODR &= ~(1 << 7);
 423  009b 721f500a      	bres	20490,#7
 424                     ; 153 	__asm("nop"); 
 427  009f 9d            nop
 429                     ; 154 	__asm("nop");
 432  00a0 9d            nop
 434                     ; 155 	__asm("nop");
 437  00a1 9d            nop
 439                     ; 156 	__asm("nop");
 442  00a2 9d            nop
 444                     ; 157 	__asm("nop");
 447  00a3 9d            nop
 449                     ; 158 	__asm("nop"); 
 452  00a4 9d            nop
 454                     ; 159 	__asm("nop");
 457  00a5 9d            nop
 459                     ; 160 	__asm("nop");
 462  00a6 9d            nop
 464                     ; 161 	__asm("nop");
 467  00a7 9d            nop
 469                     ; 162 	__asm("nop");
 472  00a8 9d            nop
 474                     ; 165 	GPIOC->ODR |= (1 << 7);
 476  00a9 721e500a      	bset	20490,#7
 477                     ; 166 	__asm("nop");		
 480  00ad 9d            nop
 482                     ; 167 	__asm("nop");
 485  00ae 9d            nop
 487                     ; 168 	__asm("nop");
 490  00af 9d            nop
 492                     ; 169 	__asm("nop");
 495  00b0 9d            nop
 497                     ; 170 	__asm("nop");
 500  00b1 9d            nop
 502                     ; 171 	__asm("nop");	
 505  00b2 9d            nop
 507                     ; 172 	__asm("nop");
 510  00b3 9d            nop
 512                     ; 173 	__asm("nop");	
 515  00b4 9d            nop
 517                     ; 174 	__asm("nop");
 520  00b5 9d            nop
 522                     ; 175 }
 525  00b6 81            	ret
 554                     ; 178 void WRITE_LOW_BIT(void)
 554                     ; 179 {
 555                     	switch	.text
 556  00b7               _WRITE_LOW_BIT:
 560                     ; 180 	GPIOC->ODR &= ~(1 << 7);
 562  00b7 721f500a      	bres	20490,#7
 563                     ; 181 	__asm("nop"); 
 566  00bb 9d            nop
 568                     ; 182 	__asm("nop");
 571  00bc 9d            nop
 573                     ; 183 	__asm("nop");
 576  00bd 9d            nop
 578                     ; 184 	__asm("nop");
 581  00be 9d            nop
 583                     ; 186 	GPIOC->ODR |= (1 << 7);
 585  00bf 721e500a      	bset	20490,#7
 586                     ; 187 	__asm("nop");		
 589  00c3 9d            nop
 591                     ; 188 }
 594  00c4 81            	ret
 650                     ; 192 void send_RGB_message(uint8_t red, uint8_t blue, uint8_t green)
 650                     ; 193 {
 651                     	switch	.text
 652  00c5               _send_RGB_message:
 654  00c5 89            	pushw	x
 655       00000000      OFST:	set	0
 658                     ; 195 	__asm("SIM"); // Disable interrupts (for STM8)
 661  00c6 9b            SIM
 663                     ; 197 	((red >> (7)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
 665  00c7 9e            	ld	a,xh
 666  00c8 49            	rlc	a
 667  00c9 4f            	clr	a
 668  00ca 49            	rlc	a
 669  00cb 5f            	clrw	x
 670  00cc 97            	ld	xl,a
 671  00cd a30000        	cpw	x,#0
 672  00d0 2704          	jreq	L03
 673  00d2 adc7          	call	_WRITE_HIGH_BIT
 675  00d4 2002          	jra	L23
 676  00d6               L03:
 677  00d6 addf          	call	_WRITE_LOW_BIT
 679  00d8               L23:
 680                     ; 198 	((red >> (6)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
 682  00d8 7b01          	ld	a,(OFST+1,sp)
 683  00da 4e            	swap	a
 684  00db 44            	srl	a
 685  00dc 44            	srl	a
 686  00dd a403          	and	a,#3
 687  00df 5f            	clrw	x
 688  00e0 a401          	and	a,#1
 689  00e2 5f            	clrw	x
 690  00e3 5f            	clrw	x
 691  00e4 97            	ld	xl,a
 692  00e5 a30000        	cpw	x,#0
 693  00e8 2704          	jreq	L43
 694  00ea adaf          	call	_WRITE_HIGH_BIT
 696  00ec 2002          	jra	L63
 697  00ee               L43:
 698  00ee adc7          	call	_WRITE_LOW_BIT
 700  00f0               L63:
 701                     ; 199 	((red >> (5)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
 703  00f0 7b01          	ld	a,(OFST+1,sp)
 704  00f2 4e            	swap	a
 705  00f3 44            	srl	a
 706  00f4 a407          	and	a,#7
 707  00f6 5f            	clrw	x
 708  00f7 a401          	and	a,#1
 709  00f9 5f            	clrw	x
 710  00fa 5f            	clrw	x
 711  00fb 97            	ld	xl,a
 712  00fc a30000        	cpw	x,#0
 713  00ff 2704          	jreq	L04
 714  0101 ad98          	call	_WRITE_HIGH_BIT
 716  0103 2002          	jra	L24
 717  0105               L04:
 718  0105 adb0          	call	_WRITE_LOW_BIT
 720  0107               L24:
 721                     ; 200 	((red >> (4)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
 723  0107 7b01          	ld	a,(OFST+1,sp)
 724  0109 4e            	swap	a
 725  010a a40f          	and	a,#15
 726  010c 5f            	clrw	x
 727  010d a401          	and	a,#1
 728  010f 5f            	clrw	x
 729  0110 5f            	clrw	x
 730  0111 97            	ld	xl,a
 731  0112 a30000        	cpw	x,#0
 732  0115 2704          	jreq	L44
 733  0117 ad82          	call	_WRITE_HIGH_BIT
 735  0119 2002          	jra	L64
 736  011b               L44:
 737  011b ad9a          	call	_WRITE_LOW_BIT
 739  011d               L64:
 740                     ; 201 	((red >> (3)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
 742  011d 7b01          	ld	a,(OFST+1,sp)
 743  011f 44            	srl	a
 744  0120 44            	srl	a
 745  0121 44            	srl	a
 746  0122 5f            	clrw	x
 747  0123 a401          	and	a,#1
 748  0125 5f            	clrw	x
 749  0126 5f            	clrw	x
 750  0127 97            	ld	xl,a
 751  0128 a30000        	cpw	x,#0
 752  012b 2705          	jreq	L05
 753  012d cd009b        	call	_WRITE_HIGH_BIT
 755  0130 2002          	jra	L25
 756  0132               L05:
 757  0132 ad83          	call	_WRITE_LOW_BIT
 759  0134               L25:
 760                     ; 202 	((red >> (2)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
 762  0134 7b01          	ld	a,(OFST+1,sp)
 763  0136 44            	srl	a
 764  0137 44            	srl	a
 765  0138 5f            	clrw	x
 766  0139 a401          	and	a,#1
 767  013b 5f            	clrw	x
 768  013c 5f            	clrw	x
 769  013d 97            	ld	xl,a
 770  013e a30000        	cpw	x,#0
 771  0141 2705          	jreq	L45
 772  0143 cd009b        	call	_WRITE_HIGH_BIT
 774  0146 2003          	jra	L65
 775  0148               L45:
 776  0148 cd00b7        	call	_WRITE_LOW_BIT
 778  014b               L65:
 779                     ; 203 	((red >> (1)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
 781  014b 7b01          	ld	a,(OFST+1,sp)
 782  014d 44            	srl	a
 783  014e 5f            	clrw	x
 784  014f a401          	and	a,#1
 785  0151 5f            	clrw	x
 786  0152 5f            	clrw	x
 787  0153 97            	ld	xl,a
 788  0154 a30000        	cpw	x,#0
 789  0157 2705          	jreq	L06
 790  0159 cd009b        	call	_WRITE_HIGH_BIT
 792  015c 2003          	jra	L26
 793  015e               L06:
 794  015e cd00b7        	call	_WRITE_LOW_BIT
 796  0161               L26:
 797                     ; 204 	((red >> (0)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();	
 799  0161 7b01          	ld	a,(OFST+1,sp)
 800  0163 5f            	clrw	x
 801  0164 a501          	bcp	a,#1
 802  0166 2705          	jreq	L46
 803  0168 cd009b        	call	_WRITE_HIGH_BIT
 805  016b 2003          	jra	L66
 806  016d               L46:
 807  016d cd00b7        	call	_WRITE_LOW_BIT
 809  0170               L66:
 810                     ; 206 	((blue >> (7)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
 812  0170 7b02          	ld	a,(OFST+2,sp)
 813  0172 49            	rlc	a
 814  0173 4f            	clr	a
 815  0174 49            	rlc	a
 816  0175 5f            	clrw	x
 817  0176 97            	ld	xl,a
 818  0177 a30000        	cpw	x,#0
 819  017a 2705          	jreq	L07
 820  017c cd009b        	call	_WRITE_HIGH_BIT
 822  017f 2003          	jra	L27
 823  0181               L07:
 824  0181 cd00b7        	call	_WRITE_LOW_BIT
 826  0184               L27:
 827                     ; 207 	((blue >> (6)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
 829  0184 7b02          	ld	a,(OFST+2,sp)
 830  0186 4e            	swap	a
 831  0187 44            	srl	a
 832  0188 44            	srl	a
 833  0189 a403          	and	a,#3
 834  018b 5f            	clrw	x
 835  018c a401          	and	a,#1
 836  018e 5f            	clrw	x
 837  018f 5f            	clrw	x
 838  0190 97            	ld	xl,a
 839  0191 a30000        	cpw	x,#0
 840  0194 2705          	jreq	L47
 841  0196 cd009b        	call	_WRITE_HIGH_BIT
 843  0199 2003          	jra	L67
 844  019b               L47:
 845  019b cd00b7        	call	_WRITE_LOW_BIT
 847  019e               L67:
 848                     ; 208 	((blue >> (5)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
 850  019e 7b02          	ld	a,(OFST+2,sp)
 851  01a0 4e            	swap	a
 852  01a1 44            	srl	a
 853  01a2 a407          	and	a,#7
 854  01a4 5f            	clrw	x
 855  01a5 a401          	and	a,#1
 856  01a7 5f            	clrw	x
 857  01a8 5f            	clrw	x
 858  01a9 97            	ld	xl,a
 859  01aa a30000        	cpw	x,#0
 860  01ad 2705          	jreq	L001
 861  01af cd009b        	call	_WRITE_HIGH_BIT
 863  01b2 2003          	jra	L201
 864  01b4               L001:
 865  01b4 cd00b7        	call	_WRITE_LOW_BIT
 867  01b7               L201:
 868                     ; 209 	((blue >> (4)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
 870  01b7 7b02          	ld	a,(OFST+2,sp)
 871  01b9 4e            	swap	a
 872  01ba a40f          	and	a,#15
 873  01bc 5f            	clrw	x
 874  01bd a401          	and	a,#1
 875  01bf 5f            	clrw	x
 876  01c0 5f            	clrw	x
 877  01c1 97            	ld	xl,a
 878  01c2 a30000        	cpw	x,#0
 879  01c5 2705          	jreq	L401
 880  01c7 cd009b        	call	_WRITE_HIGH_BIT
 882  01ca 2003          	jra	L601
 883  01cc               L401:
 884  01cc cd00b7        	call	_WRITE_LOW_BIT
 886  01cf               L601:
 887                     ; 210 	((blue >> (3)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
 889  01cf 7b02          	ld	a,(OFST+2,sp)
 890  01d1 44            	srl	a
 891  01d2 44            	srl	a
 892  01d3 44            	srl	a
 893  01d4 5f            	clrw	x
 894  01d5 a401          	and	a,#1
 895  01d7 5f            	clrw	x
 896  01d8 5f            	clrw	x
 897  01d9 97            	ld	xl,a
 898  01da a30000        	cpw	x,#0
 899  01dd 2705          	jreq	L011
 900  01df cd009b        	call	_WRITE_HIGH_BIT
 902  01e2 2003          	jra	L211
 903  01e4               L011:
 904  01e4 cd00b7        	call	_WRITE_LOW_BIT
 906  01e7               L211:
 907                     ; 211 	((blue >> (2)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
 909  01e7 7b02          	ld	a,(OFST+2,sp)
 910  01e9 44            	srl	a
 911  01ea 44            	srl	a
 912  01eb 5f            	clrw	x
 913  01ec a401          	and	a,#1
 914  01ee 5f            	clrw	x
 915  01ef 5f            	clrw	x
 916  01f0 97            	ld	xl,a
 917  01f1 a30000        	cpw	x,#0
 918  01f4 2705          	jreq	L411
 919  01f6 cd009b        	call	_WRITE_HIGH_BIT
 921  01f9 2003          	jra	L611
 922  01fb               L411:
 923  01fb cd00b7        	call	_WRITE_LOW_BIT
 925  01fe               L611:
 926                     ; 212 	((blue >> (1)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
 928  01fe 7b02          	ld	a,(OFST+2,sp)
 929  0200 44            	srl	a
 930  0201 5f            	clrw	x
 931  0202 a401          	and	a,#1
 932  0204 5f            	clrw	x
 933  0205 5f            	clrw	x
 934  0206 97            	ld	xl,a
 935  0207 a30000        	cpw	x,#0
 936  020a 2705          	jreq	L021
 937  020c cd009b        	call	_WRITE_HIGH_BIT
 939  020f 2003          	jra	L221
 940  0211               L021:
 941  0211 cd00b7        	call	_WRITE_LOW_BIT
 943  0214               L221:
 944                     ; 213 	((blue >> (0)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();	
 946  0214 7b02          	ld	a,(OFST+2,sp)
 947  0216 5f            	clrw	x
 948  0217 a501          	bcp	a,#1
 949  0219 2705          	jreq	L421
 950  021b cd009b        	call	_WRITE_HIGH_BIT
 952  021e 2003          	jra	L621
 953  0220               L421:
 954  0220 cd00b7        	call	_WRITE_LOW_BIT
 956  0223               L621:
 957                     ; 215 	((green >> (7)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
 959  0223 7b05          	ld	a,(OFST+5,sp)
 960  0225 49            	rlc	a
 961  0226 4f            	clr	a
 962  0227 49            	rlc	a
 963  0228 5f            	clrw	x
 964  0229 97            	ld	xl,a
 965  022a a30000        	cpw	x,#0
 966  022d 2705          	jreq	L031
 967  022f cd009b        	call	_WRITE_HIGH_BIT
 969  0232 2003          	jra	L231
 970  0234               L031:
 971  0234 cd00b7        	call	_WRITE_LOW_BIT
 973  0237               L231:
 974                     ; 216 	((green >> (6)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
 976  0237 7b05          	ld	a,(OFST+5,sp)
 977  0239 4e            	swap	a
 978  023a 44            	srl	a
 979  023b 44            	srl	a
 980  023c a403          	and	a,#3
 981  023e 5f            	clrw	x
 982  023f a401          	and	a,#1
 983  0241 5f            	clrw	x
 984  0242 5f            	clrw	x
 985  0243 97            	ld	xl,a
 986  0244 a30000        	cpw	x,#0
 987  0247 2705          	jreq	L431
 988  0249 cd009b        	call	_WRITE_HIGH_BIT
 990  024c 2003          	jra	L631
 991  024e               L431:
 992  024e cd00b7        	call	_WRITE_LOW_BIT
 994  0251               L631:
 995                     ; 217 	((green >> (5)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
 997  0251 7b05          	ld	a,(OFST+5,sp)
 998  0253 4e            	swap	a
 999  0254 44            	srl	a
1000  0255 a407          	and	a,#7
1001  0257 5f            	clrw	x
1002  0258 a401          	and	a,#1
1003  025a 5f            	clrw	x
1004  025b 5f            	clrw	x
1005  025c 97            	ld	xl,a
1006  025d a30000        	cpw	x,#0
1007  0260 2705          	jreq	L041
1008  0262 cd009b        	call	_WRITE_HIGH_BIT
1010  0265 2003          	jra	L241
1011  0267               L041:
1012  0267 cd00b7        	call	_WRITE_LOW_BIT
1014  026a               L241:
1015                     ; 218 	((green >> (4)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
1017  026a 7b05          	ld	a,(OFST+5,sp)
1018  026c 4e            	swap	a
1019  026d a40f          	and	a,#15
1020  026f 5f            	clrw	x
1021  0270 a401          	and	a,#1
1022  0272 5f            	clrw	x
1023  0273 5f            	clrw	x
1024  0274 97            	ld	xl,a
1025  0275 a30000        	cpw	x,#0
1026  0278 2705          	jreq	L441
1027  027a cd009b        	call	_WRITE_HIGH_BIT
1029  027d 2003          	jra	L641
1030  027f               L441:
1031  027f cd00b7        	call	_WRITE_LOW_BIT
1033  0282               L641:
1034                     ; 219 	((green >> (3)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
1036  0282 7b05          	ld	a,(OFST+5,sp)
1037  0284 44            	srl	a
1038  0285 44            	srl	a
1039  0286 44            	srl	a
1040  0287 5f            	clrw	x
1041  0288 a401          	and	a,#1
1042  028a 5f            	clrw	x
1043  028b 5f            	clrw	x
1044  028c 97            	ld	xl,a
1045  028d a30000        	cpw	x,#0
1046  0290 2705          	jreq	L051
1047  0292 cd009b        	call	_WRITE_HIGH_BIT
1049  0295 2003          	jra	L251
1050  0297               L051:
1051  0297 cd00b7        	call	_WRITE_LOW_BIT
1053  029a               L251:
1054                     ; 220 	((green >> (2)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
1056  029a 7b05          	ld	a,(OFST+5,sp)
1057  029c 44            	srl	a
1058  029d 44            	srl	a
1059  029e 5f            	clrw	x
1060  029f a401          	and	a,#1
1061  02a1 5f            	clrw	x
1062  02a2 5f            	clrw	x
1063  02a3 97            	ld	xl,a
1064  02a4 a30000        	cpw	x,#0
1065  02a7 2705          	jreq	L451
1066  02a9 cd009b        	call	_WRITE_HIGH_BIT
1068  02ac 2003          	jra	L651
1069  02ae               L451:
1070  02ae cd00b7        	call	_WRITE_LOW_BIT
1072  02b1               L651:
1073                     ; 221 	((green >> (1)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();
1075  02b1 7b05          	ld	a,(OFST+5,sp)
1076  02b3 44            	srl	a
1077  02b4 5f            	clrw	x
1078  02b5 a401          	and	a,#1
1079  02b7 5f            	clrw	x
1080  02b8 5f            	clrw	x
1081  02b9 97            	ld	xl,a
1082  02ba a30000        	cpw	x,#0
1083  02bd 2705          	jreq	L061
1084  02bf cd009b        	call	_WRITE_HIGH_BIT
1086  02c2 2003          	jra	L261
1087  02c4               L061:
1088  02c4 cd00b7        	call	_WRITE_LOW_BIT
1090  02c7               L261:
1091                     ; 222 	((green >> (0)) & 0x1) ? WRITE_HIGH_BIT() : WRITE_LOW_BIT();	
1093  02c7 7b05          	ld	a,(OFST+5,sp)
1094  02c9 5f            	clrw	x
1095  02ca a501          	bcp	a,#1
1096  02cc 2705          	jreq	L461
1097  02ce cd009b        	call	_WRITE_HIGH_BIT
1099  02d1 2003          	jra	L661
1100  02d3               L461:
1101  02d3 cd00b7        	call	_WRITE_LOW_BIT
1103  02d6               L661:
1104                     ; 224 	__asm("RIM"); // Enable interrupts again
1107  02d6 9a            RIM
1109                     ; 225 }
1112  02d7 85            	popw	x
1113  02d8 81            	ret
1136                     ; 230 void PC7_Init(void) {
1137                     	switch	.text
1138  02d9               _PC7_Init:
1142                     ; 232     GPIOC->DDR |= (1 << 7); // Data Direction Register: 1 = Output
1144  02d9 721e500c      	bset	20492,#7
1145                     ; 233     GPIOC->CR1 |= (1 << 7); // Control Register 1: Push-pull mode
1147  02dd 721e500d      	bset	20493,#7
1148                     ; 234     GPIOC->CR2 |= (1 << 7); // Control Register 2: High speed
1150  02e1 721e500e      	bset	20494,#7
1151                     ; 236 		GPIOC->ODR |= (1 << 7); //init high bc converter
1153  02e5 721e500a      	bset	20490,#7
1154                     ; 237 }
1157  02e9 81            	ret
1180                     ; 240 void TIM1_PWM_Init(void)
1180                     ; 241 {
1181                     	switch	.text
1182  02ea               _TIM1_PWM_Init:
1186                     ; 243 		SPI->CR1 = 0x00; // Disable SPI
1188  02ea 725f5200      	clr	20992
1189                     ; 244 		SPI->CR2 = 0x00;
1191  02ee 725f5201      	clr	20993
1192                     ; 246 		AFR[2] |= (1 << 6);  // Set PC6 alternate function (AFR for Port C)
1194  02f2 721c50e2      	bset	20706,#6
1195                     ; 249 		CLK->PCKENR1 |= (1 << CLK_PCKENR1_TIM1); 
1197  02f6 721050c7      	bset	20679,#0
1198                     ; 252     GPIOC->DDR |= (1 << 3);  // Set PC3 as output
1200  02fa 7216500c      	bset	20492,#3
1201                     ; 253     GPIOC->CR1 |= (1 << 3);  // Push-pull mode
1203  02fe 7216500d      	bset	20493,#3
1204                     ; 254     GPIOC->CR2 |= (1 << 3);  // Fast mode
1206  0302 7216500e      	bset	20494,#3
1207                     ; 257 		GPIOC->DDR |= (1 << 6);  // Set PC6 as output
1209  0306 721c500c      	bset	20492,#6
1210                     ; 258 		GPIOC->CR1 |= (1 << 6);  // Set PC6 to push-pull mode
1212  030a 721c500d      	bset	20493,#6
1213                     ; 259 		GPIOC->CR2 |= (1 << 6);  // Enable fast mode
1215  030e 721c500e      	bset	20494,#6
1216                     ; 262     GPIOC->DDR |= (1 << 4);  // Set PC4 as output
1218  0312 7218500c      	bset	20492,#4
1219                     ; 263     GPIOC->CR1 |= (1 << 4);  // Push-pull mode
1221  0316 7218500d      	bset	20493,#4
1222                     ; 264     GPIOC->CR2 |= (1 << 4);  // Fast mode
1224  031a 7218500e      	bset	20494,#4
1225                     ; 267     TIM1->CR1 = 0x00;
1227  031e 725f5250      	clr	21072
1228                     ; 270     TIM1->CR1 |= TIM1_CR1_CEN;  // Enable the counter
1230  0322 72105250      	bset	21072,#0
1231                     ; 273     TIM1->PSCRH = 0x00; // High byte of prescaler
1233  0326 725f5260      	clr	21088
1234                     ; 274     TIM1->PSCRL = 0x00; // Low byte of prescaler (prescaler = 1)
1236  032a 725f5261      	clr	21089
1237                     ; 277     TIM1->ARRH = 0x03;  // High byte (e.g., 0x03E8 for a 1 kHz PWM frequency)
1239  032e 35035262      	mov	21090,#3
1240                     ; 278     TIM1->ARRL = 0xE8;  // Low byte
1242  0332 35e85263      	mov	21091,#232
1243                     ; 281     TIM1->CCR3H = 0x01; // High byte
1245  0336 35015269      	mov	21097,#1
1246                     ; 282     TIM1->CCR3L = 0xF4; // Low byte (e.g., 0x01F4 for 50% of 0x03E8)
1248  033a 35f4526a      	mov	21098,#244
1249                     ; 285 		TIM1->CCR1H = 0x02; // High byte
1251  033e 35025265      	mov	21093,#2
1252                     ; 286 		TIM1->CCR1L = 0xBC; // Low byte
1254  0342 35bc5266      	mov	21094,#188
1255                     ; 289     TIM1->CCR4H = 0x02; // High byte
1257  0346 3502526b      	mov	21099,#2
1258                     ; 290     TIM1->CCR4L = 0xBC; // Low byte (e.g., 0x02BC for 75% of 0x03E8)
1260  034a 35bc526c      	mov	21100,#188
1261                     ; 293     TIM1->CCMR3 = TIM1_OCMODE_PWM1; // Set output compare mode to PWM1
1263  034e 3560525a      	mov	21082,#96
1264                     ; 294     TIM1->CCER2 |= TIM1_CCER2_CC3E; // Enable the output on Channel 3
1266  0352 7210525d      	bset	21085,#0
1267                     ; 297 		TIM1->CCMR1 = TIM1_OCMODE_PWM1; // Set output compare mode to PWM1
1269  0356 35605258      	mov	21080,#96
1270                     ; 298 		TIM1->CCER1 |= TIM1_CCER1_CC1E; // Enable the output on Channel 1
1272  035a 7210525c      	bset	21084,#0
1273                     ; 301     TIM1->CCMR4 = TIM1_OCMODE_PWM1; // Set output compare mode to PWM1
1275  035e 3560525b      	mov	21083,#96
1276                     ; 302     TIM1->CCER2 |= TIM1_CCER2_CC4E; // Enable the output on Channel 4
1278  0362 7218525d      	bset	21085,#4
1279                     ; 305     TIM1->BKR |= TIM1_BKR_MOE; // Enable main output
1281  0366 721e526d      	bset	21101,#7
1282                     ; 306     TIM1->CR1 |= TIM1_CR1_CEN; // Enable the timer counter
1284  036a 72105250      	bset	21072,#0
1285                     ; 308 }
1288  036e 81            	ret
1331                     ; 311 void set_LED1_PWM(uint8_t pwm)
1331                     ; 312 {
1332                     	switch	.text
1333  036f               _set_LED1_PWM:
1335  036f 89            	pushw	x
1336       00000002      OFST:	set	2
1339                     ; 316 	newValue = pwm*10;
1341  0370 97            	ld	xl,a
1342  0371 a60a          	ld	a,#10
1343  0373 42            	mul	x,a
1344  0374 1f01          	ldw	(OFST-1,sp),x
1346                     ; 318 	TIM1->CCR3H = (newValue >>8) & 0xFF; // High byte
1348  0376 7b01          	ld	a,(OFST-1,sp)
1349  0378 c75269        	ld	21097,a
1350                     ; 319 	TIM1->CCR3L = (newValue) & 0xFF; // Low byte (e.g., 0x01F4 for 50% of 0x03E8)
1352  037b 7b02          	ld	a,(OFST+0,sp)
1353  037d a4ff          	and	a,#255
1354  037f c7526a        	ld	21098,a
1355                     ; 320 }
1358  0382 85            	popw	x
1359  0383 81            	ret
1402                     ; 322 void set_LED2_PWM(uint8_t pwm)
1402                     ; 323 {
1403                     	switch	.text
1404  0384               _set_LED2_PWM:
1406  0384 89            	pushw	x
1407       00000002      OFST:	set	2
1410                     ; 327 	newValue = pwm*10;
1412  0385 97            	ld	xl,a
1413  0386 a60a          	ld	a,#10
1414  0388 42            	mul	x,a
1415  0389 1f01          	ldw	(OFST-1,sp),x
1417                     ; 329 	TIM1->CCR4H = (newValue >>8) & 0xFF; // High byte
1419  038b 7b01          	ld	a,(OFST-1,sp)
1420  038d c7526b        	ld	21099,a
1421                     ; 330 	TIM1->CCR4L = (newValue) & 0xFF; // Low byte (e.g., 0x01F4 for 50% of 0x03E8)
1423  0390 7b02          	ld	a,(OFST+0,sp)
1424  0392 a4ff          	and	a,#255
1425  0394 c7526c        	ld	21100,a
1426                     ; 331 }
1429  0397 85            	popw	x
1430  0398 81            	ret
1473                     ; 333 void set_LED3_PWM(uint8_t pwm)
1473                     ; 334 {
1474                     	switch	.text
1475  0399               _set_LED3_PWM:
1477  0399 89            	pushw	x
1478       00000002      OFST:	set	2
1481                     ; 338 	newValue = pwm*10;
1483  039a 97            	ld	xl,a
1484  039b a60a          	ld	a,#10
1485  039d 42            	mul	x,a
1486  039e 1f01          	ldw	(OFST-1,sp),x
1488                     ; 340 	TIM1->CCR1H = (newValue >>8) & 0xFF; // High byte
1490  03a0 7b01          	ld	a,(OFST-1,sp)
1491  03a2 c75265        	ld	21093,a
1492                     ; 341 	TIM1->CCR1L = (newValue) & 0xFF; // Low byte (e.g., 0x01F4 for 50% of 0x03E8)
1494  03a5 7b02          	ld	a,(OFST+0,sp)
1495  03a7 a4ff          	and	a,#255
1496  03a9 c75266        	ld	21094,a
1497                     ; 342 }
1500  03ac 85            	popw	x
1501  03ad 81            	ret
1566                     ; 344 void flash_fix(void) 
1566                     ; 345 {
1567                     	switch	.text
1568  03ae               _flash_fix:
1570  03ae 520b          	subw	sp,#11
1571       0000000b      OFST:	set	11
1574                     ; 347 		const uint32_t AFR_DATA_ADDRESS = 0x4803;
1576  03b0 ae4803        	ldw	x,#18435
1577  03b3 1f04          	ldw	(OFST-7,sp),x
1578  03b5 ae0000        	ldw	x,#0
1579  03b8 1f02          	ldw	(OFST-9,sp),x
1581                     ; 348     const uint32_t AFR_REQUIRED_VALUE = 0x1; // Enable TIM1_CH1 pin
1583  03ba ae0001        	ldw	x,#1
1584  03bd 1f08          	ldw	(OFST-3,sp),x
1585  03bf ae0000        	ldw	x,#0
1586  03c2 1f06          	ldw	(OFST-5,sp),x
1588                     ; 350     const uint16_t valueAndComplement = FLASH_ReadOptionByte(AFR_DATA_ADDRESS);
1590  03c4 1e04          	ldw	x,(OFST-7,sp)
1591  03c6 cd0000        	call	_FLASH_ReadOptionByte
1593  03c9 1f0a          	ldw	(OFST-1,sp),x
1595                     ; 351     const uint8_t currentValue = valueAndComplement >> 8;
1597  03cb 7b0a          	ld	a,(OFST-1,sp)
1598  03cd 6b01          	ld	(OFST-10,sp),a
1600                     ; 354     if (valueAndComplement == 0 || currentValue != AFR_REQUIRED_VALUE) {
1602  03cf 1e0a          	ldw	x,(OFST-1,sp)
1603  03d1 2713          	jreq	L113
1605  03d3 7b01          	ld	a,(OFST-10,sp)
1606  03d5 b703          	ld	c_lreg+3,a
1607  03d7 3f02          	clr	c_lreg+2
1608  03d9 3f01          	clr	c_lreg+1
1609  03db 3f00          	clr	c_lreg
1610  03dd 96            	ldw	x,sp
1611  03de 1c0006        	addw	x,#OFST-5
1612  03e1 cd0000        	call	c_lcmp
1614  03e4 2713          	jreq	L703
1615  03e6               L113:
1616                     ; 355         FLASH_Unlock(FLASH_MEMTYPE_DATA);
1618  03e6 a6f7          	ld	a,#247
1619  03e8 cd0000        	call	_FLASH_Unlock
1621                     ; 356         FLASH_ProgramOptionByte(AFR_DATA_ADDRESS, AFR_REQUIRED_VALUE);
1623  03eb 7b09          	ld	a,(OFST-2,sp)
1624  03ed 88            	push	a
1625  03ee 1e05          	ldw	x,(OFST-6,sp)
1626  03f0 cd0000        	call	_FLASH_ProgramOptionByte
1628  03f3 84            	pop	a
1629                     ; 357         FLASH_Lock(FLASH_MEMTYPE_DATA);
1631  03f4 a6f7          	ld	a,#247
1632  03f6 cd0000        	call	_FLASH_Lock
1634  03f9               L703:
1635                     ; 359 }
1638  03f9 5b0b          	addw	sp,#11
1639  03fb 81            	ret
1673                     ; 362 void parse_i2c_data(void) 
1673                     ; 363 {
1674                     	switch	.text
1675  03fc               _parse_i2c_data:
1679                     ; 364 	if(pwm_2700k != Slave_Buffer_Rx[0])
1681  03fc b604          	ld	a,_pwm_2700k
1682  03fe b100          	cp	a,_Slave_Buffer_Rx
1683  0400 2707          	jreq	L323
1684                     ; 366 		pwm_2700k = Slave_Buffer_Rx[0];
1686  0402 450004        	mov	_pwm_2700k,_Slave_Buffer_Rx
1687                     ; 367 		set_LED3_PWM(pwm_2700k);
1689  0405 b604          	ld	a,_pwm_2700k
1690  0407 ad90          	call	_set_LED3_PWM
1692  0409               L323:
1693                     ; 370 	if(pwm_5000k != Slave_Buffer_Rx[1])
1695  0409 b605          	ld	a,_pwm_5000k
1696  040b b101          	cp	a,_Slave_Buffer_Rx+1
1697  040d 2708          	jreq	L523
1698                     ; 372 		pwm_5000k = Slave_Buffer_Rx[1];
1700  040f 450105        	mov	_pwm_5000k,_Slave_Buffer_Rx+1
1701                     ; 373 		set_LED2_PWM(pwm_5000k);
1703  0412 b605          	ld	a,_pwm_5000k
1704  0414 cd0384        	call	_set_LED2_PWM
1706  0417               L523:
1707                     ; 376 	if(pwm_6500k != Slave_Buffer_Rx[2])
1709  0417 b606          	ld	a,_pwm_6500k
1710  0419 b102          	cp	a,_Slave_Buffer_Rx+2
1711  041b 2708          	jreq	L723
1712                     ; 378 		pwm_6500k = Slave_Buffer_Rx[2];
1714  041d 450206        	mov	_pwm_6500k,_Slave_Buffer_Rx+2
1715                     ; 379 		set_LED1_PWM(pwm_6500k);
1717  0420 b606          	ld	a,_pwm_6500k
1718  0422 cd036f        	call	_set_LED1_PWM
1720  0425               L723:
1721                     ; 382 	if(RGB_red != Slave_Buffer_Rx[3] || RGB_green != Slave_Buffer_Rx[4] || RGB_blue != Slave_Buffer_Rx[5])
1723  0425 b607          	ld	a,_RGB_red
1724  0427 b103          	cp	a,_Slave_Buffer_Rx+3
1725  0429 260c          	jrne	L333
1727  042b b608          	ld	a,_RGB_green
1728  042d b104          	cp	a,_Slave_Buffer_Rx+4
1729  042f 2606          	jrne	L333
1731  0431 b609          	ld	a,_RGB_blue
1732  0433 b105          	cp	a,_Slave_Buffer_Rx+5
1733  0435 2716          	jreq	L133
1734  0437               L333:
1735                     ; 384 		RGB_red 	= Slave_Buffer_Rx[3];
1737  0437 450307        	mov	_RGB_red,_Slave_Buffer_Rx+3
1738                     ; 385 		RGB_green = Slave_Buffer_Rx[4];
1740  043a 450408        	mov	_RGB_green,_Slave_Buffer_Rx+4
1741                     ; 386 		RGB_blue 	= Slave_Buffer_Rx[5];
1743  043d 450509        	mov	_RGB_blue,_Slave_Buffer_Rx+5
1744                     ; 387 		send_RGB_message(RGB_red,RGB_green,RGB_blue);
1746  0440 3b0009        	push	_RGB_blue
1747  0443 b608          	ld	a,_RGB_green
1748  0445 97            	ld	xl,a
1749  0446 b607          	ld	a,_RGB_red
1750  0448 95            	ld	xh,a
1751  0449 cd00c5        	call	_send_RGB_message
1753  044c 84            	pop	a
1754  044d               L133:
1755                     ; 390 }
1758  044d 81            	ret
1815                     ; 399 void main(void)
1815                     ; 400 {
1816                     	switch	.text
1817  044e               _main:
1819  044e 89            	pushw	x
1820       00000002      OFST:	set	2
1823                     ; 401 	uint8_t counter = 0;
1825                     ; 406 	bool timer_started = false;
1827  044f 0f02          	clr	(OFST+0,sp)
1829                     ; 409   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
1831  0451 4f            	clr	a
1832  0452 cd0000        	call	_CLK_HSIPrescalerConfig
1835  0455               L363:
1836                     ; 412 	while ((CLK->ICKR & CLK_ICKR_HSIRDY) == 0);
1838  0455 c650c0        	ld	a,20672
1839  0458 a502          	bcp	a,#2
1840  045a 27f9          	jreq	L363
1841                     ; 415   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
1843  045c 4b01          	push	#1
1844  045e 4b00          	push	#0
1845  0460 ae01e1        	ldw	x,#481
1846  0463 cd0000        	call	_CLK_ClockSwitchConfig
1848  0466 85            	popw	x
1849                     ; 418 	GPIO_Init_PD2();
1851  0467 cd0000        	call	_GPIO_Init_PD2
1853                     ; 419 	EXTI_Config();
1855  046a cd000d        	call	_EXTI_Config
1857                     ; 421 	initI2c();
1859  046d cd002f        	call	_initI2c
1861                     ; 423 	PC7_Init();
1863  0470 cd02d9        	call	_PC7_Init
1865                     ; 427   enableInterrupts();
1868  0473 9a            rim
1870                     ; 430 	TIM1_PWM_Init();
1873  0474 cd02ea        	call	_TIM1_PWM_Init
1875                     ; 432 	set_LED1_PWM(2); //6500
1877  0477 a602          	ld	a,#2
1878  0479 cd036f        	call	_set_LED1_PWM
1880                     ; 433 	set_LED2_PWM(2); //5000
1882  047c a602          	ld	a,#2
1883  047e cd0384        	call	_set_LED2_PWM
1885                     ; 434 	set_LED3_PWM(2); //2700
1887  0481 a602          	ld	a,#2
1888  0483 cd0399        	call	_set_LED3_PWM
1890  0486               L763:
1891                     ; 442 		if(I2C_data_received)
1893  0486 3d03          	tnz	_I2C_data_received
1894  0488 27fc          	jreq	L763
1895                     ; 444 			parse_i2c_data();
1897  048a cd03fc        	call	_parse_i2c_data
1899                     ; 445 			I2C_data_received = 0;
1901  048d 3f03          	clr	_I2C_data_received
1902  048f 20f5          	jra	L763
1937                     ; 459 void assert_failed(uint8_t* file, uint32_t line)
1937                     ; 460 {
1938                     	switch	.text
1939  0491               _assert_failed:
1943  0491               L314:
1944  0491 20fe          	jra	L314
2049                     	xdef	_main
2050                     	xdef	_parse_i2c_data
2051                     	xdef	_flash_fix
2052                     	xdef	_set_LED3_PWM
2053                     	xdef	_set_LED2_PWM
2054                     	xdef	_set_LED1_PWM
2055                     	xdef	_TIM1_PWM_Init
2056                     	xdef	_PC7_Init
2057                     	xdef	_send_RGB_message
2058                     	xdef	_WRITE_LOW_BIT
2059                     	xdef	_WRITE_HIGH_BIT
2060                     	xdef	_tim1_disable
2061                     	xdef	_tim1_enable
2062                     	xdef	_tim1_init
2063                     	xdef	_initI2c
2064                     	xdef	_I2C_interrupt_init
2065                     	xdef	_EXTI_Config
2066                     	xdef	_GPIO_Init_PD2
2067                     	xdef	_RGB_blue
2068                     	xdef	_RGB_green
2069                     	xdef	_RGB_red
2070                     	xdef	_pwm_6500k
2071                     	xdef	_pwm_5000k
2072                     	xdef	_pwm_2700k
2073                     	xref.b	_Slave_Buffer_Rx
2074                     	xdef	_I2C_data_received
2075                     	xdef	_RGB_high_count
2076                     	xdef	_RGB_total_count
2077                     	xdef	_address_found
2078                     	xdef	_assert_failed
2079                     	xref	_FLASH_ProgramOptionByte
2080                     	xref	_FLASH_ReadOptionByte
2081                     	xref	_FLASH_Lock
2082                     	xref	_FLASH_Unlock
2083                     	xref	_CLK_HSIPrescalerConfig
2084                     	xref	_CLK_ClockSwitchConfig
2085                     	xref.b	c_lreg
2104                     	xref	c_lcmp
2105                     	end
