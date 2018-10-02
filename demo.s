.code16

.global show_text

.equ DEMOSEG, 0x1020

.text

show_text:
	# Get cursor position
	mov $0x03, %ah
	xor %bh, %bh
	int $0x10

	# Write string
	mov $DEMOSEG, %ax
	mov %ax, %es
	mov $msg, %bp
	mov $0x1301, %ax
	mov $0x000a, %bx
	mov $len, %cx
	int $0x10

loop:  jmp loop


msg:
	.byte 13,10
	.ascii "You've successfully load the floppy data into RAM"
	.byte 13,10,13,10
len = . - msg 

