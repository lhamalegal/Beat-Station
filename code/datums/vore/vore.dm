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
	prey.forceMove(pred)

/datum/vore_controller/proc/digest()
	var/bruteloss = 5
	prey.adjustBruteLoss(bruteloss)
	if(prey.health <= 0)
		absorb(prey)

/datum/vore_controller/proc/absorb()
	pred.nutrition = 100
	belly_contents.Remove(prey)
	qdel(prey)
	pred.visible_message("<span class='notice'>[pred] digests [prey] and absorbs it's remains!</span>", "<span class='notice'>You digest [prey] and absorbs it's remains!</span>")
	to_chat(prey, "<span class='notice'>You are digested and absorbed into [pred]'s body!</span>")
