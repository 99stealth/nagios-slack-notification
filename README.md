# Slack notifier for Nagios

## What is this
It is custom plugin for Nagios which will help you to push notifications from Nagios to Slack
## How to setup
```
git clone 
```
Jump to directory
```
cd nagios-notifications-to-slack
```
Copy plugin to directory with nagios plugins
```
cp plugins/send_message_to_slack.sh /path/to/nagios/plugins
```
Copy commands to your commands file or directory
```
cp commands/* /path/to/nagios/commands
```
Add create new nagios macroses with slack channel and slack token
```
echo "$SLACK_TOKEN$=xoxb-111111111111-zzzzZZZZzzzzZZZZzzzzZZZZ" > /path/to/nagios/private/resource.cfg
echo "$SLACK_CHANNEL$=your_channel" > /path/to/nagios/private/resource.cfg
```
Add command for needed user / usergroup / or template. For example
```
define contact {
    name                                generic-contact
    ...
    service_notification_command        notify-service-by-slack
    host_notification_command           notify-host-by-slack
    ...
}
```
Restart Nagios
```
service nagios restart
```