# aiqum_to_slackHere is a AIQUM to Slack integration that runs on the AIQUM appliance or linux install (as long as the linux install includes curl. The appliance includes curl by default)

I've tested this on 9.11-9.13. It's nothing special. I imagine it works on many more versions.

So here's the really basic instructions to make this work
Create an incoming Webhook in Slack follow along with their document https://api.slack.com/messaging/webhooks
Open the script in a text editor right at the top there's 4 variables that need to populate

proxyenabled="0"
proxyaddress="http://127.0.0.1:3128"
webhook="https://hooks.slack.com/services/000000000000/0000000000/000000000000000000000"
aiqumurl="https://aiqum.domain.com"

proxyenabled 0 is no 1 is yes
proxy address is self explanatory.
webhook is the URL you get for the creating the slack webhook
aiqumurl is the URL for your Active IQ server

After all of this is complete upload the the script to AIQUM (This has been tested on 9.11-9.13 but more than likely works on earlier versions as well

To upload to AIQUM 

Login to AIQUM
Select Storage Management
Select Scripts
Click Add
Select the script

After thats complete 
Select Storage Management
Select Alert Setup
Add a new or edit and existing alert.
Select your trigger conditions
Under the actions tab select script to execute select the script you uploaded
Select save

Next time Active IQ generates an alert for the condition(s) you specified it should alert you via your Slack integration.
