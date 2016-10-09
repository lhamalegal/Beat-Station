// Begins to text
/datum/forbidden_controller/proc/begins_text(action, mob/living/carbon/human/who)
	// Oral messages
	if(action == BLOWJOB)
		if(who.gender == MALE)
			owner.visible_message("<span class='erp'><b>[owner]</b> begins to suck [who]'s cock.</span>")
	else if(action == CUNNILINGUS)
		if(who.gender == FEMALE)
			owner.visible_message("<span class='erp'><b>[owner]</b> begins to lick <b>[who]</b>.</span>")

	// Fuck messages
	else if(action == ANAL)
		if(owner.gender == MALE)
			owner.visible_message("<span class='erp'><b>[owner]</b> begins to fuck [who]'s anus.</span>")
	else if(action == VAGINAL)
		if(owner.gender == MALE && who.gender == FEMALE)
			owner.visible_message("<span class='erp'><b>[owner]</b> begins to [pick("fuck","penetrate")] <b>[who]</b>.</span>")
	else if(action == MOUTHFUCK)
		if(owner.gender == MALE)
			owner.visible_message("<span class='erp'><b>[owner]</b> begins to fuck [who]'s mouth.</span>")



// Action text
/datum/forbidden_controller/proc/fucking_text(action, mob/living/carbon/human/who)
	// Oral actions
	if(action == BLOWJOB)
		if(who.gender == MALE)
			owner.visible_message("<span class='erp'><b>[owner]</b> sucks [who]'s cock.</span>")
	else if(action == CUNNILINGUS)
		if(who.gender == FEMALE)
			owner.visible_message("<span class='erp'><b>[owner]</b> licks <b>[who]</b>.</span>")

	// Fuck actions
	else if(action == ANAL)
		if(owner.gender == MALE)
			if(who.erp_controller.anal_virgin)
				owner.visible_message("<span class='erp'><b>[owner]</b> tears [who]'s anus to pieces.</span>")
			else
				owner.visible_message("<span class='erp'><b>[owner]</b> fucks [who]'s anus.</span>")
	else if(action == VAGINAL)
		if(owner.gender == MALE && who.gender == FEMALE)
			if(who.erp_controller.virgin)
				owner.visible_message("<span class='erp'><b>[owner]</b> mercilessly tears [who]'s hymen!</span>")
			else
				owner.visible_message("<span class='erp'><b>[owner]</b> [pick("fucks","penetrates")] <b>[who]</b>.</span>")
	else if(action == MOUTHFUCK)
		if(owner.gender == MALE)
			owner.visible_message("<span class='erp'><b>[owner]</b> fucks [who]'s mouth.</span>")



// Cum text
/datum/forbidden_controller/proc/cum_text()
	if(owner.gender == MALE)
		if(fucking_action == ANAL)
			owner.visible_message("<span class='cum'>[owner] cums into [fucking]'s ass!</span>")
		else if(fucking_action == VAGINAL)
			owner.visible_message("<span class='cum'>[owner] cums into <b>[fucking]</b>!</span>")
		else if(fucking_action == MOUTHFUCK)
			owner.visible_message("<span class='cum'>[owner] cums into [fucking]'s mouth!</span>")
		else if(fucked_action == BLOWJOB)
			owner.visible_message("<span class='cum'>[owner] cums into [fucked]'s mouth!</span>")
		else
			owner.visible_message("<span class='cum'>[owner] cums on the floor!</span>")
			var/obj/effect/decal/cleanable/sex/cum = new /obj/effect/decal/cleanable/sex/semen(owner.loc)
			cum.add_blood_list(owner)

	else if(owner.gender == FEMALE)
		owner.visible_message("<span class='cum'>[owner] cums!</span>")
		var/obj/effect/decal/cleanable/sex/cum = new /obj/effect/decal/cleanable/sex/femjuice(owner.loc)
		cum.add_blood_list(owner)