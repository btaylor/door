require 'rubygems'
require 'sinatra'
 
get '/' do
  response =<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<Response>
  <Play>https://dl.dropbox.com/s/0wf9wok59b5koe2/hello.wav?dl=1</Play>
  <Record timeout="2" maxLength="5" playBeep="false"
          action="/recordSuccess" />
  <Redirect>/recordTimeout</Redirect>
</Response>
EOF
end

get '/recordSuccess' do
response =<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<Response>
  <Play>https://dl.dropbox.com/s/28uq7mlvuf4rw9f/come-on-in.wav?dl=1</Play>
  <Play>http://jetcityorange.com/dtmf/DTMF-9.mp3</Play>
  <Sms from="+14156305155" to="+19098154939">Hey, I just let someone in the front door.</Sms>
  <Hangup />
</Response>
EOF
end

get '/recordTimeout' do
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
