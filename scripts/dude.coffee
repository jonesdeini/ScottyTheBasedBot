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
          dudeism = body.match(/<p class="small" align="justify">([\s\S\w]+) <\/p>/i)
          msg.send dudeism[1] unless dudeism == null
