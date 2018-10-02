.code16

.global _bootstart

.equ BOOTSEG, 0x07c0
.equ DEMOSEG, 0x1000

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

load_demo:
	# 将软盘中内容加载到内存，并且跳转到相应地址执行代码
	mov $0x0000, %dx	# 选择磁盘号0，磁头号0
	mov $0x0002, %cx	# 从二号扇区（从1开始），0轨道开始读
	mov $DEMOSEG, %ax	
	mov %ax, %es		# ES:BX指向装载目的地址
	mov $0x0200, %bx
	mov $02, %ah		# Service 2: Read Disk Sectors
	mov $4, %al			# 读取的扇区数
	int $0x13			# BIOS interrupt read disk
	jnc demo_load_ok	# load successfully, no except.
	jmp load_demo		# try again until success

demo_load_ok:
	mov $DEMOSEG, %ax
	mov %ax, %ds
	ljmp $0x1020,$0		# jmp to where the demo program exists.

_string:
	.ascii "Hello Bootloader!\r\n"
	.byte 13,10,13,10
len = . - _string 

# Padding code segment (using 0) to 510 bytes.
.= 510

# For bootloader find this section.
signature:
	.word 0xaa55

