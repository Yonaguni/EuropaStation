/obj/structure/table

	standard
		icon_state = "plain_preview"
		color = "#EEEEEE"
		New()
			material = get_material_by_path(DEFAULT_TABLE_MATERIAL_PATH)
			..()

	steel
		icon_state = "plain_preview"
		color = "#666666"
		New()
			material = get_material_by_path(DEFAULT_WALL_MATERIAL_PATH)
			..()

	marble
		icon_state = "stone_preview"
		color = "#CCCCCC"
		New()
			material = get_material_by_name("marble")
			..()

	reinforced
		icon_state = "reinf_preview"
		color = "#EEEEEE"
		New()
			material = get_material_by_path(DEFAULT_TABLE_MATERIAL_PATH)
			reinforced = get_material_by_path(DEFAULT_WALL_MATERIAL_PATH)
			..()

	steel_reinforced
		icon_state = "reinf_preview"
		color = "#666666"
		New()
			material = get_material_by_path(DEFAULT_WALL_MATERIAL_PATH)
			reinforced = get_material_by_path(DEFAULT_WALL_MATERIAL_PATH)
			..()

	woodentable
		icon_state = "plain_preview"
		color = "#824B28"
		New()
			material = get_material_by_path(/material/wood)
			..()

	gamblingtable
		icon_state = "gamble_preview"
		New()
			material = get_material_by_path(/material/wood)
			carpeted = 1
			..()

	glass
		icon_state = "plain_preview"
		color = "#00E1FF"
		alpha = 77 // 0.3 * 255
		New()
			material = get_material_by_path(/material/glass)
			..()

	holotable
		icon_state = "holo_preview"
		color = "#EEEEEE"
		New()
			material = get_material_by_name("holo[DEFAULT_TABLE_MATERIAL]")
			..()

	woodentable/holotable
		icon_state = "holo_preview"
		New()
			material = get_material_by_path(/material/wood/holographic)
			..()
