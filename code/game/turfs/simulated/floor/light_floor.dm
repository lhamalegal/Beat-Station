#define LIGHTFLOOR_ON 1
#define LIGHTFLOOR_WHITE 2
#define LIGHTFLOOR_RED 3
#define LIGHTFLOOR_GREEN 4
#define LIGHTFLOOR_YELLOW 5
#define LIGHTFLOOR_BLUE 6
#define LIGHTFLOOR_PURPLE 7

/turf/simulated/floor/light
	name = "Light floor"
	//light_range = 5
	icon_state = "light_on"
	floor_tile = /obj/item/stack/tile/light
	broken_states = list("light_broken")
	var/on = 1
	var/state = LIGHTFLOOR_ON

/turf/simulated/floor/light/New()
	..()
	light = new /datum/light/point
	light.set_brightness(1.5)
	light.attach(src)
	update_icon()

/turf/simulated/floor/light/update_icon()
	..()
	if(on)
		switch(state)
			if(LIGHTFLOOR_ON)
				icon_state = "light_on"
				light.set_color()
				light.enable(0, 153, 255)
			if(LIGHTFLOOR_WHITE)
				icon_state = "light_on-w"
				light.set_color()
				light.enable(255,255,255)
			if(LIGHTFLOOR_RED)
				icon_state = "light_on-r"
				light.set_color(180, 0, 0)
				light.enable()
			if(LIGHTFLOOR_GREEN)
				icon_state = "light_on-g"
				light.set_color(0,255,0)
				light.enable()
			if(LIGHTFLOOR_YELLOW)
				icon_state = "light_on-y"
				light.set_color(255,255,0)
				light.enable()
			if(LIGHTFLOOR_BLUE)
				icon_state = "light_on-b"
				light.set_color(49, 90, 180)
				light.enable()
			if(LIGHTFLOOR_PURPLE)
				icon_state = "light_on-p"
				light.set_color(205, 0, 205)
				light.enable()
			else
				icon_state = "light_off"
				light.disable()
	else
		light.disable()
		icon_state = "light_off"

/turf/simulated/floor/light/ChangeTurf(turf/T)
	light.disable()
	..()

/turf/simulated/floor/light/attack_hand(mob/user)
	on = !on
	update_icon()

/turf/simulated/floor/light/attackby(obj/item/C, mob/user, params)
	if(..())
		return
	if(istype(C,/obj/item/weapon/light/bulb)) //only for light tiles
		if(istype(builtin_tile, /obj/item/stack/tile/light))
			if(!state)
				qdel(C)
				state = LIGHTFLOOR_ON
				update_icon()
				to_chat(user, "<span class='notice'>You replace the light bulb.</span>")
			else
				to_chat(user, "<span class='notice'>The light bulb seems fine, no need to replace it.</span>")
	if(istype(C,/obj/item/device/multitool))
		if(state != 0)
			if(state < LIGHTFLOOR_PURPLE)
				state++
			else
				state = LIGHTFLOOR_ON
			to_chat(user, "<span class='notice'>You change \the [src]'s light bulb color.</span>")
			update_icon()
		else
			to_chat(user, "<span class='warning'>\The [src]'s light bulb appears to have burned out.</span>")
