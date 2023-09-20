#!/usr/bin/bash
##############################################
#         AIQUM to Slack Integration         #
# by Tim Brown (tim@virtualization-blog.com) #
#                 9/6/2023                   #
#                Version 0.2                 #
##############################################

proxyenabled="0"
proxyaddress="http://127.0.0.1:3128"
webhook="https://hooks.slack.com/services/000000000000/0000000000/000000000000000000000"
aiqumurl="https://aiqum.domain.com"


while test $# -gt 0; do
           case "$1" in
                -eventID)
                    shift
                    eventid=$1
                    shift
                    ;;
                -eventName)
                    shift
                    eventname=$1
                    shift
                    ;;
                -eventSeverity)
                    shift
                    eventseverity=$1
                    shift
                    ;;
                -eventSourceID)
                    shift
                    eventsourceid=$1
                    shift
                    ;;
                -eventSourceName)
                    shift
                    eventsourcename=$1
                    shift
                    ;;
                -eventSourceType)
                    shift
                    eventsourcetype=$1
                    shift
                    ;;
                -eventState)
                    shift
                    eventstate=$1
                    shift
                    ;;
                -eventArgs)
                    shift
                    eventargs=$1
                    shift
                    ;;
                *)
                   echo "$1 is not a recognized flag!"
                   return 1;
                   ;;
          esac
  done

post_data()
{
        cat <<EOF
{
"eventid": "$eventid",
"eventname": "$eventname",
"eventseverity": "$eventseverity",
"eventsourceid": "$eventsourceid",
"eventsourcename": "$eventsourcename",
"eventsourcetype": "$eventsourcetype",
"eventstate": "$eventstate",
"eventargs": "$eventargs"
}
EOF
}
if [[ $proxyenabled -eq 1 ]]
then
curl --proxy $proxyaddress $webhook -X POST -H 'Content-type: application/json' --data '{"text":"Risk: '"$eventname"' \nImpact Area: '"$eventsourcetype"' \nSeverity: '"$eventseverity"' \nCluster Name: '"$eventsourcename"'\nEvent State: '"$eventstate"'\nSource Details: '"$aiqumurl"'\/events/'"$eventid"'"}'
else
curl $webhook -X POST -H 'Content-type: application/json' --data '{"text":"Risk: '"$eventname"' \nImpact Area: '"$eventsourcetype"' \nSeverity: '"$eventseverity"' \nCluster Name: '"$eventsourcename"'\nEvent State: '"$eventstate"'\nSource Details: '"$aiqumurl"'\/events/'"$eventid"'"}'
fi

echo "$(post_data)"
