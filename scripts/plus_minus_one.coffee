# Description:
#   Allows users to give +1/-1 to another user
#
# Dependencies:
#   None
#
# Commands:
#   <receiver>: (+1|-1) <reason> - give +1|-1 to <receiver> (full name) because he did <reason>
#   (show ranking|ranking) - show top players
#
# Author:
#   jonesdeini
#   jshsu

module.exports = (robot) ->
  robot.brain.data.achievements ||= {}

  robot.hear /(.*) *(\+1|-1) (.*)$/i, (msg) ->
    thanker  = msg.message.user.name
    receiver = msg.match[1].trim()
    points   = msg.match[2]
    reason   = msg.match[3]

    points = parseFloat(points)

    receiverData = robot.brain.data.achievements[receiver] ||= {total: 0, latestReason: null, name: receiver}
    receiverData['total'] += points
    receiverData['latestReason'] = reason

    robot.brain.data.achievements[receiver] = receiverData
    msg.send "#{thanker} gave #{points} to #{receiver} for #{reason}. Now has #{receiverData['total']} points."

  robot.respond /(|show )ranking/i, (msg) ->
    achievements = robot.brain.data.achievements
    names = (k for k of achievements)

    # sort by descending
    ranking = names.sort (a, b) ->
      achievements[b]['total'] - achievements[a]['total']

    topFive = ranking.slice(0,5)

    msg.send "# Rankings"
    for name,i in topFive
      position = i + 1
      person = achievements[name]
      msg.send "  #{position}. #{person['name']} (#{person['total']} pts)"
