#!/bin/bash


# requires teams binary and latest version of parsec-macos-mlu.pkg 
# make sure to fill out BINARY_DIRECTORY with a path to the folder that contains both files
# when filling out the teams provisioning details, use -1 for optional integers, empty quotes "" for optional strings.


# Set permissions for the LaunchDaemon plist
chmod 644 "/Library/LaunchDaemons/com.parsec.configure.plist"
chown root:wheel "/Library/LaunchDaemons/com.parsec.configure.plist"

# Load the LaunchDaemon
launchctl load "/Library/LaunchDaemons/com.parsec.configure.plist"


TEAM_ID="1yVIjVfIzwz1keYaPOaXM7PTpao"
TEAM_KEY="tapi_2UNiDcE5knOpfq7Wyslt8Wdn42T"   
APP_RULE_ID="tar_2KaPxe720b5CNKhy6ii6VHDtNtX"
GUEST_ACCESS="0"
USER_ID="-1"
TEAM_GROUP_ID="21758"



curl https://builds.parsecgaming.com/package/parsec-macos-startup.pkg -o "/Users/Shared/parsec-macos-startup.pkg"
sleep 1
       
BINARY_DIRECTORY="/Users/editor/Downloads/TeamsInstall"
INSTALL_PATH="/Users/Shared/.parsec"


if [ $(ps aux | grep -c "[/]Applications/Parsec.app/Contents/MacOS/parsecd") -gt 0 ]
then
 pkill parsecd
 launchctl bootout unload -w /Library/LaunchAgents/com.parsec.app.plist
fi
sudo chmod 755 $BINARY_DIRECTORY/teams
sudo installer -pkg /Users/Shared/parsec-macos-startup.pkg -target /Applications
launchctl bootstrap load -w /Library/LaunchAgents/com.parsec.app.plist 
until [ $(ls $INSTALL_PATH/ | grep -c config.txt) -gt 0 ]
do 
 sleep 1
done
launchctl unload -w /Library/LaunchAgents/com.parsec.app.plist
sudo xattr -r -d com.apple.quarantine $BINARY_DIRECTORY/teams
sudo $BINARY_DIRECTORY/teams kessel-api.parsec.app $TEAM_KEY $TEAM_ID $APP_RULE_ID $GUEST_ACCESS $USER_ID $TEAM_GROUP_ID "$INSTALL_PATH/user.bin" 
echo 'app_channel=client_multiuser' >> "$INSTALL_PATH/config.txt"
echo 'app_host=1' >> "$INSTALL_PATH/config.json"
sudo rm -r /Users/$USER/Library/Caches/tv.parsec.www 
launchctl load -w /Library/LaunchAgents/com.parsec.app.plist 
until [ $(ls $INSTALL_PATH/ | grep -c client_multiuser) -gt 0 ]
do 
 sleep 1
done
launchctl unload -w /Library/LaunchAgents/com.parsec.app.plist
sudo rm $INSTALL_PATH/lock
launchctl load -w /Library/LaunchAgents/com.parsec.app.plist 
