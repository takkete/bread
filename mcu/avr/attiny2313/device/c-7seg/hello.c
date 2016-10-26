#include <avr/io.h>
#include <util/delay.h>


char *digit[] ={
	/* 0 */ "\x7\x6\x4\x2\x1\x9",
	/* 1 */ "\x4\x6",
	/* 2 */ "\x7\x6\xA\x1\x2",
	/* 3 */ "\x7\x6\xA\x4\x2",
	/* 4 */ "\x9\xA\x6\x4",
	/* 5 */ "\x9\xA\x7\x4\x2",
	/* 6 */ "\x7\x9\xA\x4\x2\x1",
	/* 7 */ "\x7\x9\x6\x4",
	/* 8 */ "\x7\x6\x4\x2\x1\x9\xA",
	/* 9 */ "\xA\x7\x9\x6\x4",
};

void anode(int sel, int pin)
{
	switch(sel){
	case	1:	// 7SEG (I)
		switch(pin){
		case	1: PORTD |= 0b00100000;break;
		case	2: PORTD |= 0b00010000;break;
		case	4: PORTD |= 0b00001000;break;
		case	5: PORTD |= 0b00000100;break;
		case	6: PORTB |= 0b00001000;break;
		case	7: PORTB |= 0b00000100;break;
		case	9: PORTB |= 0b00000010;break;
		default:   PORTB |= 0b00000001;break;
		}
		break;
	case	2:	// 7SEG (II)
		switch(pin){
		case	1: PORTA |= 0b00000001;break;
		case	2: PORTA |= 0b00000010;break;
		case	4: PORTD |= 0b00000010;break;
		case	5: PORTD |= 0b00000001;break;
		case	6: PORTB |= 0b10000000;break;
		case	7: PORTB |= 0b01000000;break;
		case	9: PORTB |= 0b00100000;break;
		default:   PORTB |= 0b00010000;break;
		}
		break;
	}
}

void clear()
{
	PORTB &= ~0b11111111;
	PORTD &= ~0b00111111;
	PORTA &= ~0b00000011;
}

void disp(int num)
{
	int pin;
	char* p;

	clear();

	p = digit[num / 10];
	while(pin=*p++)
		anode(1,pin);

	p = digit[num % 10];
	while(pin=*p++)
		anode(2,pin);
}

int main()
{
	DDRB = 0b11111111;      //ATtiny2313 pin.12-19 PB0-7 OUT
	DDRD = 0b00111111;      //ATtiny2313 pin.2,3,6-9 PD0-5 OUT
	DDRA = 0b00111111;      //ATtiny2313 pin.4,5 PA0-1 OUT

	//twenty-four logic
	{
		int i,j,wait,sel,pin;

		for(i=0;i<30;i+=5){
		for(j=0;j<5;j++){
			for(sel=1;sel<=2;sel++){
				for(pin=1;pin<=9;pin++){
					clear();
					anode(sel,pin);
					for(wait=1;wait<=(29-i);wait++){
						_delay_ms(1);
					}
				}	
			}
		}
		}
	}

	disp(24);

	while(1)
		;

	return 0;
}

/*
                                  ATtiny2313
                                 +-----------+
                                -|1        20|- VCC
                  II-5 <--- PD0 -|2        19|- PB7 ---> II-6
                  II-4 <--- PD1 -|3        18|- PB6 ---> II-7
                  II-2 <--- PA1 -|4        17|- PB5 ---> II-9
                  II-1 <--- PA0 -|5        16|- PB4 ---> II-10
                   I-5 <--- PD2 -|6        15|- PB3 ---> I-6
                   I-4 <--- PD3 -|7        14|- PB2 ---> I-7
                   I-2 <--- PD4 -|8        13|- PB1 ---> I-9
                   I-1 <--- PD5 -|9        12|- PB0 ---> I-10
                            GND -|10       11|- 
                                 +-----------+

                 7SEG(Cathode common)      7SEG(Cathode common)
                         (I)                      (II)
                    10 9  8  7  6             10 9  8  7  6 
                    |  |  |  |  |             |  |  |  |  |
                   +-------------+           +-------------+
                   |G  F cmn A  B|           |G  F cmn A  B|
                   |             |           |             |
                   |  +---A---+  |           |  +---A---+  |
                   |  |       |  |           |  |       |  |
                   |  F       B  |           |  F       B  |
                   |  |       |  |           |  |       |  |
                   |  +---G---+  |           |  +---G---+  |
                   |  |       |  |           |  |       |  |
                   |  E       C  |           |  E       C  |
                   |  |       |  |           |  |       |  |
                   |  +---D---+  |           |  +---D---+  |
                   |          DP |           |          DP |
                   |             |           |             |
                   |E  D cmn C DP|           |E  D cmn C DP|
                   +-------------+           +-------------+
                    |  |  |  |  |             |  |  |  |  |
                    1  2  3  4  5             1  2  3  4  5 
*/
