hello: hello.c
	avr-gcc -O2 -mmcu=attiny2313 -DF_CPU=1000000UL -c -o hello.o hello.c
	avr-gcc -O2 -mmcu=attiny2313 hello.o -o hello
	avr-objcopy -j .text -j .data -O ihex hello hello.hex

write:
	avrdude -p t2313 -c linuxgpio -U flash:w:hello.hex

clean:
	rm -f hello.o hello.hex hello

