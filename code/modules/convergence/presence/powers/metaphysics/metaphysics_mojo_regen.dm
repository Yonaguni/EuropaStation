/datum/presence_power/metaphysics/mojo
	var/increase_mojo_min
	var/increase_mojo_max
	var/increase_mojo_regen

/datum/presence_power/metaphysics/mojo/purchased(var/mob/living/presence/purchased_by)
	..()
	if(increase_mojo_min)   purchased_by.min_mojo +=   increase_mojo_min
	if(increase_mojo_max)   purchased_by.max_mojo +=   increase_mojo_max
	if(increase_mojo_regen) purchased_by.mojo_regen += increase_mojo_regen
	to_chat(purchased_by, "<span class='notice'>You will now regenerate [purchased_by.mojo_regen] [purchased_by.presence.unit_name]\s when below [purchased_by.min_mojo], and can store a maximum of [purchased_by.max_mojo].</span>")

/datum/presence_power/metaphysics/mojo/regen_1
	name = "Basic Power Generation"
	header_text = "Metaphysics"
	description = "Slowly generate power."
	children = list(
		/datum/presence_power/metaphysics/mojo/regen_2,
		/datum/presence_power/metaphysics/mojo/storage_1
		)

/datum/presence_power/metaphysics/mojo/regen_2
	name = "Improved Power Generation I"
	description = "Increase your passive power generation."
	children = list(/datum/presence_power/metaphysics/mojo/regen_3)
	increase_mojo_regen = 1

/datum/presence_power/metaphysics/mojo/regen_3
	name = "Improved Power Generation II"
	description = "Increase your passive power generation even further."
	children = list(
		/datum/presence_power/metaphysics/mojo/regen_4,
		/datum/presence_power/metaphysics/mojo/storage_2
		)
	increase_mojo_regen = 2

/datum/presence_power/metaphysics/mojo/regen_4
	name = "Improved Power Generation III"
	description = "Increase your passive power generation a bit more."
	children = list(/datum/presence_power/metaphysics/mojo/regen_5)
	increase_mojo_regen = 2

/datum/presence_power/metaphysics/mojo/regen_5
	name = "Maximized Power Generation"
	description = "Increase your passive power generation to the maximum."
	children = list(/datum/presence_power/metaphysics/mojo/storage_3)
	increase_mojo_regen = 4

/datum/presence_power/metaphysics/mojo/storage_1
	name = "Improved Power Storage"
	description = "Increase your minimum and maximum power amounts."
	increase_mojo_min = 5
	increase_mojo_max = 50

/datum/presence_power/metaphysics/mojo/storage_2
	name = "Improved Power Storage"
	description = "Increase your minimum and maximum power further."
	increase_mojo_min = 10
	increase_mojo_max = 100

/datum/presence_power/metaphysics/mojo/storage_3
	name = "Maximized Power Storage"
	description = "Increase your minimum and maximum power to the max."
	increase_mojo_min = 25
	increase_mojo_max = 250
