# Description:
#   Drink better coffee.
#
# Commands:
#   hubot make me some coffee - Serve up a cup of joe
#   hubot get coffee <name> from <roaster> @ <url> - add a coffee to the bar
#   hubot sell me that coffee - provide source URL for the last coffee served
#

sizes = ['6oz','8oz','12oz','16oz','24oz']
brews = [ "chemex", "eva solo", "french press", "v60", "aeropress", "siphon", "vaccum pot", "espresso", "cappuccino", "latte", "cortado", "flat white" ]

last_served = null

module.exports = (robot) ->
    robot.brain.data.coffees ?= []

    robot.respond /(?:make me some )?coffee|coffee me/i, (msg) ->
      if ! robot.brain.data.coffees.length
        msg.reply "We're out of coffee. Which I suppose means you're going to be even more insufferable than usual."
      else
        coffee = robot.brain.data.coffees[ Math.floor( Math.random() * robot.brain.data.coffees.length ) ]
        size = sizes[ Math.floor( Math.random() * sizes.length ) ]
        brew = brews[ Math.floor( Math.random() * brews.length ) ]
        msg.reply "☕  Here is a #{size} #{brew} of #{coffee.name} from #{coffee.source}"

        last_served = coffee

    robot.respond /get coffee\s+(.+?)\s+from\s+(.+)\s+@\s+(.+)/i, (msg) ->
      coffee = { name: msg.match[1], source: msg.match[2], url: msg.match[3] }

      robot.brain.data.coffees.push coffee
      msg.reply "☕  now serving #{coffee.name} from #{coffee.source} #{coffee.url}"

    robot.respond /sell me that coffee/i, (msg) ->
      if ! last_served
        msg.reply "I haven't made any coffee yet."
      else
        msg.reply "You can get #{last_served.name} from #{last_served.url}"
