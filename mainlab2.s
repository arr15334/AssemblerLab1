@**************************************************************
@	Laboratorio 2 
@	Rodrigo Arriaza y Sebastian Galindo
@ 	Temario 2: Control de intensidad de volumen
@**************************************************************


	.text
	.align 2
	.global main
		main: 
		@virtual address
		bl GetGpioAddress
		
		@ configurar puertos de salida
		@Puertos: 12, 16, 20, 21 y 26 para la bocina
		mov r0, #12
		mov r1, #1
		bl SetGpioFunction
		mov r0, #16
		mov r1, #1
		bl SetGpioFunction
		mov r0, #20
		mov r1, #1
		bl SetGpioFunction
		mov r0, #21
		mov r1, #1
		bl SetGpioFunction
		mov r0, #26
		mov r1, #1
		bl SetGpioFunction
		
		@configurar puertos de entrada
		@puertos de entrada: 18, 23, 24
		mov r0, #18 @subir volumen
		mov r1, #0
		bl SetGpioFunction
		mov r0, #23 @bajar volumen
		mov r1, #0
		bl SetGpioFunction
		mov r0, #24 @seleccionar vol predefinido
		mov r1, #0
		bl SetGpioFunction
		
		elcicloide:
		@ aqui va el codigo. El registro R11 se usa como un contador
		mov R11, #0 @cont principal
		mov r10, #0
			@iniciar en volumen 0 (todos los leds apagados)
			mov r0, #12
			mov r1, #0
			bl SetGpio
			mov r0, #16
			mov r1, #0
			bl SetGpio
			mov r0, #20
			mov r1, #0
			bl SetGpio
			mov r0, #21
			mov r1, #0
			bl SetGpio
			mov r0, #26
			mov r1, #0
			bl SetGpio
		elciclon:
		@ revisar los puertos
		@puerto subida
			mov r0, #18
			bl GetGpio
			cmp r0, #0
			@aumentar el contador
			addne r11, #1
			bl wait
		@puerto bajada
			mov r0, #23
			bl GetGpio
			cmp r0, #0
			@disminuir el contador
			subne r11, #1 @se decrementa el contador si se presiona
		
		@boton de guardar
			mov r0, #24
			bl GetGpio
			cmp r0, #0
			addne r10,#4
			movne r0, r10
			blne selectSaved
			cmp r10, #16
			moveq r10, #0
			
			@verificar los conts
			cmp r11, #0
			beq elcicloide
			movlt r11, #0
			
			cmp r11, #1
			bleq unoL
			cmp r11, #2
			bleq dosL
			cmp r11, #3
			bleq tresL
			cmp r11, #4
			bleq cuatroL
			cmp r11, #5
			bleq cincoL
			cmp r11, #6
			bleq seisL
			cmp r11, #7
			bleq sieteL
			cmp r11, #8
			bleq ochoL
			cmp r11, #9
			bleq nueveL
			cmp r11, #10
			bleq diezL
			cmp r11, #11
			bleq onceL
			cmp r11, #12
			bleq doceL
			cmp r11, #13
			bleq treceL
			cmp r11, #14
			bleq catorceL
			cmp r11, #15
			bleq quinceL
			movgt r11, #15
			@bl wait
		b elciclon
		
		@subrutina para guardar un volumen, falta agregar que se puedan guardar mas volumenes
		@en r0 viene el corrimiento, en r1 el numero a guardar
		guardarVolumen: 
			ldr r9, =saved
			str r1, [r9, r0]!
			mov pc, lr
			
		unoL:
			@encender los leds correspondientes
		mov r0, #12
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #16
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #20
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #21
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
			@encender la bocina en volumen 1
			lup1:
			mov r0, #26
			mov r1, #1
			push {lr}
			bl SetGpio
			pop {lr}
			push {lr}
			bl wait
			pop {lr}
			mov r0, #26
			mov r1, #0
			push {lr}
			bl SetGpio
			pop {lr}

			mov r0, #18
			push {lr}
			bl GetGpio
			pop {lr}
			cmp r0, #0
			@aumentar el contador
			addne r11, #1
			
			@puerto bajada
			mov r0, #23
			push {lr}
			bl GetGpio
			pop {lr}
			cmp r0, #0
			@disminuir el contador
			bne elcicloide 
			
			push {lr}
			mov r0, #10
			bl delayBuzzer
			pop {lr}
			
			cmp r11, #1
			bne elciclon
			b lup1
		mov pc, lr
		@***********************************************************************************
		dosL:
		mov r0, #12
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #16
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #20
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #21
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #26
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov pc, lr
		
		tresL:
		mov r0, #12
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #16
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #20
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #21
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov pc, lr
		
		cuatroL:
		mov r0, #12
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #16
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #20
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #21
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov pc, lr
		
		@**************************************************************************************
		cincoL:
		mov r0, #12
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #16
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #20
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #21
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		@encender bocina volumen 4
			lup5:
			mov r0, #26
			mov r1, #1
			push {lr}
			bl SetGpio
			pop {lr}
			push {lr}
			bl wait
			pop {lr}
			mov r0, #26
			mov r1, #0
			push {lr}
			bl SetGpio
			pop {lr}

			mov r0, #18
			push {lr}
			bl GetGpio
			pop {lr}
			cmp r0, #0
			@aumentar el contador
			addne r11, #1
			
			@puerto bajada
			mov r0, #23
			push {lr}
			bl GetGpio
			pop {lr}
			cmp r0, #0
			@disminuir el contador
			bne elcicloide 
			
			push {lr}
			mov r0, #5
			bl delayBuzzer
			pop {lr}
			
			cmp r11, #1
			bne elciclon
			b lup5
		mov pc, lr
		
		seisL:
		mov r0, #12
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #16
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #20
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #21
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov pc, lr
		
		sieteL:
		mov r0, #12
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #16
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #20
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #21
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov pc, lr
		
		ochoL:
		mov r0, #12
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #16
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #20
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #21
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov pc, lr
		
		nueveL:
		mov r0, #12
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #16
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #20
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #21
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov pc, lr
		@********************************************************************	10
		diezL:
		mov r0, #12
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #16
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #20
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #21
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		
		lup10:
			mov r0, #26
			mov r1, #1
			push {lr}
			bl SetGpio
			pop {lr}
			push {lr}
			bl wait
			pop {lr}
			mov r0, #26
			mov r1, #0
			push {lr}
			bl SetGpio
			pop {lr}

			mov r0, #18
			push {lr}
			bl GetGpio
			pop {lr}
			cmp r0, #0
			@aumentar el contador
			addne r11, #1
			
			@puerto bajada
			mov r0, #23
			push {lr}
			bl GetGpio
			pop {lr}
			cmp r0, #0
			@disminuir el contador
			bne elcicloide 
			
			push {lr}
			mov r0, #1
			bl delayBuzzer
			pop {lr}
			
			cmp r11, #10
			bne elciclon
			b lup10
		mov pc, lr
		@*************************************************************	11
		onceL:
		mov r0, #12
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #16
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #20
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #21
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov pc, lr
		
		doceL:
		mov r0, #12
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #16
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #20
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #21
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov pc, lr
		
		treceL:
		mov r0, #12
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #16
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #20
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #21
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov pc, lr
		
		catorceL:
		mov r0, #12
		mov r1, #0
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #16
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #20
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #21
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov pc, lr
		
