/datum/vore_controller/
	var/mob/living/carbon/human/owner
	var/list/belly_contents = list()

/datum/vore_controller/New(mob/living/carbon/human/own)
	if(!istype(own))
		return
	owner = own

/datum/vore_controller/proc/swallow(mob/living/carbon/human/prey)
	prey.forceMove(owner)
	belly_contents.Add(prey)
	digest(prey)

/datum/vore_controller/proc/digest(mob/living/carbon/human/prey)
	var/bruteloss = 1
	while(1)
		prey.adjustBruteLoss(bruteloss)
		if(prey.health <= -90) // 0 = critical, -90 = death
			absorb(prey)
			break

/datum/vore_controller/proc/absorb(mob/living/carbon/human/prey)
	owner.nutrition = 450

	owner.visible_message("<span class='notice'>[owner] digests [prey] and absorbs it's remains!</span>", "<span class='notice'>You digest [prey] and absorb it's remains!</span>")
	to_chat(prey, "<span class='notice'>You have been digested and absorbed in [owner]'s body!</span>")

	belly_contents.Remove(prey)
	qdel(prey)