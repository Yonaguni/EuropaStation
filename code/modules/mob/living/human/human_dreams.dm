/mob/living/human/proc/dream()
	dreaming = 1
	spawn(0)
		for(var/i = rand(1,4),i > 0, i--)
			src << "\blue <i>... [pick(dreams)] ...</i>"
			sleep(rand(40,70))
			if(paralysis <= 0)
				dreaming = 0
				return 0
		dreaming = 0
		return 1

/mob/living/human/proc/handle_dreams()
	if(client && !dreaming && prob(5))
		dream()
