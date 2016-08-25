/*
	These defines specificy screen locations.  For more information, see the byond documentation on the screen_loc var.
*/

#define ui_entire_screen "WEST,SOUTH to EAST,NORTH"

//Lower left, persistant menu
#define ui_inventory "WEST:6,SOUTH:5"
#define ui_sstore1 "WEST+2:10,SOUTH:5"
#define ui_id "WEST+4:12,SOUTH:5"
#define ui_belt "WEST+6:14,SOUTH:5"
#define ui_back "WEST+8:14,SOUTH:5"
#define ui_rhand "WEST+10:16,SOUTH:5"
#define ui_lhand "WEST+12:16,SOUTH:5"
#define ui_equip "WEST+10:16,SOUTH+2:5"
#define ui_swaphand1 "WEST+10:16,SOUTH+2:5"
#define ui_swaphand2 "WEST+12:16,SOUTH+2:5"
#define ui_storage1 "WEST+14:16,SOUTH:5"
#define ui_storage2 "WEST+16:16,SOUTH:5"

//Lower right, persistant menu
#define ui_drop_throw "EAST-2:28,SOUTH+2:7"
#define ui_pull_resist "EAST-4:26,SOUTH+2:7"
#define ui_acti "EAST-4:26,SOUTH:5"
#define ui_movi "EAST-6:24,SOUTH:5"
#define ui_zonesel "EAST-2:28,SOUTH:5"
#define ui_acti_alt "EAST-2:28,SOUTH:5" //alternative intent switcher for when the interface is hidden (F12)

//Gun buttons
#define ui_gun1 "EAST-4:26,SOUTH+4:7"
#define ui_gun2 "EAST-2:28, SOUTH+6:7"
#define ui_gun3 "EAST-4:26,SOUTH+6:7"
#define ui_gun_select "EAST-2:28,SOUTH+4:7"
#define ui_gun4 "EAST-6:24,SOUTH+4:7"

//Upper-middle right (damage indicators)
#define ui_toxin "EAST-1:28,NORTH-2:27"
#define ui_fire "EAST-1:28,NORTH-4:25"
#define ui_oxygen "EAST-1:28,NORTH-6:23"
#define ui_pressure "EAST-1:28,NORTH-8:21"

//Middle right (status indicators)
#define ui_nutrition "EAST-1:28,CENTER-2:13"
#define ui_temp "EAST-1:28,CENTER-1:13"
#define ui_health "EAST-1:28,CENTER:15"
									//borgs

//Pop-up inventory
#define ui_shoes "WEST+2:8,SOUTH:5"
#define ui_iclothing "WEST:6,SOUTH+2:7"
#define ui_oclothing "WEST+2:8,SOUTH+2:7"
#define ui_gloves "WEST+4:10,SOUTH+2:7"

#define ui_glasses "WEST:6,SOUTH+4:9"
#define ui_mask "WEST+2:8,SOUTH+4:9"
#define ui_l_ear "WEST+4:10,SOUTH+4:9"
#define ui_r_ear "WEST+4:10,SOUTH+6:11"

#define ui_head "WEST+2:8,SOUTH+6:11"

//Intent small buttons
#define ui_help_small "EAST-3:8,SOUTH:1"
#define ui_disarm_small "EAST-3:15,SOUTH:18"
#define ui_grab_small "EAST-3:32,SOUTH:18"
#define ui_harm_small "EAST-3:39,SOUTH:1"

#define ui_hand "CENTER-1:14,SOUTH:5"
#define ui_hstore1 "CENTER-2,CENTER-2"
#define ui_sleep "EAST+1, NORTH-13"
#define ui_rest "EAST+1, NORTH-14"

#define ui_iarrowleft "SOUTH-1,EAST-4"
#define ui_iarrowright "SOUTH-1,EAST-2"
