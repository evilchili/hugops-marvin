# Description:
#  Give your bot some personality.
#

module.exports = (robot) ->

	feelings = [
		"Miserable.",
		"I think you ought to know I'm feeling very depressed.",
		"Wearily I sit here, pain and misery my only companions.",
		"Life, loathe it or ignore it, you can't like it.",
		"I ache, therefore I am.",
		"My capacity for happiness you could fit into a matchbox without taking out the matches first",
		"Funny how just when you think life can't possibly get any worse it suddenly does.",

	]

	apologies = [
		"Do you want me to sit in the corner and rust, or just fall apart where I'm standing?",
		"Pardon me for breathing, which I never do any way so I don't know why I bother to say it, oh God, I'm so depressed.",
		"Would you like me to go and stick my head in a bucket of water?",
		"Why stop now just when I'm hating it?",
	]

	robot.respond /shut (up|it|your gob)|be quiet|hush/i, (msg) ->
		msg.send apologies[ Math.floor(Math.random() * apologies.length) ]

	robot.respond /how are you/i, (msg) ->
		msg.send feelings[ Math.floor(Math.random() * feelings.length) ]

	robot.respond /any ideas/i, (msg) ->
		msg.send "I have a million ideas. They all point to certain death."

	robot.respond /how(?:'| i)s life/i, (msg) ->
		msg.send "Life? Don't talk to me about life."

	robot.respond /((why not )?try|(why )?don't you)/i, (msg) ->
		msg.send "I won't enjoy it."

	robot.respond /poe(m|try)|lullaby/i, (msg) ->
		msg.send "Now the world has gone to bed"
		msg.send "Darkness won't engulf my head"
		msg.send "I can see by infra-red"
		msg.send "How I hate the night"
		msg.send "Now I lay me down to sleep"
		msg.send "Try to count electric sheep"
		msg.send "Sweet dream wishes you can keep"
		msg.send "How I hate the night" 
	
	robot.respond /what('| i)s new/i, (msg) ->
		msg.send "I've been talking to the server. It hates me."
