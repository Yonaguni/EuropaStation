/proc/build_intent_selector(var/datum/hud/building_for, var/_color = "#FFFFFF", var/_alpha = 255)

	var/obj/screen/using = new /obj/screen()

	using.name = "act_intent"
	using.icon = 'icons/screen/intent_selector.dmi'
	using.icon_state = "intent_" + building_for.mymob.a_intent
	using.screen_loc = ui_acti
	using.color = _color
	using.alpha = _alpha
	using.layer = SCREEN_LAYER

	building_for.adding += using
	building_for.action_intent = using
	. = using

	//intent small hud objects
	var/icon/ico = new('icons/screen/intent_selector.dmi', "black")
	ico.MapColors(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, -1,-1,-1,-1)
	ico.DrawBox(rgb(255,255,255,1),1,ico.Height()/2,ico.Width()/2,ico.Height())
	using = new /obj/screen(building_for)
	using.name = I_HELP
	using.icon = ico
	using.screen_loc = ui_acti
	using.alpha = _alpha
	using.layer = SCREEN_LAYER + 0.1

	building_for.adding += using
	building_for.help_intent = using

	ico = new('icons/screen/intent_selector.dmi', "black")
	ico.MapColors(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, -1,-1,-1,-1)
	ico.DrawBox(rgb(255,255,255,1),ico.Width()/2,ico.Height()/2,ico.Width(),ico.Height())
	using = new /obj/screen(building_for)
	using.name = I_DISARM
	using.icon = ico
	using.screen_loc = ui_acti
	using.alpha = _alpha
	using.layer = SCREEN_LAYER + 0.1

	building_for.adding += using
	building_for.disarm_intent = using

	ico = new('icons/screen/intent_selector.dmi', "black")
	ico.MapColors(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, -1,-1,-1,-1)
	ico.DrawBox(rgb(255,255,255,1),ico.Width()/2,1,ico.Width(),ico.Height()/2)
	using = new /obj/screen(building_for)
	using.name = I_GRAB
	using.icon = ico
	using.screen_loc = ui_acti
	using.alpha = _alpha
	using.layer = SCREEN_LAYER + 0.1

	building_for.adding += using
	building_for.grab_intent = using

	ico = new('icons/screen/intent_selector.dmi', "black")
	ico.MapColors(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, -1,-1,-1,-1)
	ico.DrawBox(rgb(255,255,255,1),1,1,ico.Width()/2,ico.Height()/2)
	using = new /obj/screen(building_for)
	using.name = I_HURT
	using.icon = ico
	using.screen_loc = ui_acti
	using.alpha = _alpha
	using.layer = SCREEN_LAYER + 0.1

	building_for.adding += using
	building_for.hurt_intent = using
	//end intent small hud objects