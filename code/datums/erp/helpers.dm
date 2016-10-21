// is_helpers
/datum/forbidden_controller/proc/is_oral(action)
	return (action == CUNNILINGUS || action == BLOWJOB)

/datum/forbidden_controller/proc/is_fuck(action)
	return (action == ANAL || action == VAGINAL || action == MOUTHFUCK)
// is helpers end

//to string
/datum/forbidden_controller/proc/action_string(action)
	switch(action)
		if(CUNNILINGUS)
			return "CUNNILINGUS"
		if(BLOWJOB)
			return "BLOWJOB"
		if(ANAL)
			return "ANAL"
		if(VAGINAL)
			return "VAGINAL"
		if(MOUTHFUCK)
			return "MOUTHFUCK"
//to string end

// can fuck
/datum/forbidden_controller/proc/can_fuck(mob/living/carbon/human/who, action)
	if(!istype(who) || owner.stat == DEAD)
		return 0

	if(!who.erp_controller || !check_species(owner) || !check_species(who))
		return 0

	var/datum/forbidden_controller/erp_c = who.erp_controller

	if(action == erp_c.fucked_action && erp_c.fucked != owner)
		return 0

	if(is_fuck(action) && is_fuck(erp_c.fucking_action) && erp_c.fucking == owner)
		return 0

	switch(action)
		if(CUNNILINGUS)
			if(erp_c.fucked_action == VAGINAL && erp_c.fucked != owner)
				return 0
		if(BLOWJOB)
			if(is_fuck(erp_c.fucking_action) && erp_c.fucked != owner)
				return 0
		if(VAGINAL)
			if(erp_c.fucked_action == CUNNILINGUS && erp_c.fucked != owner)
				return 0
		if(MOUTHFUCK)
			if(is_oral(erp_c.fucking_action) && erp_c.fucking != owner)
				return 0
	return 1
// can fuck end

/datum/forbidden_controller/proc/check_species(mob/living/carbon/human/who)
	if(who.species.name in erp_blacklist_species)
		return 0
	return 1

/mob/living/carbon/human/Move()
	. = ..()
	if(erp_controller.fucking && get_dist(erp_controller.fucking, src) > 1)
		erp_controller.fucking.erp_controller.fucked = null
		erp_controller.fucking.erp_controller.fucked_action = null

		erp_controller.fucking = null
		erp_controller.fucking_action = null
	if(erp_controller.fucked && get_dist(erp_controller.fucked, src) > 1)
		erp_controller.fucked.erp_controller.fucking = null
		erp_controller.fucked.erp_controller.fucking_action = null

		erp_controller.fucked = null
		erp_controller.fucked_action = null