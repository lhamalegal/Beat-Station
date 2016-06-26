/mob/living/simple_animal/goose
	name = "goose"
	real_name = "goose"
	desc = "It's a goose!"
	icon_state = "goose"
	icon_living = "goose"
	icon_dead = "goose_dead"
	speak = list("fuck this shit")
	speak_emote = list("flaps")
	emote_hear = list("flaps")
	emote_see = list("flaps")
	small = 1
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	maxHealth = 5
	health = 5
	butcher_results = list(/obj/item/weapon/reagent_containers/food/snacks/meat = 1)
	response_help  = "flaps"
	response_disarm = "gently pushes aside"
	response_harm   = "stamps on"
	density = 0
	ventcrawler = 2
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	var/goose_type
	layer = MOB_LAYER
	atmos_requirements = list("min_oxy" = 16, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 223		//Below -50 Degrees Celcius
	maxbodytemp = 323	//Above 50 Degrees Celcius
	universal_speak = 0
	can_hide = 0
	holder_type = /obj/item/weapon/holder/goose
	can_collar = 1
	gold_core_spawnable = CHEM_MOB_SPAWN_FRIENDLY

/mob/living/simple_animal/goose/clown/handle_automated_speech()
	..()
	if(prob(speak_chance))
		for(var/mob/M in view())
			M << 'sound/items/bikehorn.ogg'

/mob/living/simple_animal/goose/Life()
	. = ..()
	if(stat == UNCONSCIOUS)
		if(ckey || prob(1))
			stat = CONSCIOUS
			icon_state = "goose_[goose_type]"
			wander = 1
		else if(prob(5))
			emote("snuffles")

/mob/living/simple_animal/goose/process_ai()
	..()

	if(prob(0.5))
		stat = UNCONSCIOUS
		icon_state = "goose_[goose_type]_dead"
		wander = 0
		speak_chance = 0

/mob/living/simple_animal/goose/New()
	..()
	if(!goose_type)
		goose_type = "normal"
	icon_state = "goose_[goose_type]"
	icon_living = "goose_[goose_type]"
	icon_dead = "goose_[goose_type]_dead"
	if(goose_type == "clown")
		desc = "Says the legends that goose ate a bicycle horn, this explains why it is so annoying."
	else
		desc = "It's a goose!"

/mob/living/simple_animal/goose/attack_hand(mob/living/carbon/human/M as mob)
	if(M.a_intent == I_HELP)
		get_scooped(M)
	..()

/mob/living/simple_animal/goose/death()
	if(goose_type == "clown")
		desc = "HONK is dead."
	layer = MOB_LAYER
	if(client)
		client.time_died_as_mouse = world.time
	..()

/mob/living/simple_animal/goose/clown
	name = "Gonk"
	desc = "Says the legends that goose ate a bicycle horn, this explains why it is so annoying."
	goose_type = "clown"
	response_help = "honks"
	response_disarm = "gently pushes aside"
	response_harm   = "splats"
	gold_core_spawnable = CHEM_MOB_SPAWN_INVALID
	speak = list("Honk!","HONK!","Honk?")
	speak_emote = list("honks")
	emote_hear = list("honks")
	emote_see = list("runs in a honk", "honks", "honks at something")