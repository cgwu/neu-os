all: Image

.PHONY=clean

# @suppress output cmd.
bootsect.o:
	- as --32 bootsect.s -o bootsect.o


clean:
	- rm -f *.o

