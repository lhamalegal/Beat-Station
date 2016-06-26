

var/global/list/boo_phrases=list(
	"You feel a chill run down your spine.",
	"You think you see a figure in your peripheral vision.",
	"What was that?",
	"The hairs stand up on the back of your neck.",
	"You are filled with a great sadness.",
	"Something doesn't feel right...",
	"You feel a presence in the room.",
	"It feels like someone's standing behind you.",
)

/obj/effect/proc_holder/spell/aoe_turf/boo
	name = "Boo!"
	desc = "Fuck with the living."

	ghost = 1

	school = "transmutation"
	charge_max = 600
	clothes_req = 0
	invocation = ""
	invocation_type = "none"
	range = 0 // Or maybe 3?

/obj/effect/proc_holder/spell/aoe_turf/boo/cast(list/targets)
	var/area/A = get_area(src)
	for(var/turf/T in A.contents)
		for(var/atom/AT in T.contents)
			// Bug humans
			if(ishuman(AT))
				var/mob/living/carbon/human/H = AT
				if(H && H.client)
					to_chat(H, "<i>[pick(boo_phrases)]</i>")

			// Flicker unblessed lights in range
			if(istype(AT,/obj/machinery/light))
				var/obj/machinery/light/L = AT
				if(L)
					L.flicker()

			// OH GOD BLUE APC (single animation cycle)
			if(istype(AT, /obj/machinery/power/apc))
				AT:spookify()

			if(istype(AT, /obj/machinery/status_display))
				AT:spookymode=1

			if(istype(AT, /obj/machinery/ai_status_display))
				AT:spookymode=1

			// Turn flashlights off
			if(istype(AT, /obj/item/device/flashlight))
				var/obj/item/device/flashlight/F = AT
				F.on = 0
				F.icon_state = initial(F.icon_state)
				F.set_light(0)
