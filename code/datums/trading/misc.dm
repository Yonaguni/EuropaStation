/datum/trader/ship/pet_shop
	name = "Pet Shop Owner"
	name_language = LANGUAGE_CEPHLAPODA
	origin = "Pet Shop"
	trade_flags = TRADER_GOODS|TRADER_MONEY|TRADER_WANTED_ONLY
	possible_origins = list("Paws-Out", "Pets-R-Smart", "Tentacle Companions", "Pets and Assorted Goods", "Barks and Drools")
	speech = list("hail_generic"    = "Welcome to my pet shop! Here you will find many wonderful companions. Some a bit more... aggressive than others. But companions none the less. I also buy pets, or trade them.",
				"hail_deny"         = "I no longer wish to speak to you.",

				"trade_complete"    = "Remember to give them attention and food. They are living beings, and you should treat them like so.",
				"trade_blacklist"   = "Legally I can' do that. Morally, I refuse to do that.",
				"trade_found_unwanted" = "I only want animals. I don't need food, shiny things, I'm looking for specific ones at that. Ones I already have the cage and food for.",
				"trade_not_enough"   = "I'd give you the animal for free, but I need the money to feed the others. So you must pay in full.",
				"how_much"          = "This is a fine specimen, I believe it will cost you VALUE thalers.",
				"what_want"         = "I have the facilities currently to support",

				"compliment_deny"   = "That was almost charming.",
				"compliment_accept" = "Thank you. I needed that.",
				"insult_good"       = "I ask you to stop. We can be peaceful. I know we can.",
				"insult_bad"        = "My interactions with you are becoming less than fruitful.",
				)

	possible_wanted_items = list(/mob/living/simple_animal/dog         = TRADER_THIS_TYPE,
								/mob/living/simple_animal/cat         = TRADER_THIS_TYPE,
								/mob/living/simple_animal/crab        = TRADER_THIS_TYPE,
								/mob/living/simple_animal/lizard      = TRADER_THIS_TYPE,
								/mob/living/simple_animal/mouse       = TRADER_THIS_TYPE,
								/mob/living/simple_animal/mushroom    = TRADER_THIS_TYPE,
								/mob/living/simple_animal/parrot      = TRADER_THIS_TYPE,
								/mob/living/simple_animal/tomato      = TRADER_THIS_TYPE,
								/mob/living/simple_animal/cow         = TRADER_THIS_TYPE,
								/mob/living/simple_animal/chick       = TRADER_THIS_TYPE,
								/mob/living/simple_animal/chicken     = TRADER_THIS_TYPE,
								/mob/living/simple_animal/hostile/bear= TRADER_THIS_TYPE,
								/mob/living/simple_animal/hostile/retaliate/goat = TRADER_THIS_TYPE,
								/mob/living/simple_animal/hostile/carp = TRADER_THIS_TYPE)

	possible_trading_items = list(/mob/living/simple_animal/dog         = TRADER_THIS_TYPE,
								/mob/living/simple_animal/cat         = TRADER_THIS_TYPE,
								/mob/living/simple_animal/crab        = TRADER_THIS_TYPE,
								/mob/living/simple_animal/lizard      = TRADER_THIS_TYPE,
								/mob/living/simple_animal/mouse       = TRADER_THIS_TYPE,
								/mob/living/simple_animal/mushroom    = TRADER_THIS_TYPE,
								/mob/living/simple_animal/parrot      = TRADER_THIS_TYPE,
								/mob/living/simple_animal/tomato      = TRADER_THIS_TYPE,
								/mob/living/simple_animal/cow         = TRADER_THIS_TYPE,
								/mob/living/simple_animal/chick       = TRADER_THIS_TYPE,
								/mob/living/simple_animal/chicken     = TRADER_THIS_TYPE,
								/mob/living/simple_animal/hostile/bear= TRADER_THIS_TYPE,
								/mob/living/simple_animal/hostile/retaliate/goat = TRADER_THIS_TYPE,
								/mob/living/simple_animal/hostile/carp= TRADER_THIS_TYPE,
								/obj/item/dociler              = TRADER_THIS_TYPE,
								/obj/structure/dogbed                 = TRADER_THIS_TYPE)

/datum/trader/ship/prank_shop
	name = "Prank Shop Owner"
	name_language = LANGUAGE_EAL
	origin = "Prank Shop"
	compliment_increase = 0
	insult_drop = 0
	possible_origins = list("Yacks and Yucks Shop", "The Shop From Which I Sell Humorous Items", "The Prank Gestalt", "The Clown's Armory")
	speech = list("hail_generic" = "We welcome you to our shop of humorous items, we invite you to partake in the experience of being pranked, and pranking someone else.",
				"hail_deny"      = "We cannot do business with you. We are sorry.",

				"trade_complete" = "We thank you for purchasing something. We enjoyed the experience of you doing so and we hope to learn from it.",
				"trade_blacklist"= "We are not allowed to do such. We are sorry.",
				"trade_not_enough"="We have sufficiently experienced giving away goods for free. We wish to experience getting money in return.",
				"how_much"       = "We believe that is worth",
				"what_want"      = "We wish only for the experiences you give us, in all else we want",

				"compliment_deny"= "You are attempting to compliment us.",
				"compliment_accept"="You are attempting to compliment us.",
				"insult_good"    = "You are attempting to insult us, correct?",
				"insult_bad"     = "We do not understand."
				)
	possible_trading_items = list(/obj/item/clothing/mask/gas/clown_hat = TRADER_THIS_TYPE,
								/obj/item/clothing/mask/gas/mime        = TRADER_THIS_TYPE,
								/obj/item/clothing/shoes/clown_shoes    = TRADER_THIS_TYPE,
								/obj/item/clothing/under/clown     = TRADER_THIS_TYPE,
								/obj/item/radio/headset/pda/clown              = TRADER_THIS_TYPE,
								/obj/item/cartridge/clown        = TRADER_THIS_TYPE,
								/obj/item/stamp/clown            = TRADER_THIS_TYPE,
								/obj/item/storage/backpack/clown = TRADER_THIS_TYPE,
								/obj/item/bananapeel             = TRADER_THIS_TYPE,
								/obj/item/reagent_containers/food/snacks/pie = TRADER_THIS_TYPE,
								/obj/item/bikehorn               = TRADER_THIS_TYPE,
								/obj/item/toy/waterflower               = TRADER_THIS_TYPE,
								/obj/item/gun/launcher/pneumatic/small = TRADER_THIS_TYPE,
								/obj/item/gun/composite/premade/revolver/toy = TRADER_THIS_TYPE,
								/obj/item/clothing/mask/fakemoustache   = TRADER_THIS_TYPE,
								/obj/item/grenade/spawnergrenade/fake_carp = TRADER_THIS_TYPE)
