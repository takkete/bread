#include <avr/io.h>
#include <util/delay.h>

struct bf{
	int b0:	1;
	int b1:	1;
	int b2:	1;
	int b3:	1;
	int b4:	1;
	int b5:	1;
	int b6:	1;
	int b7:	1;
};
struct bf4{
	int low4:	4;
	int high4:	4;
};


#define EIGHTBITMODE	1
#define FOURBITMODE	0
#define ID	1	/* Direction 1=Increment 0=Decrement */
#define S	0	/* Shift 1=yes 0=no */
#define ON	1
#define OFF	0
#define H	1
#define L	0
#define _	0	/* don't care*/

#define DL	FOURBITMODE	/* 1=8BIT MODE / 0=4BIT MODE */
#define N	1	/* 1=2ROWS / 0=1ROW */
#define F	1	/* 1=LARGE FONT / 0=SMALL FONT */

#define PORT_MODE_INIT()	DDRB = 0b00111111
#define	E(hl)		((struct bf*)&PORTB)->b5 = hl
#define	RW(hl)	/*	((struct bf*)&PORTD)->b1 = hl */
#define	RS(hl)		((struct bf*)&PORTB)->b4 = hl
#define	DB_LOW(data)	((struct bf4*)&PORTB)->low4 = 0xf & data
#define	DB_ALL(data)	PORTB = (unsigned char)data
#define DB ((struct bf*)&PORTB)


#if DL == EIGHTBITMODE
#	define WRITE_DATA(data)				\
		do{					\
				RS(H);			\
				RW(L);			\
				DB_ALL(data);		\
				_delay_us(1);		\
				E(H);			\
				_delay_us(1);		\
				E(L);			\
		}while(0)
#else
#	define WRITE_DATA(data)				\
		do{					\
				RS(H);			\
				RW(L);			\
				DB_LOW(data>>4);	\
				_delay_us(1);		\
				E(H);			\
				_delay_us(1);		\
				E(L);			\
				_delay_us(40);		\
				/**/			\
				RS(H);			\
				RW(L);			\
				DB_LOW(data);		\
				_delay_us(1);		\
				E(H);			\
				_delay_us(1);		\
				E(L);			\
				_delay_us(40);		\
		}while(0)
#endif
		
#define COMMAND_8BIT(rs,rw,db7,db6,db5,db4,db3,db2,db1,db0)	\
		do{						\
				RS(rs);				\
				RW(rw);				\
				DB->b7 = db7;			\
				DB->b6 = db6;			\
				DB->b5 = db5;			\
				DB->b4 = db4;			\
				DB->b3 = db3;			\
				DB->b2 = db2;			\
				DB->b1 = db1;			\
				DB->b0 = db0;			\
				_delay_us(1);			\
				E(H);				\
				_delay_us(1);			\
				E(L);				\
				_delay_us(40);			\
		}while(0)

#if DL == EIGHTBITMODE
#	define COMMAND	COMMAND_8BIT
#else
#	define COMMAND(rs,rw,db7,db6,db5,db4,db3,db2,db1,db0)	\
		do{						\
			RS(rs);					\
			RW(rw);					\
			DB->b3 = db7;				\
			DB->b2 = db6;				\
			DB->b1 = db5;				\
			DB->b0 = db4;				\
			_delay_us(1);				\
			E(H);					\
			_delay_us(1);				\
			E(L);					\
			/**/					\
			RS(rs);					\
			RW(rw);					\
			DB->b3 = db3;				\
			DB->b2 = db2;				\
			DB->b1 = db1;				\
			DB->b0 = db0;				\
			_delay_us(1);				\
			E(H);					\
			_delay_us(1);				\
			E(L);					\
			_delay_us(40);				\
		}while(0)
#endif



void display_onoff(int onoff)
{
	COMMAND(0,0, 0,0,0,0, 1,onoff,0,0);
	_delay_us(40);		//more than 40us
}

void display_clear()
{
	COMMAND(0,0, 0,0,0,0, 0,0,0,1);
	_delay_ms(2);		//more than 1.52ms
}

