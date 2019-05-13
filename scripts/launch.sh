#! /bin/bash

# set -e # exit when error occured

XvfbLockFile=/tmp/.X1-lock
XvfbPids=$(pidof /usr/bin/Xvfb)

if [ -n "$XvfbPids" ]; then
  echo "kill xvfb processes"
  kill "$XvfbPids"
else
  if [ -f "$XvfbLockFile" ]; then
    echo "delete xvfb tmp file"
    rm $XvfbLockFile
  fi

  echo "start xvfb server with display: $DISPLAY"
  Xvfb $DISPLAY -ac &
fi

if [ ! -f "$HOME/.config/wechat_web_devtools/Default/.ide-status" ]; then
  echo "install wxdt"
  $HOME/devtool/bin/wxdt install

  echo "open ide http server"
  echo "On" > $HOME/.config/wechat_web_devtools/Default/.ide-status
fi

echo 'start wxparcel deployer server'
wxparcel-deployer server \
--devtool-cli $HOME/devtool/bin/cli \
--devtool-ide $HOME/.config/wechat_web_devtools/Default/.ide
