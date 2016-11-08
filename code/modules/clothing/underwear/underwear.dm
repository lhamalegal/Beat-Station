/obj/item/clothing/underwear
	icon = 'icons/obj/underwear.dmi'

	lefthand_file = 'icons/mob/inhands/clothing_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing_righthand.dmi'
	item_state = "b_suit"

	var/standing_icon
	var/use_gender

/obj/item/clothing/underwear/underpants
	var/adjustable = 0
	var/adjusted = 0

/obj/item/clothing/underwear/underpants/verb/adjust()
	set name = "Adjust Underwear"
	set category = "Object"
	set src in view(1)

	var/mob/living/carbon/C = usr

	if(!istype(C) || C.incapacitated() || C.lying)
		to_chat(usr, "<span class='warning'>You can't do that.</span>")
		return

	if(adjustable)
		adjusted = !adjusted
		if(adjusted)
			to_chat(C, "<span class='notice'>You pull [src] aside.</span>")
		else
			to_chat(C, "<span class='notice'>You put [src] back in place.</span>")
	else
		to_chat(C, "<span class='warning'>You can't ajust this underwear.</span>")