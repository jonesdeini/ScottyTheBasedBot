# Description:
#   Allows users to give +1/-1 to another user
#
# Dependencies:
#   None
#
# Commands:
#   <receiver>: (+1|-1) <reason> - give +1|-1 to <receiver> (full name) because he did <reason>
#   ranking - show top players
#   status - world sum
#
# Author:
#   jonesdeini

module.exports = (robot) ->
  robot.brain.data.userpoints ||= {}

  robot.hear /(\S+):? *(\+1|-1) (.*)$/i, (msg) ->
    thanker  = msg.message.user.name.toLowerCase()
    receiver = msg.match[1].trim().toLowerCase()
    points   = msg.match[2]
    reason   = msg.match[3]

    points = parseFloat(points)

    msg.send "#{thanker}: No cheating." if thanker == receiver
    msg.send "#{thanker}: Must give a reason." unless reason? && reason.length

    receiverData = robot.brain.data.userpoints[receiver] ||= {total: 0, latestReason: null, name: receiver}
    receiverData['total'] += points
    receiverData['latestReason'] = reason

    robot.brain.data.userpoints[receiver] = receiverData
    msg.send "#{thanker} gave #{points} to #{receiver} for #{reason}. Now has #{receiverData['total']} points."

  robot.respond /status/i, (msg) ->
    achievements = robot.brain.data.userpoints
    overall = 0
    for name,data of achievements
      if data && userTotal = data['total']
        overall += parseFloat(userTotal)
    message = switch
      when overall > 0 then "a happy"
      when overall == 0 then "just"
      when overall < 0 then "sadly"
      else "uhh"
    msg.send("#{message} #{overall}")

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
