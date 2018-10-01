.code16

.global _bootstart

.equ BOOTSEG, 0x07c0

# 16-real mode
# SEG:OFFSET e.g.: 0x7c0:0x0000 -> SEG<<4 + OFFSET = 0x7c00

.text
ljmp $BOOTSEG, $_bootstart

_bootstart:
	# Get cursor position
	mov $0x03, %ah
	int $0x10

	# Write string
	mov $BOOTSEG, %ax
	mov %ax, %es
	mov $_string, %bp
	mov $0x1301, %ax
	mov $0x0006, %bx
	mov $len, %cx
	int $0x10
loop:  jmp loop


_string:
	.ascii "Hello Bootloader!\r\n"
	.byte 13,10,13,10
len = . - _string 

# Padding code segment (using 0) to 510 bytes.
.= 510

# For bootloader find this section.
signature:
	.word 0xaa55

