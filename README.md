Door, a small Sinatra/Twilio app to control my building's door
===

I'm tired of having to answer my phone when I'm at work (or asleep, yikes!) to
let someone in to my apartment building. Like any good developer, I decided to fix this very slight annoyance with highly complex technology.

This script impersonates a human answering the door, records the person's name,
and then dials 9 to let them in.  A SMS message is sent to the configured
recipient (e.g.: me) letting them know that the door was opened, and provides a
link to the recording of who it is. (I tried Twilio's transcription feature,
but it appears to not work for recordings that are 1-3 seconds long)

**NOTE:** I live in a large apartment building, so I'm not terribly concerned about
letting someone who shouldn't be in.  Hell, I'll let anyone come in who claims
to be UPS or FedEx anyway.

If you care about security, you probably shouldn't be using this.

Testing
--
- thin -R config.ru start

Production
--
This sinatra app can be very comfortably run via heroku's free web worker plan.

Make sure to set the following environment variables, either via heroku
  config:add or other means:
  
  - `BITLY_USERNAME`: your bit.ly username
  - `BITLY_API_TOKEN`: the bit.ly 2.0 API key
  - `TWILIO_SMS_FROM`: your Twilio phone number
  - `TWILIO_SMS_TO`: the phone number to SMS when the door is open
  
Then, just point your Twilio phone number at your running sinatra instance, and you're good to go.
