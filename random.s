/* ***************************************************************** 
   random.s
   Subrutina para calcular numeros aleatorios, maximo, minimo, promedio y normalizar
   
  Rodrigo Arriaza 15334
  Davis Alvarez
   ***************************************************************** */
   
.global lfsr
	
/* empieza subrutina de numeros random */
	@ entrada:
	@ r0 : vector
	@ r1: size del vector
	@ r2: semilla
	
	@salida
	@r0 vector con numeros random
	
lfsr:
		mov r3, r1 
		ldr R6, =0x80200003	@este numero sale del polinomio 32, 22, 2, 1
		mov r7, #0 @r7 es el contador
		
	elcicloide:
			@se sigue el algoritmo de Galois tomado de Wikipedia
			and r1, r2, #1 		@ R1=LSB
			lsr r2, r2, #1 			@ Shift register
			cmp r1, #0 			
			eorne r2, r2, R6 		@ xor de lfsr con el polinomio si LSB = 1
			
			@aqui se convierte de int a float
			vmov s0, r2
			vcvt.f32.s32 s0, s0 
			
			@aqui se guarda el el vector que esta en r0
			vstr s0, [r0]
			add r0, r0, #4
			
			@aumenta el contador y  compara si ya llego al tamano deseado
			adds r7, r7, #1
			cmp r3, r7
			bne elcicloide
		@ Salir de la subrutina
		mov pc, lr
/* termina subrutina para random */

/*subrutina para imprimir */
	.global printVec
printVec:
@en r1 viene el tamano
@en r0 viene la direccion del vector
	mov r6, #0 @inicializar contador en 0
	mov r7, r0 @guardar vector en r7
	mov r10, lr @guardo en r10 el link register para que no se pierda en las subrutinas
		imp:	
			vldr s0, [r7]
			add r7, #4
			vcvt.f64.f32 d1, s0
			vmov r2, r3, d1
			ldr r0, =ffloat
			@ se guardan r0-r3 para evitar errores
			push {r0-r3}
			bl printf 
			pop {r0-r3}
		@incrementar contador y verificar si ya se llego a 10
			add r6, #1
			cmp r6, r1 @ Comparar con el tamano
			bne imp
	exit:
		mov lr, r10
		mov pc, lr
/* termina subrutina para imprimir */

	.data
ffloat:	.asciz "%f\n"
