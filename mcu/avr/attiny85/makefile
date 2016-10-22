test: test.c
	avr-gcc -O2 -mmcu=attiny85 -DF_CPU=1000000UL -c -o test.o test.c
	avr-gcc -O2 -mmcu=attiny85 test.o -o test
	avr-objcopy -j .text -j .data -O ihex test test.hex

testwrite:
	avrdude -p t85 -c linuxgpio -U flash:w:test.hex;echo DONE

clean:
	rm test.o test.hex test
