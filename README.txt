#汇编
as --32 bootsect.s

#查看反汇编
objdump -S bootsect.o
#以8086模式查看反汇编
objdump -m i8086 -S bootsect.o



