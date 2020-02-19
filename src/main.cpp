#include <stdio.h>

#include "VersionInfo.h"

//Ensemble API
#include "EnsembleAPI.h"

//opencv
#include "opencv2/opencv.hpp"

#include "RendezvueSensor.h"
#include "RendezvueLight.h"
#include "RendezvueCamera.h"
#include "RendezvueLedBar.h"
#include "RendezvueVision.h"

int main(void)
{
	CRendezvueSensor cls_sensor_input(0) ;
	CRendezvueSensor cls_sensor_output(1) ;
	CRendezvueLight cls_light(2) ;
	CRendezvueCamera cls_camera ;
	CRendezvueLedBar cls_led_bar ;
	CRendezvueVision cls_vision ;
	
	printf("Start Box Inspection\n") ;

	//Connect
	
	while(1)
	{
		//Step 0 : Check Connect
		
		//Step 1 : Wait Trigger from Input Sensor
		cls_sensor_input.GetTrigger() ;

		//Step 2 : Light On
		cls_light.Set(true) ;

		//Step 3 : Grab Image
		cv::Mat image = cls_camera.GetImage() ;

		//Step 4 : Vision
		bool b_ng = false ;
		b_ng = cls_vision.Run(image) ;
		
		//Step 5 : Light Off
		cls_light.Set(false) ;
		
		//Step 6 : Wait Trigger from Input Sensor
		cls_sensor_output.GetTrigger() ;

		//Step 7 : LED Bar Control
		if( b_ng )
		{
			cls_led_bar.Set(true, false) ;
		}
		else
		{
			cls_led_bar.Set(false, true) ;
		}
	};

	//Disconnect
	
	return 0 ;
}
