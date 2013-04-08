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

module.exports = (robot) ->
  robot.brain.data.achievements ||= {}

  robot.hear /(.*): *(\+1|-1) (.*)$/i, (msg) ->
    receiver = msg.match[1].trim()
    thanking = msg.message.user.name
    points   = msg.match[2]
    reason   = msg.match[3]

    if receiver == thanking
      msg.send "hey, don't cheat!"

    unless reason?
      msg.send "#{thanking}: you must give a reason"

    if receiver != thanking and reason?
      robot.brain.data.achievements[receiver] ||= []
      event = {reason: reason, given_by: thanking, points: points}
      robot.brain.data.achievements[receiver].push event
      msg.send "#{event.given_by} gives #{event.points} to #{receiver} for #{event.reason}"

  # robot.respond /who thanks me??/i, (msg) ->
  #   user = msg.message.user.name
  #   response = "#{user}, #{robot.brain.data.achievements[user].length} time(s) someone thanked you:\n"
  #   for achievement in robot.brain.data.achievements[user]
  #     response += "#{achievement.given_by} for #{achievement.reason}\n"
  #   msg.send response

  robot.respond /(|show )ranking/i, (msg) ->
    ranking = []

    for person, achievements of robot.brain.data.achievements
      ranking.push {name: person, points: achievements.points.reduce (x,y) -> x + y}

    sortedRanking = ranking.sort (a, b) ->
      b.points - a.points

    message = "Ranking\n"

    position = 0
    for user in sortedRanking
      position += 1
      message += "#{position}. #{user.name} - #{user.points}\n"

    msg.send message
