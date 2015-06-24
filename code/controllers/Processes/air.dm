/datum/controller/process/air/setup()
	name = "air"
	schedule_interval = 20 // every 2 seconds

	if(!air_master)
		air_master = new
		air_master.Setup()

/datum/controller/process/air/doWork()
	return
