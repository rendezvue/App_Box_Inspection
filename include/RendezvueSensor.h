#ifndef _RENDEZVUE_SENSOR_H_
#define _RENDEZVUE_SENSOR_H_

#include "opencv2/opencv.hpp"

class  CRendezvueSensor
{
public:
	CRendezvueSensor(const int gpio_num);
	~CRendezvueSensor(void);

public:
	int GetTrigger(const int deay_msec=0) ;
};

#endif