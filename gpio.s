@ Equates
.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb


.equ RCC_AHB2,           0x40021000      @ reset register
.equ RCC_AHB2ENR_OFS,    0x4C            @ enable clock
.equ RCC_AHB2_RESET,      0x00000000

.equ GPIOA,              0x48000000      @ base address GPIOA

.equ MODER_OFS,          0x00
.equ MODER_RESET,        0xFFFFFFFF

.equ OTYPER_RESET,       0x00000000
.equ OTYPER_OFS,         0x04

.equ OSPEEDR_RESET,      0x00000000
.equ OSPEEDR_OFS,        0x08

.equ PUPDR_RESET,        0x00000000
.equ PUPDR_OFS,          0x0C

.equ ODR_RESET,          0x00000000
.equ ODR_OFS,            0x14
