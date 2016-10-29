#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
	DDRB = 0b00001000;      //ATtiny2313 pin.15 PB3 OUT

	while(1){
		PORTB ^= _BV(3);
		_delay_ms(1000);
	}

	return 0;
}

/*
                                  ATtiny2313
                          _____  +-----------+
                          RESET -|1        20|- VCC
                                -|2        19|- USCLK
                                -|3        18|- MISO
                                -|4        17|- MOSI
                                -|5        16|- 
                                -|6        15|- PB3
                                -|7        14|- 
                                -|8        13|- 
                                -|9        12|- 
                            GND -|10       11|- 
                                 +-----------+
*/
