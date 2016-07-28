// Note: Hard hat and engineering space helmet can be found in helments.dm, the cake hat in hats.dm.

/obj/item/device/testlight
	name = "testlight"
	desc = "A hand-held test light."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "flashlight"
	item_state = "flashlight"
	var/on = 0
	w_class = 2
	flags = CONDUCT
	slot_flags = SLOT_BELT
	materials = list(MAT_METAL=50, MAT_GLASS=20)
	action_button_name = "Flashlight"
	var/col_r = 0.9
	var/col_g = 0.8
	var/col_b = 0.7

	New()
		..()
		light = new /datum/light/point
		light.set_brightness(1)
		light.set_color(col_r, col_g, col_b)
		light.attach(src)

	attack_self(mob/user)
		on = !on

		if (on)
			icon_state = "[initial(icon_state)]-on"
			light.enable()
		else
			icon_state = initial(icon_state)
			light.disable()

	pickup(mob/living/user as mob)
		..()
		light.attach(user)

	dropped(mob/user as mob)
		..()
		spawn(0)
			if (src.loc != user)
				light.attach(src)