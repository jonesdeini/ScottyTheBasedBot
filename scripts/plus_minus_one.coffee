# Description:
#   Allows users to give +1/-1 to another user
#
# Dependencies:
#   None
#
# Commands:
#   <receiver>: (+1|-1) <reason> - give +1|-1 to <receiver> (full name) because he did <reason>
#   ranking - show top players
#
# Author:
#   jonesdeini

module.exports = (robot) ->
  robot.brain.data.userpoints ||= {}

  robot.hear /(\S+):? *(\+1|-1) (.*)$/i, (msg) ->
    thanker  = msg.message.user.name
    receiver = msg.match[1].trim()
    points   = msg.match[2]
    reason   = msg.match[3]

    points = parseFloat(points)

    receiverData = robot.brain.data.userpoints[receiver] ||= {total: 0, latestReason: null, name: receiver}
    receiverData['total'] += points
    receiverData['latestReason'] = reason

    robot.brain.data.userpoints[receiver] = receiverData
    msg.send "#{thanker} gave #{points} to #{receiver} for #{reason}. Now has #{receiverData['total']} points."

  robot.respond /ranking/i, (msg) ->
    userpoints = robot.brain.data.userpoints
    names = (k for k of userpoints)

    # sort by descending
    ranking = names.sort (a, b) ->
      userpoints[b]['total'] - userpoints[a]['total']

    topFive = ranking.slice(0,5)

    msg.send "# Rankings"
    for name,i in topFive
      position = i + 1
      person = userpoints[name]
      msg.send "  #{position}. #{person['name']} (#{person['total']} pts)"
