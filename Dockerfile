# Base image
FROM ubuntu:16.04

# Author
MAINTAINER DavidJones (qowera@qq.com)

# Normalize
RUN sed -i '#http://\(archive\|security\).ubuntu.com/#http://mirrors.aliyun.com/#' /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y \
gconf-service \
libxext6 \
libxfixes3 \
libxi6 \
libxrandr2 \
libxrender1 \
libcairo2 \
libcups2 \
libdbus-1-3 \
libexpat1 \
libfontconfig1 \
libgcc1 \
libgconf-2-4 \
libgdk-pixbuf2.0-0 \
libglib2.0-0 \
libgtk-3-0 \
libnspr4 \
libpango-1.0-0 \
libpangocairo-1.0-0 \
libstdc++6 \
libx11-6 \
libx11-xcb1 \
libxcb1 \
libxcomposite1 \
libxcursor1 \
libxdamage1 \
libxss1 \
libxtst6 \
libappindicator1 \
libnss3 \
libasound2 \
libatk1.0-0 \
libc6 \
ca-certificates \
fonts-liberation \
lsb-release \
xdg-utils \
wget

# Envirment
ENV LANG C.UTF-8
ENV DISPLAY :1.0
ENV HOME /root
RUN echo "Asia/Shanghai" > /etc/timezone

# Install nodejs npm and our server
RUN apt-get install -y curl git
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
RUN npm i -g wxparcel-deployer

# Install gui runner
RUN apt-get install -y xvfb

# Clone third-party libs
RUN git clone https://github.com/cytle/wechat_web_devtools.git ${HOME}/devtool
# Update and install newest version
RUN ${HOME}/devtool/bin/update_nwjs.sh && rm -rf /tmp/wxdt_xsp
# Fix cp /* error
COPY ./replace_weapp_vendor.sh ${HOME}/devtool/bin/replace_weapp_vendor.sh
RUN chmod +x ${HOME}/devtool/bin/replace_weapp_vendor.sh

# Install launch shell
COPY ./launch.sh ${HOME}/launch.sh
RUN chmod +x ${HOME}/launch.sh

EXPOSE 3000
ENTRYPOINT ["/root/launch.sh"]
