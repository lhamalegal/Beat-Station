from .Command import BeatCommand

class commandWho(BeatCommand):
	"""Players on the server."""

	@classmethod
	async def doCommand(cls, bot, message, params):
		server_reply = bot.ping_server(b"who")

		if server_reply == None:
			reply = "{0}, sorry! I was unable to ping the server!".format(message.author.mention)
		else:
			reply = "Current player list:\n\n```\n"
			if len(server_reply) == 1:
				reply += server_reply
			else:
				for value in server_reply:
					reply += value
					reply += "\n"
			reply += "```"

		await bot.send_message(message.channel, reply)
		return

	@classmethod
	def getName(cls):
		return "Who"

	@classmethod
	def getDescription(cls):
		return "Get players on the server."

	@classmethod
	def getParams(cls):
		return ""

	@classmethod
	def getAuths(cls):
		return ['admins', 'host', 'headmin']

	@classmethod
	def verifyParams(cls, params):
		return True