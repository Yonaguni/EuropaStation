/obj/item/stack/material/get_default_codex_value(var/mob/user)
	return (material && !material.hidden_from_codex) ? "[lowertext(material.display_name)] (material)" : ..()

/material
	var/hidden_from_codex
	var/lore_text
	var/mechanics_text
	var/antag_text

/material/uranium
	lore_text = "A highly radioactive metal. Commonly used as fuel in fission reactors."
	mechanics_text = "Uranium ingots are used as fuel in some forms of portable generator."

/material/diamond
	lore_text = "An extremely hard allotrope of carbon. Valued for use in industrial tools."

/material/gold
	lore_text = "A heavy, soft, ductile metal. Once considered valuable enough to back entire currencies, now predominantly used in corrosion-resistant electronics."

/material/gold/bronze
	lore_text = "An alloy of copper and tin."

/material/silver
	lore_text = "A soft, white, lustrous transition metal. Has many and varied industrial uses in electronics, solar panels and mirrors."

/material/supermatter
	lore_text = "Non-baryonic 'exotic' matter features heavily in theoretical artificial wormholes, and underpins the workings of the commonly-used gravity drive."

/material/stone
	lore_text = "A clastic sedimentary rock. The cost of boosting it to orbit is almost universally much higher than the actual value of the material."

/material/stone/marble
	lore_text = "A metamorphic rock largely sourced from Earth. Prized for use in extremely expensive decorative surfaces."

/material/steel
	lore_text = "A strong, flexible alloy of iron and carbon. Probably the single most fundamentally useful and ubiquitous substance in human space."

/material/diona
	hidden_from_codex = TRUE

/material/steel/holographic
	hidden_from_codex = TRUE

/material/plasteel
	lore_text = "When regular high-tensile steel isn't tough enough to get the job done, the smart consumer turns to frankly absurd alloys of steel and an extremely hard platinum metal, osmium."

/material/plasteel/titanium
	lore_text = "A light, strong, corrosion-resistant metal. Perfect for cladding high-velocity ballistic supply pods."

/material/glass
	lore_text = "A brittle, transparent material made from molten silicates. It is generally not a liquid."

/material/glass/phoron_reinforced
	lore_text = "An extremely heat-resistant form of glass."

/material/plastic
	lore_text = "A generic polymeric material. Probably the most flexible and useful substance ever created by human science; mostly used to make disposable cutlery."

/material/osmium
	lore_text = "An extremely hard form of platinum."

/material/tritium
	lore_text = "A radioactive isotope of hydrogen. Useful as a fusion reactor fuel material."
	mechanics_text = "Tritium is useable as a fuel in some forms of portable generator. It can also be converted into a fuel rod suitable for a R-UST fusion plant injector by clicking a stack on a fuel compressor. It fuses hotter than deuterium but is correspondingly more unstable."

/material/deuterium
	lore_text = "One of the two stable isotopes of hydrogen; also known as heavy hydrogen. Useful as a chemically synthesised fusion reactor fuel material."
	mechanics_text = "Deuterium can be converted into a fuel rod suitable for a R-UST fusion plant injector by clicking a stack on a fuel compressor. It is the most 'basic' fusion fuel."

/material/mhydrogen
	lore_text = "When hydrogen is exposed to extremely high pressures and temperatures, such as at the core of gas giants like Jupiter, it can take on metallic properties and - more importantly - acts as a room temperature superconductor. Achieving solid metallic hydrogen at room temperature, though, has proven to be rather tricky."

/material/platinum
	lore_text = "A very dense, unreactive, precious metal. Has many industrial uses, particularly as a catalyst."

/material/iron
	lore_text = "A ubiquitous, very common metal. The epitaph of stars and the primary ingredient in Earth's core."

/material/wood
	lore_text = "A fibrous structural material harvested from trees. Don't get a splinter."

/material/cardboard
	lore_text = "What with the difficulties presented by growing plants in orbit, a stock of cardboard in space is probably more valuable than gold."

/material/elevatorium
	hidden_from_codex = TRUE

/material/plastic/holographic
	hidden_from_codex = TRUE

/material/wood/holographic
	hidden_from_codex = TRUE

/material/cloth
	hidden_from_codex = TRUE

/material/leather
	hidden_from_codex = TRUE

/material/carpet
	hidden_from_codex = TRUE

/material/cotton
	hidden_from_codex = TRUE

/material/cloth_teal
	hidden_from_codex = TRUE

/material/cloth_black
	hidden_from_codex = TRUE

/material/cloth_green
	hidden_from_codex = TRUE

/material/cloth_puple
	hidden_from_codex = TRUE

/material/cloth_blue
	hidden_from_codex = TRUE

/material/cloth_beige
	hidden_from_codex = TRUE

/material/cloth_lime
	hidden_from_codex = TRUE
