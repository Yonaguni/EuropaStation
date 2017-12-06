// -- SSprocessing stuff --
#define START_PROCESSING(Processor, Datum) if (!Datum.isprocessing) {Datum.isprocessing = 1;Processor.processing += Datum}
#define STOP_PROCESSING(Processor, Datum) Datum.isprocessing = 0;Processor.processing -= Datum

// -- SStimer stuff --
//Don't run if there is an identical unique timer active
#define TIMER_UNIQUE		0x1

//For unique timers: Replace the old timer rather then not start this one
#define TIMER_OVERRIDE		0x2

//Timing should be based on how timing progresses on clients, not the sever.
//	tracking this is more expensive,
//	should only be used in conjuction with things that have to progress client side, such as animate() or sound()
#define TIMER_CLIENT_TIME	0x4

//Timer can be stopped using deltimer()
#define TIMER_STOPPABLE		0x8

//To be used with TIMER_UNIQUE
//prevents distinguishing identical timers with the wait variable
#define TIMER_NO_HASH_WAIT  0x10

//number of byond ticks that are allowed to pass before the timer subsystem thinks it hung on something
#define TIMER_NO_INVOKE_WARNING 600

#define TIMER_ID_NULL -1

// -- SSopenturf --
#define CHECK_OO_EXISTENCE(OO) if (OO && !isopenturf(OO.loc)) { qdel(OO); }
#define UPDATE_OO_IF_PRESENT CHECK_OO_EXISTENCE(bound_overlay); if (bound_overlay) { update_above(); }