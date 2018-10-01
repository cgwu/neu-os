all: Image

.PHONY=clean run-qemu

run-qemu:
	@qemu-system-i386 -boot a -fda bootsect.o	

# @suppress output cmd.
bootsect.o:
	- as --32 bootsect.s -o bootsect.o


clean:
	- rm -f *.o