void entry_mode_set(int direction,int shift)
{
	// direction=1:right, 0:left
	// shift=1:shift, 0:none
	COMMAND(0,0, 0,0,0,0, 0,1,direction,shift);
	_delay_us(40);		//more than 38us
}

void write_data(char c)
{
	WRITE_DATA(c);
	_delay_us(40);		//more than 38us
}

int clcd_init(void)
{
	PORT_MODE_INIT();

	_delay_ms(100);
	// After power on
	_delay_ms(41);

 	/* Function Set(8bit mode) 1st
	            RS,RW DB7---4  DB3---0 */
	COMMAND_8BIT(0,0, 0,0,1,1, _,_,_,_);

	//more than 4.1ms
	_delay_ms(5);

 	/* Function Set(8bit mode) 2nd
	            RS,RW DB7---4  DB3---0 */
	COMMAND_8BIT(0,0, 0,0,1,1, _,_,_,_);

	/* more than 100us */
	_delay_us(100);

	/* Function Set(8bit mode) 3rd
	            RS,RW DB7---4  DB3---0 */
	COMMAND_8BIT(0,0, 0,0,1,1, _,_,_,_);

#if DL == FOURBITMODE
	/* Function Set(4bit mode)
	            RS,RW DB7----4  DB3---0 */
	COMMAND_8BIT(0,0, 0,0,1,DL, _,_,_,_);
#endif

	/* Function Set(Rows and Fonts)
	       RS,RW DB7----4  DB3---0 */
	COMMAND(0,0, 0,0,1,DL, N,F,0,0);

	/* Display OFF
	       RS,RW DB7---4  DB3-----0 */
	COMMAND(0,0, 0,0,0,0, 1,OFF,0,0);

	/* Clear Display
	       RS,RW DB7---4  DB3---0 */
	COMMAND(0,0, 0,0,0,0, 0,0,0,1);
	_delay_ms(2);			//more than 1.52ms

	/* Entry Mode Set(Cursor and Shift)
	       RS,RW DB7---4  DB3---0 */
	COMMAND(0,0, 0,0,0,0, 0,1,ID,S);

	/* Display ON
	       RS,RW DB7---4  DB3-----0 */
	COMMAND(0,0, 0,0,0,0, 1,ON,0,0);

}

void clcd_print(char* str)
{
	while(*str){
		write_data(*str++);
	}
}


char* to_string(char *str, int num)
{
	if(num >=  10){
		*str++ = (num / 10)+'0';
		num %= 10;
	}else{
		*str++ = '0';
	}
	*str++ = num +'0';
	*str = 0;
	return str;
}

void get_clock_string(char *str, int h, int m, int s)
{
	str = to_string(str,h);
	*str++ = ':';
	str = to_string(str,m);
	*str++ = ':';
	str = to_string(str,s);
}

int main(void)
{
	char str[10];
	int h,m,s;

	h=0;
	m=0;
	s=0;

	clcd_init();

	while(1){
		/* Return Home
		       RS,RW DB7---4  DB3---0 */
		COMMAND(0,0, 0,0,0,0, 0,0,1,0);
		_delay_ms(2);

		get_clock_string(str,h,m,s);

		clcd_print(str);

		_delay_ms(998);
		if(++s >= 60){
			s=0;
			if(++m >= 60){
				m=0;
				if(++h >= 24){
					m=h;
				}
			}
		}
			
	}

	return 0;
}

/*
                                  ATtiny2313
                                 +-----------+
                                -|1        20|- VCC
                                -|2        19|- 
                                -|3        18|- 
                                -|4        17|- PB5 ---> E
                                -|5        16|- PB4 ---> RS
                                -|6        15|- PB3 ---> DB3
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
                    nc <--- DB3 -|10        9|- DB2 ---> nc
                    nc <--- DB1 -|8         7|- DB0 ---> nc
                   PD2 <---   E -|6         5|- R/W ---> GND
                   PD0 <---  RS -|4         3|- Vo
                            VSS -|2         1|- VDD
                                 +-----------+
*/
