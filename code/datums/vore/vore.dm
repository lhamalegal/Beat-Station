/datum/vore_controller/
	var/pred
	var/prey
	var/belly_contents = list()

/datum/vore_controller/New(mob/living/owner)
	pred = owner

/datum/vore_controller/swallow()
	prey.loc = pred
	belly_contents.Add(prey)
	digest(prey)

/datum/vore_controller/digest()
