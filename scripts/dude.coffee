# Description:
#   no Description needed
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
