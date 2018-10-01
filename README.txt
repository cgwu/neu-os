#汇编
as --32 bootsect.s

#查看反汇编
objdump -S bootsect.o
#以8086模式查看反汇编
objdump -m i8086 -S bootsect.o

查看而进制文件内容：
hexdump -C bootsect.o

只保留.text段代码：
objcopy -O binary bootsect.o

objdump --section-headers bootsect
bootsect:     file format elf32-i386
Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .TEXT         00000200  00000000  00000000  00200000  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, CODE


提取出.text段：
objcopy -O binary -j .text bootsect





(end)