@numero 15 en binario
		quinceL:
		mov r0, #12
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #16
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #20
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #21
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		mov r0, #26
		mov r1, #1
		push {lr}
		bl SetGpio
		pop {lr}
		@encender bocina volumen 4
			lup15:
			mov r0, #26
			mov r1, #1
			push {lr}
			bl SetGpio
			pop {lr}
			push {lr}
			bl wait
			pop {lr}
			mov r0, #26
			mov r1, #1
			push {lr}
			bl SetGpio
			pop {lr}

			mov r0, #18
			push {lr}
			bl GetGpio
			pop {lr}
			cmp r0, #0
			@aumentar el contador
			addne r11, #1
			
			@puerto bajada
			mov r0, #23
			push {lr}
			bl GetGpio
			pop {lr}
			cmp r0, #0
			@disminuir el contador
			subne r11, #1 
			
			push {lr}
			mov r0, #0
			bl delayBuzzer
			pop {lr}
			cmp r11, #15
			bne elciclon
			b lup15		
		mov pc, lr
		
		@subrutina para un delay
		wait:
			 mov r0, #0x8800000 @ big number
			sleepLoop:
			 subs r0,#1
			 bne sleepLoop @ loop delay
			 mov pc,lr
			 
		delayBuzzer:
			@en r0 viene un numero grande
			ldr r5, =bign
			ldr r5, [r5]
			mul r6, r0, r5
			lupz:
			 subs r6,#1
			 bne lupz @ loop delay
			 mov pc,lr
			 
		selectSaved:
		@en r0 viene el contador 
			ldr r9, =saved
			ldr r8, [r9, r0]
			mov r11, r8
			mov pc, lr
		
		.data
			.global myloc
			myloc: .word 0
			saved: .word	0, 1, 5, 10
			bign: .word 50000000
			