#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
	DDRB = 0b00001000;      //ATtiny26 pin.4 PB3 OUT

	while(1){
		PORTB ^= _BV(3);
		_delay_ms(1000);
	}

	return 0;
}

/*
                                   ATtiny26
                                 +-----------+
                           SCLK -|1        20|- 
                           MISO -|2        19|- 
                           MOSI -|3        18|- 
                            PB3 -|4        17|- 
                            VCC -|5        16|- GND
                            GND -|6        15|- VCC
                                -|7        14|- 
                                -|8        13|- 
                          _____ -|9        12|- 
                          RESET -|10       11|- 
                                 +-----------+
*/
