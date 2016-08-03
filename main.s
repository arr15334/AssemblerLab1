/* ***************************************************************** 
   mainMencion.s
   Programa principal que pide datos y muestra los resultados 
   
  Rodrigo Arriaza 15334
  Davis Alvarez 15
   ***************************************************************** */
.global main
	.func main
main:
	ldr r0,=bienvenida
	bl puts
	ldr r0, =pedirDato
	bl puts
	ldr r0, =formato
	ldr r1, =semilla
	bl scanf
	
	ldr r0, =vector
	ldr r1, =size
	ldr r1, [r1]
	ldr r2, =semilla
	ldr r2, [r2]
	bl lfsr

/*aqui se mandan a imprimir para verificar los numeros aleatorios */
	ldr r0, =vector
	mov r1, #10 @10 para mostrar los primeros 10 numeros
	bl printVec	

salida: 	
	mov r7, #1
	swi 0

	.data
vector:	 .space 128 * 32
size:	 .word 128
semilla:	.word 0
pedirDato:	.asciz "Por favor ingrese un numero entero diferente de cero\n"
bienvenida:	.asciz "Bienvenido al programa de numeros aleatorios.\n"
formato:	.asciz "%d"
