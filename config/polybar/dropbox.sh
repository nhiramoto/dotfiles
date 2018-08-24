#!/usr/bin/env sh
# A polybar module for dropbox using dropbox-cli

colorRunning="#ffffff"
colorStopped="#555"

dropbox-cli running
isrunning=$?

if [[ $# -gt 0 ]]; then
  case "$1" in
      toggle)
          if [ $isrunning -ne 0 ]; then
              dropbox-cli stop
          else
              dropbox-cli start
          fi
          ;;
          *)
              echo 'error: wrong argument'; exit 1
          ;;
  esac
fi

status=`dropbox-cli status`
#echo %{F$colorRunning} $status%{F-}
if [ $isrunning -ne 0 ]; then
    if [[ "$status" =~ .*"Up to date".* ]]; then
        echo "%{F$colorRunning} %{F-}"
    elif [[ "$status" =~ "Syncing".* ]]; then
        echo "%{F$colorRunning} %{F-}"
    else
        echo "%{F$colorRunning} %{F-}"
    fi
else
    echo "%{F$colorStopped} %{F-}"
fi

exit 0
