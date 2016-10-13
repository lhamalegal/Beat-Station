/datum/vore_controller/
	var/mob/living/carbon/human/pred
	var/list/belly_contents = list()

/datum/vore_controller/proc/swallow(mob/living/carbon/human/prey)
	prey.forceMove(pred)
	belly_contents.Add(prey)
	digest(prey)

/datum/vore_controller/proc/digest(mob/living/carbon/human/prey)
	var/bruteloss = 5
	while(1)
		prey.adjustBruteLoss(bruteloss)
		if(prey.health <= -90) // 0 = critical, -90 = death
			absorb(prey)
			break

/datum/vore_controller/proc/absorb(mob/living/carbon/human/prey)
	pred.nutrition = 450

	belly_contents.Remove(prey)
	qdel(prey)

	pred.visible_message("<span class='notice'>[pred] digests [prey] and absorbs it's remains!</span>", "<span class='notice'>You digest [prey] and absorb it's remains!</span>")
	to_chat(prey, "<span class='notice'>You have been digested and absorbed in [pred]'s body!</span>")
