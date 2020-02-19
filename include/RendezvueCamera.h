#ifndef _RENDEZVUE_CAMERA_H_
#define _RENDEZVUE_CAMERA_H_

#include "opencv2/opencv.hpp"

class  CRendezvueCamera
{
public:
	CRendezvueCamera(void);
	~CRendezvueCamera(void);

public:
	cv::Mat GetImage(void) ;
};

#endif