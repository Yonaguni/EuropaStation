#define AL_IDLE      0		//used by airlock control datum
#define AL_INTERIOR  1		//use for doors, buttons, and sensors that are on the "interior" of the airlock
#define AL_EXTERIOR  2		//use for doors, buttons, and sensors that are on the "exterior" of the airlock
#define AL_CHAMBER   4		//use for sensors inside the airlock chamber

//airlock pump function modes
#define ALP_DRAININT 1		//use for vent pumps that you want to drain to when cycling from the interior
#define ALP_DRAINEXT 2		//use for vent pumps that you want to drain to when cycling from the exterior
#define ALP_FILLINT  4		//use for vent pumps that you want to fill from when cycling to the interior
#define ALP_FILLEXT  8		//use for vent pumps that you want to fill from when cycling to the exterior

//airlock controller stage
#define ALS_IDLE     0
#define ALS_DRAIN    1
#define ALS_FILL     2
#define ALS_DONE     3