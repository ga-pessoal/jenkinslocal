FROM jenkins/jenkins

USER root

# .NET5.0

RUN wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update; \
 apt-get install -y apt-transport-https && \
 apt-get update && \
 apt-get install -y dotnet-sdk-5.0

# Xvfb

RUN apt-get update -qqy \
	&& apt-get -qqy install xvfb \
	&& rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Google Chrome

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
	&& apt-get update -qqy \
	&& apt-get -qqy install google-chrome-stable \
	&& rm /etc/apt/sources.list.d/google-chrome.list \
	&& rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
	&& sed -i 's/"$HERE\/chrome"/xvfb-run "$HERE\/chrome" --no-sandbox/g' /opt/google/chrome/google-chrome

# Nodejs

RUN curl -sL https://deb.nodesource.com/setup_15.x  | bash -
RUN apt-get -y install nodejs
