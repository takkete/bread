#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
	DDRB = 0b00001000;      //ATtiny85 pin.15 PB3 OUT

	while(1){
		PORTB ^= _BV(3);
		_delay_ms(1000);
	}

	return 0;
}

/*
                                   ATtiny85
                          _____  +-----------+
                          RESET -|1         8|- VCC
                            PB3 -|2         7|- SCLK
                                -|3         6|- MISO
                            GND -|4         5|- MOSI
                                 +-----------+
*/
