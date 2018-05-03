FROM appworkshop/meteord:node-8.11.1-base
RUN apt-get update -y
RUN apt-get install graphicsmagick -y
RUN apt-get install pdftk -y
RUN apt-get install wget -y
RUN apt-get install build-essential chrpath libssl-dev libxft-dev -y
RUN apt-get install libfreetype6 libfreetype6-dev -y
RUN apt-get install libfontconfig1 libfontconfig1-dev -y
ENV PHANTOM_JS phantomjs-2.1.1-linux-x86_64
RUN wget https://github.com/Medium/phantomjs/releases/download/v2.1.1/$PHANTOM_JS.tar.bz2
RUN tar xvjf $PHANTOM_JS.tar.bz2
RUN mv $PHANTOM_JS /usr/local/share
RUN ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin
RUN phantomjs --version
