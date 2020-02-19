#ifndef _RENDEZVUE_LIGHT_H_
#define _RENDEZVUE_LIGHT_H_

#include "opencv2/opencv.hpp"

class  CRendezvueLight
{
public:
	CRendezvueLight(const int gpio_num);
	~CRendezvueLight(void);

public:
	void Set(const bool on) ;
};

#endif