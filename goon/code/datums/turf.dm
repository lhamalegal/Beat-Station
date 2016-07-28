/obj/overlay/tile_effect
	name = ""
	anchored = 1
	density = 0
	mouse_opacity = 0
	icon = 'icons/effects/ULIcons.dmi'
	icon_state = "etc"
	alpha = 255
	layer = TILE_EFFECT_OVERLAY_LAYER
	animate_movement = NO_STEPS // fix for things gliding around all weird

	// splitting these up for varediting
	multiply
		blend_mode = BLEND_MULTIPLY

	additive
		blend_mode = BLEND_ADD

	pooled(var/poolname)
		overlays.len = 0
		..()

	Move()
		return 0

	unpooled()
		..()
		var/area/ourArea = get_area(src)
		if (istype(ourArea) && !ourArea.RL_Lighting)
			alpha = 0
		else
			alpha = initial(alpha)

	New()
		..()
		var/area/ourArea = get_area(src)
		if (istype(ourArea) && !ourArea.RL_Lighting)
			alpha = 0
		else
			alpha = initial(alpha)