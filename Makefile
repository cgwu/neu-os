all: Image

.PHONY=clean

run: bootimg
	@qemu-system-i386 -boot a -fda bootimg

run_debug: bootimg
	@qemu-system-i386 -boot a -fda bootimg -S -s

# @suppress output cmd.
bootsect: bootsect.s ld-bootsect.ld
	- as --32 bootsect.s -o bootsect.o
	- ld -T ld-bootsect.ld bootsect.o -o bootsect
	- objcopy -O binary -j .text bootsect

demo: demo.s
	@as --32 -n -g -o demo.o demo.s
	@ld -T ld-bootsect.ld demo.o -o demo
	@objcopy -O binary -j .text demo

bootimg: demo bootsect
	@dd if=bootsect of=bootimg bs=512 count=1
	@dd if=demo of=bootimg bs=512 count=4 seek=1
	@echo "Build bootimg done"


clean:
	- rm -f *.o bootsect demo

