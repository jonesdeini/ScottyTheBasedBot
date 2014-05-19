# Description:
# THIS IS WHAT HAPPENS WHEN YOU PARSE HTML WITH A REGEX!
#
# HERE'S WHAT HAPPENS, LARRY!
#
# HERE'S WHAT HAPPENS! WHEN YOU PARSE HTML WITH A REGEX!
#
# Dependencies:
#   None
#
# Commands:
#   dude
#
# Author:
#   jonesdeini

module.exports = (robot) ->
  robot.hear /dude/i, (msg) ->
    msg.http("http://thugbot.net/lebowski/")
      .get() (err, response, body) ->
        if (response.statusCode == 200)
          dudeism = body.match(/<p class="small" align="justify">([\s\S\w]+)(\n| )<\/p>/i)
          unless dudeism == null
            dudeism = dudeism[1].replace /<\/?b>/g, ""
            dudeism = dudeism.replace /<br>/g, "\n"
            msg.send dudeism
