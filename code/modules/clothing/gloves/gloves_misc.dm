/obj/item/clothing/gloves/forensic
	desc = "Specially made gloves for forensic technicians. The luminescent threads woven into the material stand out under scrutiny."
	name = "forensic gloves"
	icon_state = "forensic"
	item_state = "bgloves"

/obj/item/clothing/gloves/thick
	desc = "These work gloves are thick and fire-resistant."
	name = "work gloves"
	icon_state = "black"
	item_state = "bgloves"
	siemens_coefficient = 0.40
	permeability_coefficient = 0.05
	force = 5
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 25, bomb = 50, bio = 10, rad = 0)

	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/gloves/thick/swat
	desc = "These tactical gloves are somewhat fire and impact-resistant."
	name = "\improper SWAT Gloves"
	item_state = "swat_gl"

/obj/item/clothing/gloves/thick/combat //Combined effect of SWAT gloves and insulated gloves
	desc = "These tactical gloves are somewhat fire and impact resistant."
	name = "combat gloves"
	icon_state = "work"
	item_state = "wgloves"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	force = 5
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 25, bomb = 50, bio = 10, rad = 0)
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/gloves/thick/botany
	desc = "These leather work gloves protect against thorns, barbs, prickles, spikes and other harmful objects of floral origin."
	name = "botanist's leather gloves"
	icon_state = "leather"
	item_state = "ggloves"

/obj/item/clothing/gloves/latex
	name = "latex gloves"
	desc = "Sterile latex gloves."
	siemens_coefficient = 1.1 //thin latex gloves, much more conductive than fabric gloves (basically a capacitor for AC)
	permeability_coefficient = 0.01
	germ_level = 0

/obj/item/clothing/gloves/botanic_leather
	desc = "These leather work gloves protect against thorns, barbs, prickles, spikes and other harmful objects of floral origin."
	name = "botanist's leather gloves"
	icon_state = "leather"
	item_state = "ggloves"
	permeability_coefficient = 0.05
	siemens_coefficient = 0.50 //thick work gloves

/obj/item/clothing/gloves/work
	desc = "These brown tactical gloves are made from a durable synthetic."
	name = "work gloves"
	icon_state = "work"
	item_state = "wgloves"
	siemens_coefficient = 0.50
	armor = list(melee = 10, bullet = 10, laser = 10, energy = 5, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/gloves/tactical
	desc = "These brown tactical gloves are made from a durable synthetic, and have hardened knuckles."
	name = "tactical gloves"
	icon_state = "work"
	item_state = "wgloves"
	force = 5
	siemens_coefficient = 0.50
	permeability_coefficient = 0.05
	armor = list(melee = 30, bullet = 10, laser = 10, energy = 15, bomb = 20, bio = 0, rad = 0)
