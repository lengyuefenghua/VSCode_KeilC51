#include "delay.h"
/******************************************************************************
 * 描  述 : 微秒级延时函数
 * 入  参 : 延时时间，单位：us
 * 返回值 : 无
 ******************************************************************************/
void Delay_us(unsigned int us)		//@24.000MHz
{
	unsigned char i;
	i = 6+(us-1)*8;
	while (--i);

}

/******************************************************************************
 * 描  述 : 毫秒级延时函数
 * 入  参 : 延时时间，单位：ms
 * 返回值 : 无
 ******************************************************************************/
void Delay_ms(unsigned int ms)		//@24.000MHz
{
	unsigned char i, j;
	while(--ms)
	{
		i = 32;
		j = 40;
		do
		{
			while (--j);
		} while (--i);
	}
}

