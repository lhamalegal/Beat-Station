/datum/vore_controller/
	var/mob/living/carbon/human/prey
	var/mob/living/carbon/human/pred
	var/list/belly_contents = list()

/datum/vore_controller/New(mob/living/owner)
	pred = owner

/datum/vore_controller/proc/swallow()
	prey.loc = pred
	belly_contents.Add(prey)
	digest(prey)

/datum/vore_controller/proc/digest()
	var/bruteloss = 5
	prey.adjustBruteLoss(bruteloss)