/datum/game_mode/extended
	name = "extended"
	config_tag = "extended"
	required_players = 0

/datum/game_mode/extended/announce()
	var/text = "<B>The current game mode is - Extended Role-Playing!</B><br>"
	text += "<B>Just have fun and role-play!</B>"
	..(text)

/datum/game_mode/extended/pre_setup()
	return 1

/datum/game_mode/extended/post_setup()
	..()