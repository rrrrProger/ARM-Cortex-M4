.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.global vtable
.global reset_handler
.global sum

vtable:
	.word _estack
	.word reset_handler
	.word 0
	.word hardfault
	@ .size vtable, .-vtable

sum:
    ldr r0, =array
    mov r1, #0
    mov r2, #0

loop:
    ldr r3, [r0]
    add r0, r0, #4
    add r2, r2, r3
    add r1, r1, #1
    cmp r1, #6
    bne loop
    bx lr

sum_stack:
    mov r2, #0

    pop {r1}

loop_stack:
    pop {r0}

    add r2, r2, r0
    sub r1, r1, #1
    cmp r1, #0
    bne loop_stack

    bx lr

hardfault:
	b hardfault

reset_handler:
	ldr r0, =_estack
	mov sp, r0

	ldr r0, =_dstart
	ldr r1, =_dend

	sub r2,r1,r0

	ldr r1, =_flash_dstart

cpy_loop:
    ldrb r3, [r1]
    strb r3, [r0]

    add r1, r1, #1
    add r0, r0, #1

    sub r2, r2, #1
    cmp r2, #0
    bne cpy_loop

main:
    mov r2, #1
    mov r3, #0

    mov r0, 0x03
    push {r0}

    mov r0, 0x01
    push {r0}

    mov r0, 0x56
    push {r0}

    mov r0, 0x12
    push {r0}

    mov r0, 0x42
    push {r0}

    mov r0, 0x05
    push {r0}

    bl sum_stack

done:
	b done

	.data

array: .word 0xAB, 0x03, 0x01, 0x56, 0x12, 0x42

