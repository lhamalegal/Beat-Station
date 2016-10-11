// Forbidden Fruits
/mob/living/carbon/human/ui_interact(mob/living/carbon/human/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	if(!istype(user) || get_dist(user, src) > 1 || !erp_controller.check_species(src) || !erp_controller.check_species(user))
		return

	var/data[0]
	data["src_gender"] = (gender == MALE ? 1 : 0)
	data["usr_gender"] = (user.gender == MALE ? 1 : 0)

	data["yourself"] = (src == user)

	data["src_name"] = "[src]"
	data["dist"] = get_dist(user, src)

	data["src_nude"] = is_nude()
	data["usr_nude"] = user.is_nude()

	data["src_face"] = is_face_clean()
	data["usr_face"] = user.is_face_clean()

	data["icon"] = (gender == user.gender ? gender == MALE ? "mars-double" : "venus-double" : "venus-mars")

	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "erp.tmpl", "Forbidden Fruits", 450, 550, ignore_status = 1)
		ui.set_initial_data(data)
		ui.open()

/mob/living/carbon/human/MouseDrop_T(mob/living/carbon/human/target, mob/living/carbon/human/user)
	// User drag himself to [src]
	if(istype(target))
		if(user == target && get_dist(user, src) <= 1)
			ui_interact(user)
	return ..()

/mob/living/carbon/human/proc/process_erp_href(href_list, mob/living/carbon/human/user)
	if(get_dist(user, src) <= 1 && user.stat != DEAD && user.stat != UNCONSCIOUS && !user.weakened && !user.stunned && !user.paralysis && erp_controller.check_species(src) && erp_controller.check_species(user) && istype(user))
		if(user != src)
			if(user.is_face_clean() && is_nude())
				if(href_list["oral"])
					switch(href_list["oral"])
						if("penis")
							if(gender == MALE && !erp_controller.fucking)
								user.erp_controller.fucking(src, BLOWJOB)

						else if("vagina")
							if(gender == FEMALE)
								user.erp_controller.fucking(src, CUNNILINGUS)

			if(user.is_nude() && get_dist(user, src) == 0)
				if(href_list["fuck"])
					switch(href_list["fuck"])
						if("anus")
							if(is_nude())
								user.erp_controller.fucking(src, ANAL)
						if("vagina")
							if(gender == FEMALE && is_nude())
								user.erp_controller.fucking(src, VAGINAL)
						if("mouth")
							if(is_face_clean())
								user.erp_controller.fucking(src, MOUTHFUCK)
		else
			if(user.is_nude() && href_list["masturbate"])
				switch(href_list["masturbate"])
					if("normal")
						user.erp_controller.masturbate(null)
					if("anus")
						user.erp_controller.masturbate(ANAL)

// Helper procs
/mob/living/carbon/human/proc/is_nude()
	return (!istype(w_uniform, /obj/item/clothing/under) && !istype(underpants, /obj/item/clothing/underwear/underpants))

/mob/living/carbon/human/proc/is_face_clean()
	if(!wear_mask && !head)
		return 1
	if((head && (head.flags & HEADCOVERSMOUTH)) || ((wear_mask.flags & MASKCOVERSMOUTH) && !wear_mask.mask_adjusted))
		return 0
	return 1
// Helper procs end

// Anus insertion
/mob/living/carbon/human/attackby(obj/item/I, mob/user, params)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.a_intent == I_GRAB && H.zone_sel && H.zone_sel.selecting == "groin")
			if(src.ass_storage(H, I))
				return 1
	..()

/mob/living/carbon/human/proc/ass_storage(mob/living/carbon/human/H, obj/item/I = null)
	if(species.name in erp_blacklist_species)
		return 0

	if(!is_nude())
		to_chat(H, "<span class='notice'>You can't access [src == H ? "your" : "[src]'s"] anus.")
		return 0

	var/his = (src == H ? H.gender == FEMALE ? "her" : "his" : "[src]'s")
	var/your = (src == H ? "your" : "[src]'s")

	if(I)
		if(istype(I, /obj/item/weapon/disk/nuclear))
			to_chat(H, "<span class='warning'>Central command would kill you if you put it in there.</span>")
			return 1

		H.visible_message("<span class='notice'>[H] begins to put \the [I] inside [his] anus!", "<span class='notice'>You begin to put \the [I] inside [your] anus!")
		if(do_after(H, 30, target = src))
			if(ass_storage.can_be_inserted(I, 1))
				ass_storage.handle_item_insertion(I, 1)
				to_chat(H, "<span class='notice'>You put \the [I] inside [your] anus.")
			else
				to_chat(H, "<span class='warning'>\The [I] doesn't fit in [your] anus.")
	else
		H.visible_message("<span class='notice'>[H] begins to search inside [his] anus!", "<span class='notice'>You begin to search inside [your] anus!")
		if(do_after(H, 30, target = src))
			var/i = 0
			for(var/obj/item in ass_storage)
				i += 1
				ass_storage.remove_from_storage(item, src.loc)
			if(i == 0)
				to_chat(H, "<span class='warning'>[capitalize(your)] anus is empty.")
			else
				to_chat(H, "<span class='notice'>You remove everything from [your] anus.")
	return 1
// Anus insertion end