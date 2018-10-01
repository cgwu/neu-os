.code16

.global _bootstart

.equ BOOTSEG, 0x07c0

# 16-real mode
# SEG:OFFSET e.g.: 0x7c0:0x0000 -> SEG<<4 + OFFSET = 0x7c00

ljmp $BOOTSEG, $_bootstart

_bootstart:
	jmp _bootstart


# Padding code segment (using 0) to 510 bytes.
.= 510

# For bootloader find this section.
signature:
	.word 0xaa55

