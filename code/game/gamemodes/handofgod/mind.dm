/datum/mind/proc/remove_hog_follower_prophet()
	ticker.mode.red_deity_followers -= src
	ticker.mode.red_deity_prophets -= src
	ticker.mode.blue_deity_prophets -= src
	ticker.mode.blue_deity_followers -= src
	ticker.mode.update_hog_icons_removed(src, "red")
	ticker.mode.update_hog_icons_removed(src, "blue")

