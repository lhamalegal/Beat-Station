/datum/forbidden_controller
	var/mob/living/carbon/human/owner
	var/pleasure = 0

	var/virgin = 1
	var/anal_virgin = 1

	var/penis_size = 0

	var/mob/living/carbon/human/fucked
	var/mob/living/carbon/human/fucking

	var/mob/living/carbon/human/fucking_list[]

	var/fucking_action = "none"
	var/fucked_action = "none"

	var/timevar
	var/click_time

	var/mob/living/carbon/human/source


/datum/forbidden_controller/New(mob/living/carbon/human/own)
	if(!istype(own))
		return 0
	owner = own
	if(owner.gender == MALE)
		penis_size = round(rand(5, 25))


/datum/forbidden_controller/proc/give_pleasure(base = null, f_action = null, mob/living/carbon/human/give_to = null)

	if(!base && f_action && give_to)
		var/datum/forbidden_controller/erp_c = give_to.erp_controller
		switch(f_action)
			if(CUNNILINGUS)
				erp_c.give_pleasure(4)
				give_pleasure(3)
			if(BLOWJOB)
				erp_c.give_pleasure(5)
				give_pleasure(2)
			if(ANAL)
				erp_c.give_pleasure(6)
				give_pleasure(6)
			if(VAGINAL)
				erp_c.give_pleasure(5)
				give_pleasure(5)
			if(MOUTHFUCK)
				erp_c.give_pleasure(2)
				give_pleasure(5)
	else if(base)
		pleasure += (base + rand(-1, 3))

	if(pleasure >= MAX_PLEASURE)
		cum()

/datum/forbidden_controller/proc/fucked(mob/living/carbon/human/by, action)
	fucked_action = action
	fucked = by

	if(is_fuck(action) && fucking == by)
		fucking = null
		fucking_action = null

	// Lose virginity
	if(virgin && action == VAGINAL && owner.gender == FEMALE)
		owner.emote("scream")
		new /obj/effect/decal/cleanable/blood(owner.loc)
		virgin = 0

	if(anal_virgin && action == ANAL)
		anal_virgin = 0

	// Pleasure messages
	if(pleasure >= 70 && prob(15) && owner.gender == FEMALE)
		owner.visible_message("<span class='erp'><b>[owner]</b> twists in orgasm!</span>")

	if(pleasure >= 30 && prob(12))
		owner.visible_message("<span class='erp'><b>[owner]</b> [owner.gender == FEMALE ? pick("moans in pleasure", "moans") : "moans"].</span>")

/datum/forbidden_controller/proc/fucking(mob/living/carbon/human/who, action, auto_pleasure = 1)

	if(!istype(who) || !can_fuck(who, action))
		return 0

	if(!click_check())
		return 0

	owner.face_atom(who)

	who.erp_controller.time_check()

	click_time = world.time + 15
	who.erp_controller.timevar = world.time + 100

	fucking_action = action
	fucking = who

	if(owner in who.erp_controller.fucking_list)
		fucking_text(action, who)
	else
		begins_text(action, who)
		who.erp_controller.fucking_list.Add(owner)

	who.erp_controller.fucked(owner, action)

	if(auto_pleasure)
		give_pleasure(f_action = action, give_to = who)

	if(is_fuck(action))
		fucked = null
		fucked_action = null
		fucking_list = new()

	return 1

/datum/forbidden_controller/proc/masturbate(action)
	if(!click_check())
		return 0
	var/message = ""
	if(action == ANAL)
		if(fucked_action == ANAL)
			return 0
		message = "plays with [owner.gender == MALE ? "his" : "her"] anus."
	else
		if(is_fuck(fucking_action))
			return 0
		if(is_oral(fucked_action))
			return 0
		if(fucking_action == VAGINAL)
			return 0
		message = "masturbates."
	owner.visible_message("<span class ='erp'><b>[owner]</b> [message]</span>")
	give_pleasure(3)
	click_time = world.time + 15

/datum/forbidden_controller/proc/cum()
	if(owner.stat != DEAD)
		var/pleasure_message = pick("... I'M FEELING SO GOOD! ...",  "... It's just INCREDIBLE! ...", "... MORE AND MORE AND MORE! ...")
		to_chat(owner, "<span class='cum'>[pleasure_message]</span>")
		cum_text()
	pleasure = 0

// Checks
/datum/forbidden_controller/proc/time_check()
	if(world.time > timevar)
		fucking_list = new()
		fucked = null
		fucked_action = null

/datum/forbidden_controller/proc/click_check()
	if(world.time >= click_time)
		return 1
	return 0