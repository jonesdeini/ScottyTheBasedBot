# Description:
#   Returns rare based swag from the basedgod
#
# Dependencies:
#   None
#
# Commands:
#   hubot swag
#
# Author:
#   jonesdeini

swag = [
  "Your beautiful parents made you, bro. You didn’t ask for that. You didn’t ask to live where you live or anything. So when you see people, forgive them and accept, you feel me? You gotta open your mind and say, man, nobody asked to be born.",
  "Life is hard, kinda",
  "You know I’m the first rapper to adopt a tabby cat. You know I adopted straight from the ASPCA, you feel me? Just breaking the boundaries, man, showing everybody it’s okay to be yourself.",
  "But at the end of the day, I look at animals and insects.",
  "Embrace yourself. Embrace your health. Ayyy! Just continue to love yourself and accept.",
  "I take the based god seriously.",
  "I would’a come up here in a suit so y’all could take me seriously. I take y’all so seriously. I take the based god seriously.",
  "You know we ain’t gonna pull that dance out man! That’s millions, billions! I’m feeling like Michael Jackson out there, whipping the wrist like br-br-br-da!",
  "Let's stop fracking! 'Ey, bruh. Stop messin' with the Earth, bruh.",
  "Do we have any proof what we are?",
  "I remember when I was younger, I didn’t know how to walk. I was so young, I was wondering how I was walking. Am I walking weird? Something’s in my butt? You know what I mean?",
  "So hard on myself. And I say through time and love it’s just easing up on yourself, easing up on life.",
  "Just take two seconds instead of generalizing, because, I promise you, I looked up what black means online, and black means something like coal, you feel me?"
]

module.exports = (robot) ->
  robot.hear /swag/i, (msg) ->
    msg.send msg.random swag
