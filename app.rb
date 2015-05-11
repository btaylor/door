require 'rubygems'
require 'sinatra'
require 'bitly'
 
post '/' do
  response =<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<Response>
  <Pause length="3" />
  <Play>http://jetcityorange.com/dtmf/DTMF-2.mp3</Play>
  <Pause length="1" />
  <Play>http://jetcityorange.com/dtmf/DTMF-9.mp3</Play>
</Response>
EOF
end

post '/recordSuccess' do
  recordingUrl = params[:RecordingUrl]
  
  bitly = Bitly.new(ENV['BITLY_USERNAME'], ENV['BITLY_API_TOKEN'])
  shortenedRecordingUrl = bitly.shorten(recordingUrl).jmp_url

  response =<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<Response>
  <Play>https://dl.dropbox.com/s/28uq7mlvuf4rw9f/come-on-in.wav?dl=1</Play>
  <Play>http://jetcityorange.com/dtmf/DTMF-9.mp3</Play>
  <Sms from="#{ENV['TWILIO_SMS_FROM']}" to="#{ENV['TWILIO_SMS_TO']}">Hey, I just let someone in the front door. #{shortenedRecordingUrl}</Sms>
  <Hangup />
</Response>
EOF
end

post '/recordTimeout' do
  response =<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<Response>
  <Play>https://dl.dropbox.com/s/muquloypzix6i7k/sorry-who.wav?dl=1</Play>
  <Record timeout="3" maxLength="5" playBeep="false"
          action="/recordSuccess" />
  <Hangup />
</Response>
EOF
end
