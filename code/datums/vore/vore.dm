/datum/vore_controller
	var/mob/living/pred = null
	var/mob/living/prey = null
/datum/vore_controller/proc/swallow()
	user.visible_message("<span class='danger'=[pred] is trying to swallow [prey] whole!</span>")
	pred.belly_contents.Add(prey)
	qdel(src)

/datum/vore_controller/belly
	var/stomach_damage
	var/belly_contents = list()
	stomach_damage = rand(1 to 100)
	/mob/living/carbon/human/health = maxHealth - stomach_damage