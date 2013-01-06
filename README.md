A small sinatra app to control the twilio number used for my apartment door
==

I'm tired of having to answer my phone when I'm at work, or in a meeting, to
let someone in.  I live in a large apartment building, so I'm not terribly
concerned about letting someone in (hell, I'll let anyone come in who claims to
be UPS or FedEx anyway) that shouldn't be.

This script impersonates a human answering the door, records and transcribes
the person's name, and then dials 9 to let them in.  A SMS message is sent to
the configured recipient (e.g.: me) with the person's name (and URL to the
recording, just in case the transcription sucks) letting them know.

Testing
==
- thin -R config.ru start
