require 'twilio-ruby'
require 'json'

# Parse webhook
@payload = JSON.parse(payload)

# Load configuration
config = YAML.load_file("settings.yml")
@client = Twilio::Rest::Client.new(config['twilio']['account_sid'], config['twilio']['auth_token'])

# Send SMS
@client.account.sms.messages.create(
	:from => config['twilio']['phone_number'],
	:to => @payload["destination"],
	:body => "BTC traded at #{@payload["price"]} which is \
		#{@payload["alert_when"].downcase} your threshold \
		of #{@payload["threshold"]}."
)
