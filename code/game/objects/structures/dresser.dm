/obj/structure/dresser
	name = "dresser"
	desc = "A nicely-crafted wooden dresser. It's filled with lots of undies."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "dresser"
	density = 1
	anchored = 1

/obj/structure/dresser/attack_hand(mob/user as mob)
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
						H.underpants = null
					else
						H.underpants = underwear_list[new_undies]
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
						H.undershirt = null
					else
						H.undershirt = undershirt_list[new_undershirt]
					H.update_inv_underwear()

			if("Socks")
				var/new_socks = input(user, "Select your socks", "Changing") as null|anything in socks_list
				if(new_socks)
					H.socks= new_socks


		add_fingerprint(H)
		H.update_body()