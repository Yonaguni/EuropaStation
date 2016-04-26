/datum/ai_mob/animal/hostile/shark
	name = "shark"
	kill_unconscious_targets = 1

/datum/ai_mob/animal/hostile/carp
	name = "carp"
	kill_unconscious_targets = 1
	behavior_type = MOB_AI_HERD
	prey_types = list(/mob/living/human, /mob/living/animal/aquatic/random)
