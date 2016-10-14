/*
	This module is used to generate the debris fields/distribution maps/procedural stations.
*/

#define MIN_SURFACE_COUNT 500
#define MIN_RARE_COUNT 200
#define MIN_DEEP_COUNT 100
#define RESOURCE_HIGH_MAX 4
#define RESOURCE_HIGH_MIN 2
#define RESOURCE_MID_MAX 3
#define RESOURCE_MID_MIN 1
#define RESOURCE_LOW_MAX 1
#define RESOURCE_LOW_MIN 0

#define FLOOR_CHAR 0
#define WALL_CHAR 1
#define DOOR_CHAR 2
#define EMPTY_CHAR 3
#define ROOM_TEMP_CHAR 4
#define MONSTER_CHAR 5
#define ARTIFACT_TURF_CHAR 6
#define ARTIFACT_CHAR 7
#define CORRIDOR_TURF_CHAR 8

#define GET_MAP_CELL(X, Y) min(map.len, max(0,(((Y-1)*limit_x)+X)))
#define IS_P_TWO(VAL) ((VAL & (VAL-1)) == 0)
#define ROUND_TO_P_TWO(VAL) (2 ** -round(-log(2,VAL)))