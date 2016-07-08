/proc/key_name(var/whom, var/include_link = null, var/include_name = 1, var/type = null)
	var/mob/M
	var/client/C
	var/key

	if(!whom)	return "*null*"
	if(istype(whom, /client))
		C = whom
		M = C.mob
		key = C.key
	else if(ismob(whom))
		M = whom
		C = M.client
		key = M.key
	else if(istype(whom, /datum))
		var/datum/D = whom
		return "*invalid:[D.type]*"
	else
		return "*invalid*"

	. = ""

	if(key)
		if(C && C.holder && C.holder.fakekey && !include_name)
			if(include_link)
				. += "<a href='?priv_msg=[C.findStealthKey()];type=[type]'>"
			. += "Administrator"
		else
			if(include_link)
				. += "<a href='?priv_msg=\ref[C];type=[type]'>"
			. += key

		if(include_link)
			if(C)	. += "</a>"
			else	. += " (DC)"
	else
		. += "*no key*"

	if(include_name && M)
		if(M.real_name)
			. += "/([M.real_name])"
		else if(M.name)
			. += "/([M.name])"

	return .

/proc/key_name_admin(var/whom, var/include_name = 1)
	var/message = "[key_name(whom, 1, include_name)](<A HREF='?_src_=holder;adminmoreinfo=\ref[whom]'>?</A>)[isAntag(whom) ? "(A)" : ""] ([admin_jump_link(whom, "holder")])"
	return message

/proc/log_and_message_admins(var/message as text)
	log_admin("[key_name(usr)] " + message)
	message_admins("[key_name_admin(usr)] " + message)

/proc/admin_log_and_message_admins(var/message as text)
	log_admin("[key_name(usr)] " + message)
	message_admins("[key_name_admin(usr)] " + message, 1)

/proc/replace_special_characters(var/text as text)
	text = replacetext(text, "Á", "A")
	text = replacetext(text, "á", "a")
	text = replacetext(text, "R", "A")
	text = replacetext(text, "r", "a")
	text = replacetext(text, "a", "a")
	text = replacetext(text, "A", "A")
	text = replacetext(text, "â", "a")
	text = replacetext(text, "Â", "A")

	text = replacetext(text, "é", "e")
	text = replacetext(text, "É", "E")
	text = replacetext(text, "c", "e")
	text = replacetext(text, "C", "E")
	text = replacetext(text, "e", "e")
	text = replacetext(text, "E", "E")

	text = replacetext(text, "í", "i")
	text = replacetext(text, "Í", "I")
	text = replacetext(text, "e", "i")
	text = replacetext(text, "E", "I")
	text = replacetext(text, "î", "i")
	text = replacetext(text, "Î", "I")

	text = replacetext(text, "ó", "o")
	text = replacetext(text, "Ó", "O")
	text = replacetext(text, "n", "o")
	text = replacetext(text, "N", "O")
	text = replacetext(text, "o", "o")
	text = replacetext(text, "O", "O")
	text = replacetext(text, "ô", "o")
	text = replacetext(text, "Ô", "O")

	text = replacetext(text, "ú", "u")
	text = replacetext(text, "Ú", "U")
	text = replacetext(text, "u", "u")
	text = replacetext(text, "U", "U")
	text = replacetext(text, "u", "u")
	text = replacetext(text, "U", "U")

	text = replacetext(text, "n", "n")
	text = replacetext(text, "N", "N")
	text = replacetext(text, "Ç", "C")
	text = replacetext(text, "ç", "c")
	text = replacetext(text, "Ý", "Y")
	text = replacetext(text, "ý", "y")
	return text