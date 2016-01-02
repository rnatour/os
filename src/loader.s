global loader

MAGIC_NUMBER equ 0x1BADB002
FLAGS equ 0x0
CHECKSUM equ -(MAGIC_NUMBER + FLAGS)
KERNEL_STACK_SIZE equ 4096

extern kmain

section .bss
align 4
kernel_stack:
	resb KERNEL_STACK_SIZE

section .text
align 4
	dd MAGIC_NUMBER
	dd FLAGS
	dd CHECKSUM
	dd KERNEL_STACK_SIZE

loader:
	jmp setup
after_setup:
	push dword 0x3
	push dword 0x2
	push dword 0x1
	call kmain

loop:
	jmp loop

setup:
	mov esp, kernel_stack + KERNEL_STACK_SIZE
	jmp after_setup

