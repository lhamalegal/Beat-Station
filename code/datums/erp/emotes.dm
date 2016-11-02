/*
 *
 * EMOTE DECLARATION
 *
 */


/datum/forbidden/emote
	var/name
	var/HPleasure	// How much pleasure who is giving the action receive
	var/PPleasure	// How much pleasure who is receiving the action receive
					// This is a base, can be more or less

	var/HHole		// Used when who is giving the action cums
	var/PHole		// Used when who is receiving the action cums

/datum/forbidden/emote/proc/actionButton(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return

/datum/forbidden/emote/proc/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return -1

	//	return -1 = button doesn't appears on UI
	//	return 0 = disabled button
	//	return 1 = clickable button

/datum/forbidden/emote/proc/showText(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	return

/datum/forbidden/emote/proc/logAction(mob/living/carbon/human/H, mob/living/carbon/human/P, text = null)
	if(text)
		add_logs(P, H, text)

/datum/forbidden/emote/proc/doAction(mob/living/carbon/human/H, mob/living/carbon/human/P, begins = 0)
	if(HPleasure)
		H.pleasure += HPleasure * rand(0.9, 1.2)
		if(H.pleasure >= MAX_PLEASURE)
			H.cum(P, HHole ? HHole : "floor")

	if(PPleasure)
		P.pleasure += PPleasure * rand(0.9, 1.2)
		if(P.pleasure >= MAX_PLEASURE)
			P.cum(H, PHole ? PHole : "floor")

/*
 *
 * EMOTES
 *
 */

// Kiss
/datum/forbidden/emote/kiss
	name = "kiss"
	HPleasure = 1	// How much pleasure who is giving the action receive
	PPleasure = 1	// How much pleasure who is receiving the action receive

	HHole = "floor"
	PHole = "floor"

/datum/forbidden/emote/kiss/actionButton(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return "Kiss [P.gender == FEMALE ? "her" : "his"] lips"

/datum/forbidden/emote/kiss/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(get_dist(H, P) > 1)
		return -1
	if(H.incapacitated())
		return -1
	if(P == H)
		return -1
	if(!H.check_has_mouth() || !P.check_has_mouth())
		return -1

	if(!H.is_face_clean() || !P.is_face_clean())
		return 0

	return 1

/datum/forbidden/emote/kiss/showText(mob/living/carbon/human/H, mob/living/carbon/human/P)
	H.visible_message("<span class='erp'><b>[H]</b> kisses <b>[P]</b>.</span>")

/datum/forbidden/emote/kiss/logAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..(H, P, "kissed")

/datum/forbidden/emote/kiss/doAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..()

// Lick (tajaran kiss)
/datum/forbidden/emote/lick
	name = "lick"
	HPleasure = 1	// How much pleasure who is giving the action receive
	PPleasure = 1	// How much pleasure who is receiving the action receive

	HHole = "floor"
	PHole = "floor"

/datum/forbidden/emote/lick/actionButton(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return "Lick [P.gender == FEMALE ? "her" : "his"] lips"

/datum/forbidden/emote/lick/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(get_dist(H, P) > 1)
		return -1
	if(H.incapacitated())
		return -1
	if(P == H)
		return -1
	if(!H.check_has_mouth() || !P.check_has_mouth())
		return -1
	if(H.species.name != "Tajaran") // Only tajarans can lick other's lips
		return -1

	if(!H.is_face_clean() || !P.is_face_clean())
		return 0

	return 1

/datum/forbidden/emote/lick/showText(mob/living/carbon/human/H, mob/living/carbon/human/P)
	H.visible_message("<span class='erp'><b>[H]</b> licks [P]'s lips.</span>")

/datum/forbidden/emote/lick/logAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..(H, P, "licked")

/datum/forbidden/emote/lick/doAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..()

// French Kiss
/datum/forbidden/emote/frenchkiss
	name = "french-kiss"
	HPleasure = 1	// How much pleasure who is giving the action receive
	PPleasure = 1	// How much pleasure who is receiving the action receive

	HHole = "floor"
	PHole = "floor"

/datum/forbidden/emote/frenchkiss/actionButton(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return "Give [P.gender == FEMALE ? "her" : "him"] a french kiss"

/datum/forbidden/emote/frenchkiss/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(get_dist(H, P) > 1)
		return -1
	if(H.incapacitated())
		return -1
	if(P == H)
		return -1
	if(!H.check_has_mouth() || !P.check_has_mouth())
		return -1

	if(!H.is_face_clean() || !P.is_face_clean())
		return 0

	return 1

/datum/forbidden/emote/frenchkiss/showText(mob/living/carbon/human/H, mob/living/carbon/human/P)
	H.visible_message("<span class='erp'><b>[H]</b> gives <b>[P]</b> a french kiss.</span>")

/datum/forbidden/emote/frenchkiss/logAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..(H, P, "french-kissed")

/datum/forbidden/emote/frenchkiss/doAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..()

// Cheek Kiss
/datum/forbidden/emote/cheekkiss
	name = "cheek-kiss"
	HPleasure = 1	// How much pleasure who is giving the action receive
	PPleasure = 1	// How much pleasure who is receiving the action receive

	HHole = "floor"
	PHole = "floor"

/datum/forbidden/emote/cheekkiss/actionButton(mob/living/carbon/human/H, mob/living/carbon/human/P)
	return "Give [P.gender == FEMALE ? "her" : "him"] a cheek kiss"

/datum/forbidden/emote/cheekkiss/conditions(mob/living/carbon/human/H, mob/living/carbon/human/P)
	if(get_dist(H, P) > 1)
		return -1
	if(H.incapacitated())
		return -1
	if(P == H)
		return -1
	if(!H.check_has_mouth() || !P.check_has_mouth())
		return -1

	if(!H.is_face_clean() || !P.is_face_clean())
		return 0

	return 1

/datum/forbidden/emote/cheekkiss/showText(mob/living/carbon/human/H, mob/living/carbon/human/P)
	H.visible_message("<span class='erp'><b>[H]</b> gives <b>[P]</b> a cheek kiss.</span>")

/datum/forbidden/emote/cheekkiss/logAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..(H, P, "cheek-kissed")

/datum/forbidden/emote/cheekkiss/doAction(mob/living/carbon/human/H, mob/living/carbon/human/P)
	..()