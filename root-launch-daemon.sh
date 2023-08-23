#!/bin/bash

# Create the LaunchDaemon plist
cat << EOLAUNCHDAEMON > "/Library/LaunchDaemons/com.parsec.configure.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.parsec.configure</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>/Users/editor/Documents/parsec-startupgit/startup-convert.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
EOLAUNCHDAEMON