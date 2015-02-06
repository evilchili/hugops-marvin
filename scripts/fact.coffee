# Description:
#    Store key/value pairs in the brain
#
# Commands:
#  hubot <key> is <value> - remember <key> as <value>
#  hubot forget <key> - forget the value of the fact <key>
#  hubot <key>? - return the fact called "key"
#  hubot facts <filter> - list known facts (filter optional)
#
# Examples:
#  hubot today is the day
#  hubot forget today

module.exports = (robot) ->

    # create/update a fact
    robot.respond /(?:fact\s+)?(.+?)\s+is\s+(.+)$/i, (msg) ->
        k = msg.match[1].trim()
        v = msg.match[2].trim()

        facts = robot.brain.get( "facts" ) || {}
        if k && ! /^\s*(inform\s.+|who|what|when|where|how|why)\s*$/i.test(k)
          facts[k] = v
          robot.brain.set( "facts", facts )
          msg.send "Alright, #{k} is #{v}."

    # delete a fact
    robot.respond /(?:fact\s+)?forget\s+(.+)/i, (msg) ->
        k = msg.match[1].trim()

        facts = robot.brain.get( "facts" ) || {}
        if facts[k]
            delete facts[k]
            robot.brain.set("facts", facts)
            msg.send("#{k} forgotten.")
        else
            msg.send("#{k} is not a known fact.")

    # get a fact
    robot.respond /(?:fact\s+)?\s*(.+)\?/i, (msg) ->
        k = msg.match[1].trim()

        facts = robot.brain.get("facts") || {}
        if /^me$/i.test(k)
            k = msg.envelope.user

        if facts[k]
            msg.send("Fact! #{k} is #{facts[k]}")

    # list known facts
    robot.respond /facts(?:\s+(.+))?/i, (msg) ->
        facts = robot.brain.get("facts") || {}

        # get the list of names from the facts array
        fact_names = []
        for key, value of facts
           fact_names.push(key)

        # filter them, if a filter was given
        if msg.match[1]
            fact_names = fact_names.filter (k) ->
                k.match new RegExp( msg.match[1], 'i' )

        # send whatever is left
        if fact_names.length
            msg.send( "fact: #{fact_names[n]}" ) for n of fact_names
        else if msg.match[1]
            msg.send("No matching facts.")
        else
            msg.send("My brain is empty.")

