/mob/proc/get_dna_hash()
	return md5("DNA\ref[src]DNA") // This is to make it distinct from fingerprints.

/mob/living/carbon/human/proc/reset_dna()
	dna_hash_cached = null

/mob/living/carbon/human/var/dna_hash_cached
/mob/living/carbon/human/get_dna_hash()
	if(!dna_hash_cached)
		dna_hash_cached = md5("\ref[src]\ref[species][gender][b_type][r_skin][g_skin][b_skin][r_hair][g_hair][b_hair][r_facial][g_facial][b_facial][r_eyes][g_eyes][b_eyes]")
	return dna_hash_cached