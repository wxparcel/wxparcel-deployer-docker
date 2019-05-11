#! /bin/bash

pids=$(pidof /usr/bin/Xvfb)
if [ -n "$pids" ]; then
  echo 'Xvfb is running'
else
  Xvfb $DISPLAY -ac &
fi

if [ ! -f "$HOME/.config/wechat_web_devtools/Default/.ide-status" ]; then
  $HOME/devtool/bin/wxdt install
  echo "On" > $HOME/.config/wechat_web_devtools/Default/.ide-status
  ${HOME}/devtool/bin/cli
fi

wxparcel-deployer server \
--devtool-cli $HOME/devtool/bin/cli \
--devtool-ide $HOME/.config/wechat_web_devtools/Default/.ide
