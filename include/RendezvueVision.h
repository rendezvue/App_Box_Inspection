#ifndef _RENDEZVUE_VISION_H_
#define _RENDEZVUE_VISION_H_

#include "opencv2/opencv.hpp"

class  CRendezvueVision
{
public:
	CRendezvueVision(void);
	~CRendezvueVision(void);

public:
	bool Run(cv::Mat image) ;

};

#endif