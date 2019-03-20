#define SKYBOX_PLANE              -100
#define SPACE_LAYER                  0
#define SKYBOX_LAYER                 1

#define DUST_PLANE                 -99
#define DUST_LAYER                   0

//Reserve planes for openspace
#define OPENSPACE_PLANE            -98
#define OVER_OPENSPACE_PLANE        -3
#define CLICKCATCHER_PLANE          -2

#define DEFAULT_PLANE                0
#define PLATING_LAYER                1
#define TURF_DETAIL_LAYER            2
#define HOLOMAP_LAYER                3
#define DISPOSALS_PIPE_LAYER         4
#define LATTICE_LAYER                5
#define PIPE_LAYER                   6
#define WIRE_LAYER                   7
#define TERMINAL_LAYER               8
#define RUNE_LAYER                   9
#define BASE_TURF_LAYER             10
#define DECAL_LAYER                 11
#define ABOVE_TILE_LAYER            12
#define EXPOSED_PIPE_LAYER          13
#define EXPOSED_WIRE_LAYER          14
#define EXPOSED_TERMINAL_LAYER      15
#define ABOVE_WIRE_LAYER            16
#define CATWALK_LAYER               17
#define BLOOD_LAYER                 18
#define MOUSETRAP_LAYER             19
#define PLANT_LAYER                 20
#define HIDING_MOB_LAYER            21
#define SHALLOW_FLUID_LAYER         22
#define AO_LAYER                    23
#define BELOW_DOOR_LAYER            24
#define OPEN_DOOR_LAYER             25
#define BELOW_TABLE_LAYER           26
#define TABLE_LAYER                 27
#define BELOW_OBJ_LAYER             28
#define BASE_OBJECT_LAYER           29
#define STRUCTURE_LAYER             30
#define ABOVE_OBJ_LAYER             31
#define CLOSED_DOOR_LAYER           32
#define ABOVE_DOOR_LAYER            33
#define SIDE_WINDOW_LAYER           34
#define FULL_WINDOW_LAYER           35
#define ABOVE_WINDOW_LAYER          36
#define BASE_MOB_LAYER              37
#define LYING_MOB_LAYER             38
#define LYING_HUMAN_LAYER           39
#define BASE_ABOVE_OBJ_LAYER        40
#define ABOVE_HUMAN_LAYER           41
#define VEHICLE_LOAD_LAYER          42
#define CAMERA_LAYER                43
#define BLOB_SHIELD_LAYER           44
#define BLOB_NODE_LAYER             45
#define BLOB_CORE_LAYER	            46
#define BELOW_PROJECTILE_LAYER      47
#define FIRE_LAYER                  48
#define PROJECTILE_LAYER            49
#define ABOVE_PROJECTILE_LAYER      50
#define SINGULARITY_LAYER           51
#define POINTER_LAYER               52
#define OBSERVER_LAYER              53
#define LIGHTBULB_LAYER             54
#define FLOODING_LAYER              55
#define GAS_LAYER                   56
#define LIGHTING_LAYER              57
#define ABOVE_LIGHTING_LAYER        58
#define EYE_GLOW_LAYER              59
#define BEAM_PROJECTILE_LAYER       60
#define OBFUSCATION_LAYER           61
#define BASE_AREA_LAYER             62

#define HUD_PLANE                    1
#define UNDER_HUD_LAYER              0
#define FULLSCREEN_LAYER             1
#define IMPAIRED_LAYER               2
#define BLIND_LAYER                  3
#define CRIT_LAYER                   4
#define DAMAGE_LAYER                 5
#define HUD_BASE_LAYER               6
#define HUD_ITEM_LAYER               7
#define HUD_ABOVE_ITEM_LAYER         8

/atom
	plane = DEFAULT_PLANE

/image
	plane = FLOAT_PLANE			// this is defunct, lummox fixed this on recent compilers, but it will bug out if I remove it for coders not on the most recent compile.

/atom/proc/hud_layerise()
	plane = HUD_PLANE
	layer = HUD_ITEM_LAYER

/atom/proc/reset_plane_and_layer()
	plane = initial(plane)
	layer = initial(layer)
