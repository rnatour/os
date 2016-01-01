global loader

	MAGIC_NUMBER equ 0xDEADBEEF
	FLAGS equ 0x0
	CHECKSUM equ -(MAGIC_NUMBER + FLAGS)

section .text
align 4
	dd MAGIC_NUMBER
	dd FLAGS
	dd CHECKSUM

loader:
	mov eax, 0xB00B

loop:
	jmp loop