/obj/structure/table

	standard
		icon_state = "plain_preview"
		color = "#EEEEEE"
		New()
			material = SSmaterials.get_material(DEFAULT_TABLE_MATERIAL)
			..()

	steel
		icon_state = "plain_preview"
		color = "#666666"
		New()
			material = SSmaterials.get_material(MATERIAL_STEEL)
			..()

	marble
		icon_state = "stone_preview"
		color = "#CCCCCC"
		New()
			material = SSmaterials.get_material(MATERIAL_MARBLE)
			..()

	reinforced
		icon_state = "reinf_preview"
		color = "#EEEEEE"
		New()
			material = SSmaterials.get_material(DEFAULT_TABLE_MATERIAL)
			reinforced = SSmaterials.get_material(MATERIAL_STEEL)
			..()

	steel_reinforced
		icon_state = "reinf_preview"
		color = "#666666"
		New()
			material = SSmaterials.get_material(MATERIAL_STEEL)
			reinforced = SSmaterials.get_material(MATERIAL_STEEL)
			..()

	woodentable
		icon_state = "plain_preview"
		color = "#824B28"
		New()
			material = SSmaterials.get_material(MATERIAL_WOOD)
			..()

	gamblingtable
		icon_state = "gamble_preview"
		New()
			material = SSmaterials.get_material(MATERIAL_WOOD)
			carpeted = 1
			..()

	glass
		icon_state = "plain_preview"
		color = "#00E1FF"
		alpha = 77 // 0.3 * 255
		New()
			material = SSmaterials.get_material(MATERIAL_GLASS)
			..()

	holotable
		icon_state = "holo_preview"
		color = "#EEEEEE"
		New()
			material = SSmaterials.get_material(MATERIAL_HOLOPLASTIC)
			..()

	holo_woodentable
		icon_state = "holo_preview"
		New()
			material = SSmaterials.get_material(MATERIAL_HOLOWOOD)
			..()
