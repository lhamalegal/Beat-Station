#define CUM_LEVEL		100

#define ORAL_FEMALE		"oral=vagina"
#define ORAL_MALE		"oral=penis"

#define FUCK_ANUS		"fuck=anus"
#define FUCK_VAGINA		"fuck=vagina"
#define FUCK_MOUTH		"fuck=mouth"

/datum/forbidden_controller
	var/mob/living/carbon/human/owner
	var/pleasure = 0

	var/virgin = 1
	var/anal_virgin = 1

	var/penis_size = 0

	var/mob/living/carbon/human/fucked
	var/mob/living/carbon/human/fucking

	var/fucking_action = "none"
	var/fucked_action = "none"

	var/mob/living/carbon/human/source

/datum/forbidden_controller/New(mob/living/carbon/human/own)
	owner = own
	if(owner.gender == MALE)
		penis_size = round(rand(5, 25))

/datum/forbidden_controller/proc/give_pleasure(to_add)
	pleasure += to_add
	if(pleasure >= CUM_LEVEL)
		cum()

/datum/forbidden_controller/proc/fucked(mob/living/carbon/human/by, action)
	fucked_action = action
	fucked = by

	// Lose virginity
	if(virgin && action == FUCK_VAGINA && owner.gender == FEMALE)
		owner.emote("scream")
		new /obj/effect/decal/cleanable/blood(owner.loc)
		virgin = 0

	if(anal_virgin && action == FUCK_ANUS)
		owner.emote("scream")
		anal_virgin = 0

	if(pleasure >= 50 && prob(30) && owner.gender == FEMALE)
		owner.visible_message("<span class='erp'><b>[owner]</b> twists in orgasm!</span>")

	if(pleasure >= 10 && prob(40))
		var/vr = pick("moans in pleasure", "moans")
		owner.visible_message("<span class='erp'><b>[owner]</b> [vr].</span>")

/datum/forbidden_controller/proc/fucking(mob/living/carbon/human/who, action)
	if(!istype(who))
		return
	fucking_action = action
	fucking = who

	who.erp_controller.fucked(owner, action)

	// ORAL
	if(action == ORAL_MALE)
		if(fucking.gender == MALE)
			owner.visible_message("<span class='erp'><b>[owner]</b> sucks [fucking]'s cock.</span>")
	else if(action == ORAL_FEMALE)
		if(fucking.gender == FEMALE)
			owner.visible_message("<span class='erp'><b>[owner]</b> licks [fucking].</span>")

	// FUCK
	else if(action == FUCK_ANUS)
		if(owner.gender == MALE)
			if(fucking.erp_controller.anal_virgin)
				owner.visible_message("<span class='erp'><b>[owner]</b> tears [fucking]'s anus to pieces.</span>")
			else
				owner.visible_message("<span class='erp'><b>[owner]</b> fucks [fucking]'s anus.</span>")
	else if(action == FUCK_VAGINA)
		if(owner.gender == MALE)
			if(fucking.erp_controller.virgin)
				owner.visible_message("<span class='erp'><b>[owner]</b> mercilessly tears [fucking]'s hymen!</span>")
			else
				var/vb = pick("fucks", "penetrates")
				owner.visible_message("<span class='erp'><b>[owner]</b> [vb] <b>[fucking]</b>.</span>")
	else if(action == FUCK_MOUTH)
		if(owner.gender == MALE)
			owner.visible_message("<span class='erp'><b>[owner]</b> fucks [fucking]'s mouth.</span>")


/datum/forbidden_controller/proc/cum()
	var/pleasure_message = pick("... I'M FEELING SO GOOD! ...",  "... It's just INCREDIBLE! ...", "... MORE AND MORE AND MORE! ...")
	if(fucking || fucked)

		if(owner.gender == MALE)
			if(fucking_action == FUCK_ANUS)
				owner.visible_message("<span class='cum'>[owner] cums into [fucking]'s ass!</span>")
			else if(fucking_action == FUCK_VAGINA)
				owner.visible_message("<span class='cum'>[owner] cums into [fucking]!</span>")
			else if(fucking_action == FUCK_MOUTH)
				owner.visible_message("<span class='cum'>[owner] cums into [fucking]'s mouth!</span>")
			else if(fucked_action == ORAL_MALE)
				owner.visible_message("<span class='cum'>[owner] cums into [fucked]'s mouth!</span>")
			else
				owner.visible_message("<span class='cum'>[owner] cums on the floor!</span>")

		else if(owner.gender == FEMALE)
			if(fucked_action == FUCK_ANUS)
				owner.visible_message("<span class='cum'>[owner] cums on the floor!</span>")
			else if(fucked_action == FUCK_VAGINA)
				owner.visible_message("<span class='cum'>[owner] cums into [fucked]'s dick!</span>")
			else if(fucked_action == ORAL_FEMALE)
				owner.visible_message("<span class='cum'>[owner] cums into [fucked]'s mouth!</span>")

	to_chat(owner, pleasure_message)
	pleasure = 0

/*
- virgin
Yama tears Robertinho's anus to pieces!
Yama mercilessly tears Robertinho's hymen

- examine
She is a virgin!
Penis size: 15 cm

- first time
Hymen blood

- start
Yama begins to suck Robertinhos's cock.

- dildo
Yama sucks a dildo!
Yama pleases his/her anus with a dildo!

- fuck
Yama fucks Robertinho's anus...
Yama fucks Robertinho's mouth...
Yama fucks Robertinho...
Yama penetrates Robertinho.

- cum
Yama cums into Robertinho's mouth!
Yama cums into Robertinho's ass!
Yama cums into Robertinho!
Yama cums on the floor!

- oral
Yama licks Robertinho.
Yama sucks Robertinho's cock.

- moans
Yama moans in pleasure.
Yama moans.

- orgasm
Yama twists in orgasm!

- etc
Semen
*/
#undef CUM_LEVEL