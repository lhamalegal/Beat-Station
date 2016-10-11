/obj/structure/dresser
	name = "dresser"
	desc = "A nicely-crafted wooden dresser. It's filled with lots of undies."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "dresser"
	density = 1
	anchored = 1

/obj/structure/dresser/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/clothing/underwear))
		user.drop_item()
		qdel(I)
		to_chat(user, "<span class='notice'>You put [I] into [src].</span>")
		return

/obj/structure/dresser/attack_hand(mob/user)
	if(!Adjacent(user))//no tele-grooming
		return
	if(ishuman(user))
		var/mob/living/carbon/human/H = user

		var/choice = input(user, "Underwear, Undershirt, or Socks?", "Changing") as null|anything in list("Underwear","Undershirt","Socks")

		if(!Adjacent(user))
			return
		switch(choice)
			if("Underwear")
				var/list/choices
				switch(H.gender)
					if(MALE)
						choices = underwear_m
					if(FEMALE)
						choices = underwear_f
					if(NEUTER)
						choices = underweari_list

				var/new_undies = input(user, "Select your underwear", "Changing")  as null|anything in choices
				if(new_undies)
					if(new_undies == "Nude")
						if(H.underpants)
							H.unEquip(H.underpants)
							//to_chat(H, "<span class='notice'>You put your underwear in the dresser.</span>")
					else
						var/obj/item/clothing/underwear/underpants/up = underwear_list[new_undies]
						if(H.underpants)
							H.unEquip(H.underpants)
						H.equip_or_collect(new up.type(), slot_underpants)
						//to_chat(H, "<span class='notice'>You take an underwear in the dresser and puts it.</span>")
					H.update_inv_underwear()

			if("Undershirt")
				var/list/choices
				switch(H.gender)
					if(MALE)
						choices = undershirt_m
					if(FEMALE)
						choices = undershirt_f
					if(NEUTER)
						choices = undershirti_list

				var/new_undershirt = input(user, "Select your undershirt", "Changing") as null|anything in choices
				if(new_undershirt)
					if(new_undershirt == "Nude")
						if(H.undershirt)
							H.unEquip(H.undershirt)
							//to_chat(H, "<span class='notice'>You put your undershirt in the dresser.</span>")
					else
						var/obj/item/clothing/underwear/undershirt/us = undershirt_list[new_undershirt]
						if(H.undershirt)
							H.unEquip(H.undershirt)
						H.equip_or_collect(new us.type(), slot_undershirt)
						//to_chat(H, "<span class='notice'>You take an undershirt in the dresser and puts it.</span>")
					H.update_inv_underwear()

			if("Socks")
				var/new_socks = input(user, "Select your socks", "Changing") as null|anything in socks_list
				if(new_socks)
					H.socks = new_socks


		add_fingerprint(H)
		H.update_body()