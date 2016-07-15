#define CHAN_ADMIN "staff_chat"
#define CHAN_BAN "bans"
#define CHAN_GENERAL "general"
#define CHAN_INFO "anuncios"

/proc/send_to_discord(var/channel, var/message)
	if (!config.use_discord_bot)
		return
	if (!channel)
		log_game("send_to_discord() called without channel arg.")
		return
	if (!message)
		log_game("send_to_discord() called without message arg.")
		return

	var/arguments = " --key=\"[config.comms_password]\""
	arguments += " --channel=\"[channel]\""
	if (config.discord_bot_host)
		arguments += " --host=\"[config.discord_bot_host]\""
	if (config.discord_bot_port)
		arguments += " --port=[config.discord_bot_port]"

	message = replacetext(message, "\"", "\\\"")

	ext_python("discordbot_message.py", "[arguments] [message]")
	return

/proc/send_to_info_discord(var/message)
	send_to_discord(CHAN_INFO, message)

/proc/send_to_main_discord(var/message)
	send_to_discord(CHAN_GENERAL, message)

/proc/send_to_admin_discord(var/message)
	send_to_discord(CHAN_ADMIN, message)

/proc/send_to_ban_discord(var/message)
	send_to_discord(CHAN_BAN, message)

#undef CHAN_INFO
#undef CHAN_GENERAL
#undef CHAN_BAN
#undef CHAN_ADMIN