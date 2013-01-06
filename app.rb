require 'rubygems'
require 'sinatra'
require 'twilio-ruby'
 
post '/' do
  response =<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<Response>
  <Play>https://dl.dropbox.com/s/0wf9wok59b5koe2/hello.wav?dl=1</Play>
  <Record timeout="2" maxLength="5" playBeep="false"
          action="/recordSuccess" transcribeCallback="/transcribeSuccess" />
  <Redirect>/recordTimeout</Redirect>
</Response>
EOF
end

post '/recordSuccess' do
response =<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<Response>
  <Play>https://dl.dropbox.com/s/28uq7mlvuf4rw9f/come-on-in.wav?dl=1</Play>
  <Play>http://jetcityorange.com/dtmf/DTMF-9.mp3</Play>
  <!-- <Sms from="+14156305155" to="+19098154939">Hey, I just let someone in the front door.</Sms> -->
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

post '/transcribeSuccess' do
  recordingUrl = params[:RecordingUrl]
  transcriptionText = params[:TranscriptionText]

  accountSid = ENV['TWILIO_ACCOUNT_SID']
  authToken = ENV['TWILIO_AUTH_TOKEN']

  client = Twilio::REST::Client.new accountSid, authToken
  client.account.sms.messages.create(
    :from => ENV['TWILIO_SMS_FROM'],
    :to => ENV['TWILIO_SMS_TO'],
    :body => "This is Door. Just let someone in: #{transcriptionText}. #{recordingUrl}",
  )
end
