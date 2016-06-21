///////
// ESCAPE
///////
/datum/objective/escape
	explanation_text = "Escape the colony alive and free."

/datum/objective/escape/check_completion()
		return 0

///////
// SURVIVE
///////
/datum/objective/survive
	explanation_text = "Stay alive until the end."

	check_completion()
		if(!owner.current || owner.current.stat == DEAD || isbrain(owner.current))
			return 0		//Brains no longer win survive objectives. --NEO
		if(owner.current != owner.original)
			return 0
		return 1
