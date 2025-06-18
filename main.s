.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.global vtable
.global reset_handler

vtable:
	.word _estack
	.word reset_handler
	.word 0
	.word hardfault
	@ .size vtable, .-vtable


.equ  BootRAM,        0xF1E0F85F

hardfault:
	b hardfault

reset_handler:
	ldr r0, =_estack
	mov sp, r0

	ldr r0, =_dstart
	ldr r1, =_dend

	sub r2,r1,r0

	ldr r1, =_flash_dstart

main:
	ldr r9, =apa
	ldr r9, [r9]

	ldr r7, =0xF00DF00D
	ldr r8, =0x1337BEEF

done:
	b done

	.data

apa:	.word 0xffaabbcc
