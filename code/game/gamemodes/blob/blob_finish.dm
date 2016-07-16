/datum/game_mode/blob/check_finished()
	if(infected_crew.len > burst)//Some blobs have yet to burst
		return 0
	if(blobwincount <= blobs.len)//Blob took over
		return 1
	if(!blob_cores.len) // blob is dead
		return 1
	return ..()


/datum/game_mode/blob/declare_completion()
	var/text = ""
	if(blobwincount <= blobs.len)
		feedback_set_details("round_end_result","win - blob took over")
		text += "<FONT size = 3><B>The blob has taken over the station!</B></FONT>"
		text += "<B>The entire station was eaten by the Blob</B>"
		log_game("Blob mode completed with a blob victory.")

	else if(station_was_nuked)
		feedback_set_details("round_end_result","halfwin - nuke")
		text += "<FONT size = 3><B>Partial Win: The station has been destroyed!</B></FONT>"
		text += "<B>Directive 7-12 has been successfully carried out preventing the Blob from spreading.</B>"
		log_game("Blob mode completed with a tie (station destroyed).")

	else if(!blob_cores.len)
		feedback_set_details("round_end_result","loss - blob eliminated")
		text += "<FONT size = 3><B>The staff has won!</B></FONT>"
		text += "<B>The alien organism has been eradicated from the station</B>"
		log_game("Blob mode completed with a crew victory.")
		to_chat(world, "<span class='notice'>Rebooting in 30s</span>")
	text = replacetext(text, "<B>", "**")
	text = replacetext(text, "</B>", "**")
	text = replacetext(text, "<FONT size = 3>", "")
	text = replacetext(text, "<font color='red'>", "*")
	text = replacetext(text, "<font color='green'>", "*")
	text = replacetext(text, "</font>", "*")
	text = replacetext(text, "</FONT>", "")
	text = replacetext(text, "<br>", "\n")
	send_to_info_discord(text)
	..()
	return 1

/datum/game_mode/proc/auto_declare_completion_blob()
	if(istype(ticker.mode,/datum/game_mode/blob) )
		var/datum/game_mode/blob/blob_mode = src
		if(blob_mode.infected_crew.len)
			var/text = "<FONT size = 2><B>The blob[(blob_mode.infected_crew.len > 1 ? "s were" : " was")]:</B></FONT>"

			for(var/datum/mind/blob in blob_mode.infected_crew)
				text += "<br><B>[blob.key]</B> was <B>[blob.name]</B>"
			to_chat(world, text)
			text = replacetext(text, "<B>", "**")
			text = replacetext(text, "</B>", "**")
			text = replacetext(text, "<FONT size = 2>", "***")
			text = replacetext(text, "<font color='red'>", "*")
			text = replacetext(text, "<font color='green'>", "*")
			text = replacetext(text, "</font>", "*")
			text = replacetext(text, "</FONT>", "***")
			text = replacetext(text, "<br>", "\n")
			send_to_info_discord(text)
		return 1
