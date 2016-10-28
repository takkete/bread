#include <avr/io.h>
#include <util/delay.h>

char *digit[] ={
/* 0 */ "ABCDEF",	/*  +---A---+  */
/* 1 */ "BC",           /*  |       |  */
/* 2 */ "ABGED",        /*  F       B  */
/* 3 */ "ABCDG",        /*  |       |  */
/* 4 */ "FGBC",         /*  +---G---+  */
/* 5 */ "AFGCD",        /*  |       |  */
/* 6 */ "AFGCDE",       /*  E       C  */
/* 7 */ "FABC",         /*  |       |  */
/* 8 */ "ABCDEFG",      /*  +---D---+  */
/* 9 */ "ABCDGF",       /*          DP */
}; 

void anode(int pin)
{
	switch(pin){
	case	 1: PORTB |= 0b00000001;break;
	case	 2: PORTB |= 0b00000010;break;
	case	 3: PORTB |= 0b00000100;break;
	case	 4: PORTB |= 0b00001000;break;
	case	 5: PORTB |= 0b00010000;break;
	case	11: PORTB |= 0b00100000;break;
	case	10: PORTB |= 0b01000000;break;
	case	 7:
	default:    PORTB |= 0b10000000;break;
	}
}
void cathode(int pin)
{
	switch(pin){
	case	 6: PORTD &= ~0b00000100;break;
	case	 8: PORTA &= ~0b00000010;break;
	case	 9: PORTA &= ~0b00000001;break;
	case	12:
	default:    PORTD &= ~0b00001000;break;
	}
}

void clear()
{
	PORTB &= ~0b11111111;
	PORTA |= 0b00000011;
	PORTD |= 0b00001100;
}

void disp(int sel,int num)
{
	int pin;
	char loc;
	char* p;

	p = digit[num];

	while(loc=*p++){
		clear();
		switch(sel){
		case	1:	pin=12;	break;
		case	2:	pin= 9;	break;
		case	3:	pin= 8;	break;
		default:
		case	4:	pin= 6;	break;
		}
		cathode(pin);

		switch(loc){
		case	'A':	pin=11;	break;
		case	'B':	pin= 7;	break;
		case	'C':	pin= 4;	break;
		case	'D':	pin= 2;	break;
		case	'E':	pin= 1;	break;
		case	'F':	pin=10;	break;
		default:
		case	'G':	pin= 5;	break;
		}
			
		anode(pin);
		_delay_ms(1);
	}

}

int main()
{
	DDRB = 0b11111111;      //ATtiny2313 pin.12-19 PB0-7 OUT
	DDRD = 0b00111111;      //ATtiny2313 pin.2,3,6-9 PD0-5 OUT
	DDRA = 0b00111111;      //ATtiny2313 pin.4,5 PA0-1 OUT

	while(1){
		disp(1,1);
		disp(2,2);
		disp(3,3);
		disp(4,7);
	}

	return 0;
}

/*
                                  ATtiny2313
                                 +-----------+
                                -|1        20|- VCC
                            PD0 -|2        19|- PB7 ---> 7
                            PD1 -|3        18|- PB6 ---> 10
                     8 <--- PA1 -|4        17|- PB5 ---> 11
                     9 <--- PA0 -|5        16|- PB4 ---> 5
                     6 <--- PD2 -|6        15|- PB3 ---> 4
                    12 <--- PD3 -|7        14|- PB2 ---> 3
                            PD4 -|8        13|- PB1 ---> 2
                            PD5 -|9        12|- PB0 ---> 1
                            GND -|10       11|- 
                                 +-----------+

                                      4 digit 7SEG(cathode common)
                                        12 11 10  9  8  7                      
                                         |  |  |  |  |  |                     
                   +-------------++-------------++-------------++-------------+
                   |             ||     d1  A  F||d2 d3 B      ||             |
                   |             ||             ||             ||             |
                   |  +---A---+  ||  +---A---+  ||  +---A---+  ||  +---A---+  |
                   |  |       |  ||  |       |  ||  |       |  ||  |       |  |
                   |  F       B  ||  F       B  ||  F       B  ||  F       B  |
                   |  |       |  ||  |       |  ||  |       |  ||  |       |  |
                   |  +---G---+  ||  +---G---+  ||  +---G---+  ||  +---G---+  |
                   |  |       |  ||  |       |  ||  |       |  ||  |       |  |
                   |  E       C  ||  E       C  ||  E       C  ||  E       C  |
                   |  |       |  ||  |       |  ||  |       |  ||  |       |  |
                   |  +---D---+  ||  +---D---+  ||  +---D---+  ||  +---D---+  |
                   |          DP ||          DP ||          DP ||          DP |
                   |             ||             ||             ||             |
                   |             ||      E  D DP||C  G  d4     ||             |
                   +-------------++-------------++-------------++-------------+
                                         |  |  |  |  |  |                     
                                         1  2  3  4  5  6                      
*/
