#define PARTIAL_UNIFORM_FULL  "full"
#define PARTIAL_UNIFORM_OVER  "jumpsuit"
#define PARTIAL_UNIFORM_LOWER "pants"
#define PARTIAL_UNIFORM_UPPER "shirt"
#define PARTIAL_UNIFORM_SKIN  "skin"
// Higher == drawn first.
GLOBAL_LIST_INIT(partial_uniform_layer_order, list(PARTIAL_UNIFORM_SKIN, PARTIAL_UNIFORM_FULL, PARTIAL_UNIFORM_UPPER, PARTIAL_UNIFORM_LOWER, PARTIAL_UNIFORM_OVER))

#define DEFINE_COLOR_VARIANT(clothing_path, clothing_color, color_name, color_name_str, clothing_name) \
##clothing_path/##color_name/color = clothing_color; \
##clothing_path/##color_name/name = color_name_str + " " + clothing_name;

#define POPULATE_COLOURED_VARIANTS_OF(clothing_path, clothing_name) \
DEFINE_COLOR_VARIANT(##clothing_path, COLOR_WHITE,      white,     "white",      clothing_name); \
DEFINE_COLOR_VARIANT(##clothing_path, COLOR_SILVER,     silver,    "silver",     clothing_name); \
DEFINE_COLOR_VARIANT(##clothing_path, COLOR_GRAY,       gray,      "gray",       clothing_name); \
DEFINE_COLOR_VARIANT(##clothing_path, COLOR_DARK_GRAY,  black,     "black",      clothing_name); \
DEFINE_COLOR_VARIANT(##clothing_path, COLOR_RED,        red,       "red",        clothing_name); \
DEFINE_COLOR_VARIANT(##clothing_path, COLOR_MAROON,     maroon,    "maroon",     clothing_name); \
DEFINE_COLOR_VARIANT(##clothing_path, COLOR_YELLOW,     yellow,    "yellow",     clothing_name); \
DEFINE_COLOR_VARIANT(##clothing_path, COLOR_OLIVE,      olive,     "olive",      clothing_name); \
DEFINE_COLOR_VARIANT(##clothing_path, COLOR_LIME,       lime,      "lime",       clothing_name); \
DEFINE_COLOR_VARIANT(##clothing_path, COLOR_GREEN,      green,     "green",      clothing_name); \
DEFINE_COLOR_VARIANT(##clothing_path, COLOR_CYAN,       cyan,      "cyan",       clothing_name); \
DEFINE_COLOR_VARIANT(##clothing_path, COLOR_TEAL,       teal,      "teal",       clothing_name); \
DEFINE_COLOR_VARIANT(##clothing_path, COLOR_BLUE,       blue,      "blue",       clothing_name); \
DEFINE_COLOR_VARIANT(##clothing_path, COLOR_BLUE_LIGHT, lightblue, "light blue", clothing_name); \
DEFINE_COLOR_VARIANT(##clothing_path, COLOR_NAVY_BLUE,       navy,      "navy",       clothing_name); \
DEFINE_COLOR_VARIANT(##clothing_path, COLOR_PINK,       pink,      "pink",       clothing_name); \
DEFINE_COLOR_VARIANT(##clothing_path, COLOR_PURPLE,     purple,    "purple",     clothing_name); \
DEFINE_COLOR_VARIANT(##clothing_path, COLOR_ORANGE,     orange,    "orange",     clothing_name); \
DEFINE_COLOR_VARIANT(##clothing_path, COLOR_BEIGE,      beige,     "beige",      clothing_name); \
DEFINE_COLOR_VARIANT(##clothing_path, COLOR_BROWN,      brown,     "brown",      clothing_name);