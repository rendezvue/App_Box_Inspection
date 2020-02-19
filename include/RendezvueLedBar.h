#ifndef _RENDEZVUE_LED_BAR_H_
#define _RENDEZVUE_LED_BAR_H_

#include "opencv2/opencv.hpp"

class  CRendezvueLedBar
{
public:
	CRendezvueLedBar(void);
	~CRendezvueLedBar(void);

public:
	void Set(const bool on_red, const bool on_green) ;

};

#endif