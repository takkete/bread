test: test.c
	avr-gcc -O2 -mmcu=attiny2313 -DF_CPU=1000000UL -c -o test.o test.c
	avr-gcc -O2 -mmcu=attiny2313 test.o -o test
	avr-objcopy -j .text -j .data -O ihex test test.hex

testwrite:
	avrdude -p t2313 -c linuxgpio -U flash:w:test.hex

clean:
	rm test.o test.hex test
