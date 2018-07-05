// These should only really be used for mapping ease, and for outfits and equip() procs,
// as they will explode into individual components if they are spawned or equipped
// to anywhere other than the uniform slot of a human mob.

/obj/item/clothing/under/lower/leather/wasteland_fatigues/New()
	under_parts = list(
		PARTIAL_UNIFORM_UPPER = new /obj/item/clothing/under/upper/fatigues(src)
		)
	..()

/obj/item/clothing/under/lower/jeans/blue_collar/New()
	under_parts = list(
		PARTIAL_UNIFORM_UPPER = new /obj/item/clothing/under/upper/business/bluecollar(src)
		)
	..()

/obj/item/clothing/under/lower/dresspants/beige/office_worker/New()
	under_parts = list(
		PARTIAL_UNIFORM_UPPER = new /obj/item/clothing/under/upper/business/white(src)
		)
	..()

/obj/item/clothing/under/lower/camo/tacticool/New()
	under_parts = list(
		PARTIAL_UNIFORM_UPPER = new /obj/item/clothing/under/upper/tacticool(src)
		)
	..()

/obj/item/clothing/under/lower/pants/white/sailor/New()
	under_parts = list(
		PARTIAL_UNIFORM_UPPER = new /obj/item/clothing/under/upper/sailor(src)
		)
	..()

/obj/item/clothing/under/lower/pants/police_uniform/New()
	color = "#0b2a47"
	name = "officer's pants"
	under_parts = list(
		PARTIAL_UNIFORM_UPPER = new /obj/item/clothing/under/upper/longsleeve/police(src)
		)
	..()

/obj/item/clothing/under/lower/pants/beige/navy_uniform/New()
	under_parts = list(
		PARTIAL_UNIFORM_UPPER = new /obj/item/clothing/under/upper/shirt/beige(src),
		PARTIAL_UNIFORM_OVER =  new /obj/item/clothing/under/jumpsuit/naval(src)
		)
	..()

/obj/item/clothing/under/lower/pants/black/response_team/New()
	under_parts = list(
		PARTIAL_UNIFORM_UPPER = new /obj/item/clothing/under/upper/shirt/black(src),
		PARTIAL_UNIFORM_OVER =  new /obj/item/clothing/under/jumpsuit/naval(src)
		)
	..()

/obj/item/clothing/under/lower/pants/black/passenger_clothing/New()
	under_parts = list(
		PARTIAL_UNIFORM_UPPER = new /obj/item/clothing/under/upper/shirt/gray(src),
		PARTIAL_UNIFORM_OVER =  new /obj/item/clothing/under/jumpsuit/gray(src)
		)
	..()

/obj/item/clothing/under/lower/pants/white/scientist_uniform/New()
	under_parts = list(
		PARTIAL_UNIFORM_UPPER = new /obj/item/clothing/under/upper/shirt/white(src),
		PARTIAL_UNIFORM_OVER =  new /obj/item/clothing/under/jumpsuit/white(src)
		)
	..()

/obj/item/clothing/under/lower/pants/black/hospitality/New()
	under_parts = list(
		PARTIAL_UNIFORM_UPPER = new /obj/item/clothing/under/upper/shirt/white(src)
		)
	..()

/obj/item/clothing/under/lower/psy/full_suit/New()
	under_parts = list(
		PARTIAL_UNIFORM_UPPER = new /obj/item/clothing/under/upper/psy(src)
		)
	..()
