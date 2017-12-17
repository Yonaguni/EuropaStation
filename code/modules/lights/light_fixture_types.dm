// the smaller bulb light fixture
/obj/machinery/light/small
	icon_state = "bulb1"
	desc = "A small lighting fixture."
	bulb = /obj/item/light/bulb
	construct_type = /obj/machinery/light_construct/small

/obj/machinery/light/small/emergency
	bulb = /obj/item/light/bulb/red

/obj/machinery/light/small/red
	bulb = /obj/item/light/bulb/red

/obj/machinery/light/small/red/airlock
	name = "sealed light fixture"
	waterproof = TRUE

/obj/machinery/light/spot
	name = "spotlight"
	bulb = /obj/item/light/tube/large