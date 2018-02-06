/obj/item/gun/composite/examine()
	..()

	if(usr && usr.Adjacent(get_turf(src)))
		if(dam_type == GUN_TYPE_LASER)
			usr << "This one is \a [caliber] projector."
		else
			usr << "This one fires [caliber] rounds."
		usr << "It has [chamber.get_shots_remaining()] shots remaining."

		for(var/obj/item/gun_component/GC in src)
			var/extra = GC.get_extra_examine_info()
			if(extra)
				usr << "<span class='notice'>[extra]</span>"

		if(accessories.len)
			var/accessory_list = list()
			for(var/obj/item/acc in accessories)
				accessory_list += "\a [acc.name]"
			usr << "[english_list(accessories)] [accessories.len == 1 ? "is" : "are"] installed."

		var/list/result = list()

		var/max_shots = chamber.get_max_shots(model ? model.produced_by.capacity : 1)

		var/fdelay = fire_delay/10
		result += "It has a fire delay of [fdelay] second[fdelay==1 ? "" : "s"]."
		result += "It can hold a maximum of [max_shots] shot[max_shots==1 ? "" : "s"]."

		var/rec
		switch(recoil)
			if(1)
				rec = "noticeable"
			if(2)
				rec = "strong"
			if(3)
				rec = "very strong"
			if(4 to INFINITY)
				rec = "insane"
			else
				rec = "negligible"
		result += "It has [rec] recoil."

		switch(accuracy)
			if(7 to INFINITY)
				result += "This weapon is exceptionally accurate."
			if(3 to 7)
				result += "This weapon is very accurate."
			if(1 to 3)
				result += "This weapon is fairly accurate."
			if(0 to 1)
				result += "This weapon is of average accuracy."
			if(-1 to 0)
				result += "This weapon is inaccurate."
			if(-3 to -1)
				result += "This weapon is more of a spray and pray."
			if(-INFINITY to -3)
				result += "This weapon is wildly inaccurate."

		for (var/obj/item/gun_component/GC in src)
			result += GC.get_examine_text()

		if(firemodes.len)
			result += "This weapon has multiple fire modes, which can be changed by clicking the gun in-hand."

		to_chat(usr, jointext(result, "<br>"))
