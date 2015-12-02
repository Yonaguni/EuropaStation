/*
	This system is designed to move away from the 'magical microwave' way of cooking.  Instead of putting everything into
	a microwave and turning it on, you place different food items into a 'container' (like a frying pan), heat it up,
	then take it out when done.
*/

#define METHOD_DICING  "dice" // thing + knife
#define METHOD_FRYING  "fry"  // thing + frying pan + stove
#define METHOD_BOILING "boil" // thing + pot + water + stove
#define METHOD_BAKING  "bake" // thing + tray/cake tin + oven
#define METHOD_MIXING  "mix"  // thing + bowl + mixing implement

var/list/food_transitions = list()
var/list/ignore_transition_types = list(
	/decl/food_transition,
	/decl/food_transition/boiled,
	/decl/food_transition/fried,
	/decl/food_transition/baked,
	/decl/food_transition/diced,
	/decl/food_transition/mixed
	)

proc/populate_food_transitions()
	food_transitions = list()
	for(var/transition_type in (typesof(/decl/food_transition)-ignore_transition_types))
		var/decl/food_transition/T = new transition_type
		if(isnull(T.cooking_method))
			continue
		if(!islist(food_transitions[T.cooking_method]))
			food_transitions[T.cooking_method] = list()
		food_transitions[T.cooking_method] |= T

proc/get_food_transition(var/obj/item/I, var/method, var/cooking_time, var/datum/reagents/input_reagents, var/obj/item/container)
	if(!islist(food_transitions) || !food_transitions.len)
		populate_food_transitions()
	var/list/transitions = food_transitions[method]
	if(!islist(transitions) || !transitions.len)
		return null
	var/decl/food_transition/high_priority
	for(var/decl/food_transition/F in transitions)
		if(cooking_time >= F.cooking_time && F.matches_input_type(I, container) && F.check_for_reagents(input_reagents))
			if(!high_priority || high_priority.priority < F.priority)
				high_priority = F
	return high_priority
