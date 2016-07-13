/datum/hud/
	var/deity_power_display
	var/deity_follower_display

/datum/hud/hog_god/New(mob/owner)
	..()
	healths = new /obj/screen/healths/deity()
	infodisplay += healths

	deity_power_display = new /obj/screen/deity_power_display()
	infodisplay += deity_power_display

	deity_follower_display = new /obj/screen/deity_follower_display()
	infodisplay += deity_follower_display


/mob/camera/god/create_mob_hud()
	if(client && !hud_used)
		hud_used = new /datum/hud/hog_god(src)

/obj/screen/deity_power_display
	name = "Faith"
	icon_state = "deity_power"
	screen_loc = ui_deitypower
//	layer = HUD_LAYER

/obj/screen/deity_follower_display
	name = "Followers"
	icon_state = "deity_followers"
	screen_loc = ui_deityfollowers
//	layer = HUD_LAYER