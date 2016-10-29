hello: hello.c
	avr-gcc -O2 -mmcu=attiny85 -DF_CPU=1000000UL -c -o hello.o hello.c
	avr-gcc -O2 -mmcu=attiny85 hello.o -o hello
	avr-objcopy -j .text -j .data -O ihex hello hello.hex

write:
	avrdude -p t85 -c linuxgpio -U flash:w:hello.hex;echo DONE

clean:
	rm hello.o hello.hex hello
