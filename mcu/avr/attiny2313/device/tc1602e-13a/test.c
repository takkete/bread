#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
	DDRB = 0b11111111;      //ATtiny2313 pin.12-19 PB0-7 OUT
	DDRD = 0b00000111;      //ATtiny2313 pin.2,3,6 PD0-2 OUT

	PORTD = 0b00000000;	//RS(PD0)=L,R/W(PD1)=L,E(PD2)=L

	// After power on
	_delay_ms(41);

	// Function Set(8bit mode) 1st
	PORTB = 0b00111000;
	PORTD = 0b00000000;	//RS(PD0)=L R/W(PD1)=L
	_delay_us(1);
	PORTD = 0b00000100;	//E(PD2)=H
	_delay_us(1);
	PORTD = 0b00000000;	//E(PD2)=L
	_delay_ms(5);		//more than 4.1ms

	// Function Set(8bit mode) 2nd
	PORTD = 0b00000100;	//E(PD2)=H
	_delay_us(1);
	PORTD = 0b00000000;	//E(PD2)=L
	_delay_us(100);		//more than 100us

	// Function Set(8bit mode) 3rd
	PORTD = 0b00000100;	//E(PD2)=H
	_delay_us(1);
	PORTD = 0b00000000;	//E(PD2)=L
	_delay_us(40);		//more than 38us

	// Function Set(Rows and Fonts)
	PORTB = 0b00110100;
	_delay_us(1);
	PORTD = 0b00000100;	//E(PD2)=H
	_delay_us(1);
	PORTD = 0b00000000;	//E(PD2)=L
	_delay_us(40);		//more than 38us

	// Display OFF
	PORTB = 0b00001000;
	_delay_us(1);
	PORTD = 0b00000100;	//E=1(PD2)=H
	_delay_us(1);
	PORTD = 0b00000000;	//E=0(PD2)=L
	_delay_us(40);		//more than 38us

	// Clear Display
	PORTB = 0b00000001;
	_delay_us(1);
	PORTD = 0b00000100;	//E=1(PD2)=H
	_delay_us(1);
	PORTD = 0b00000000;	//E=0(PD2)=L
	_delay_ms(2);		//more than 1.52ms

	// Entry Mode Set(Cursor and Shift)
	PORTB = 0b00000110;
	_delay_us(1);
	PORTD = 0b00000100;	//E=1(PD2)=H
	_delay_us(1);
	PORTD = 0b00000000;	//E=0(PD2)=L
	_delay_us(40);		//more than 38us

	// Display ON
	PORTB = 0b00001111;
	_delay_us(1);
	PORTD = 0b00000100;	//E=1(PD2)=H
	_delay_us(1);
	PORTD = 0b00000000;	//E=0(PD2)=L
	_delay_us(40);		//more than 38us

	// Write Data
	PORTB = 'H';
	PORTD = 0b00000001;	//RS(PD0)=H
	_delay_us(1);
	PORTD = 0b00000101;	//RS(PD0)=H,E(PD2)=H
	_delay_us(1);
	PORTD = 0b00000001;	//RS(PD0)=H,E(PD2)=L
	_delay_us(40);		//more than 38us

	// Write Data
	PORTB = 'E';
	PORTD = 0b00000001;	//RS(PD0)=H
	_delay_us(1);
	PORTD = 0b00000101;	//RS(PD0)=H,E(PD2)=H
	_delay_us(1);
	PORTD = 0b00000001;	//RS(PD0)=H,E(PD2)=L
	_delay_us(40);		//more than 38us

	// Write Data
	PORTB = 'L';
	PORTD = 0b00000001;	//RS(PD0)=H
	PORTD = 0b00000101;	//RS(PD0)=H,E(PD2)=H
	_delay_us(1);
	PORTD = 0b00000001;	//RS(PD0)=H,E(PD2)=L
	_delay_us(40);		//more than 38us

	// Write Data
	PORTB = 'L';
	PORTD = 0b00000001;	//RS(PD0)=H
	PORTD = 0b00000101;	//RS(PD0)=H,E(PD2)=H
	_delay_us(1);
	PORTD = 0b00000001;	//RS(PD0)=H,E(PD2)=L
	_delay_us(40);		//more than 38us

	// Write Data
	PORTB = 'O';
	PORTD = 0b00000001;	//RS(PD0)=H
	PORTD = 0b00000101;	//RS(PD0)=H,E(PD2)=H
	_delay_us(1);
	PORTD = 0b00000001;	//RS(PD0)=H,E(PD2)=L
	_delay_us(40);		//more than 38us

	while(1)
		;

	return 0;
}

/*
                                  ATtiny2313
                                 +-----------+
                                -|1        20|- VCC
                    RS <--- PD0 -|2        19|- PB7 ---> DB7
                   R/W <--- PD1 -|3        18|- PB6 ---> DB6
                                -|4        17|- PB5 ---> DB5
                                -|5        16|- PB4 ---> DB4
                     E <--- PD2 -|6        15|- PB3 ---> DB3
                                -|7        14|- PB2 ---> DB2
                                -|8        13|- PB1 ---> DB1
                                -|9        12|- PB0 ---> DB0
                            GND -|10       11|- 
                                 +-----------+

                                  TC1602E-13A
                                  (Connector)
                                 +-----------+
                   PB7 <--- DB7 -|14       13|- DB5 ---> PB5
                   PB5 <--- DB5 -|12       11|- DB4 ---> PB4
                   PB3 <--- DB3 -|10        9|- DB2 ---> PB2
                   PB3 <--- DB1 -|8         7|- DB0 ---> PB0
                   PD2 <---   E -|6         5|- R/W ---> PD1
                   PD0 <---  RS -|4         3|- Vo
                            VSS -|2         1|- VDD
                                 +-----------+
*/
