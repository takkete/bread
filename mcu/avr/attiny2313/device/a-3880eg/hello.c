#include <avr/io.h>
#include <util/delay.h>

void anode(int row)
{
	int shift=8-row;	
	PORTB |= (1<<shift);
}

void cathnode(int col)
{
	switch(col){
	case	1: PORTD &= ~0b00000001;break;
	case	2: PORTD &= ~0b00000010;break;
	case	3: PORTA &= ~0b00000010;break;
	case	4: PORTA &= ~0b00000001;break;
	case	5: PORTD &= ~0b00100000;break;
	case	6: PORTD &= ~0b00010000;break;
	case	7: PORTD &= ~0b00001000;break;
	default:   PORTD &= ~0b00000100;break;
	}
}

void clear()
{
	// anode_off
	PORTB = 0b00000000;

	// cathode_off
	PORTD |= 0b00111111;
	PORTA |= 0b00000011;
}

void set(int row,int col)
{
	clear();

	anode(row);
	cathnode(col);
}

int main()
{
	int row,col;
	DDRB = 0b11111111;      //ATtiny2313 pin.12-19 PB0-7 OUT
	DDRD = 0b00111111;      //ATtiny2313 pin.2,3,6-9 PD0-5 OUT
	DDRA = 0b00111111;      //ATtiny2313 pin.4,5 PA0-1 OUT

	while(1)
		for(row=1;row<=8;row++)
			for(col=1;col<=8;col++){
				set(row,col);
				_delay_ms(20);	
			}

	return 0;
}

/*
                                  ATtiny2313
                                 +-----------+
                                -|1        20|- VCC
                    23 <--- PD0 -|2        19|- PB7 ---> 22
                    20 <--- PD1 -|3        18|- PB6 ---> 19
                    17 <--- PA1 -|4        17|- PB5 ---> 16
                    14 <--- PA0 -|5        16|- PB4 ---> 13
                    11 <--- PD2 -|6        15|- PB3 ---> 3
                     8 <--- PD3 -|7        14|- PB2 ---> 6
                     5 <--- PD4 -|8        13|- PB1 ---> 9
                     2 <--- PD5 -|9        12|- PB0 ---> 12
                            GND -|10       11|- 
                                 +-----------+

                                  A-3880EG			
                        +---------------------------+
           COL5-b      -|1                        24|-      COL1-b 
           COL5-a      -|2                        23|-      COL1-a
                  ROW5 -|3                        22|- ROW1
           COL6-b      -|4                        21|-      COL2-b
           COL6-a      -|5                        20|-      COL2-a
                  ROW6 -|6                        19|- ROW2
           COL7-b      -|7                        18|-      COL3-b 
           COL7-a      -|8                        17|-      COL3-a
                  ROW7 -|9                        16|- ROW3
           COL8-b      -|10                       15|-      COL4-b 
           COL8-a      -|11                       14|-      COL4-a
                  ROW8 -|12                       13|- ROW4
                        +---------------------------+
*/
