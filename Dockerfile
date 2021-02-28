FROM node:12.19-slim

ENV USER=evobot

# install python and make
RUN apt-get update && \
	apt-get install -y python3 build-essential && \
	apt-get purge -y --auto-remove
	
# create evobot user
RUN groupadd -r ${USER} && \
	useradd --create-home --home /home/evobot -r -g ${USER} ${USER}
	
# set up volume and user
USER ${USER}
WORKDIR /home/evobot

# Create config.json from config.sample.json
COPY config.sample.json config.json

COPY package*.json ./
RUN npm install
VOLUME [ "/home/evobot" ]

COPY . .

ENTRYPOINT [ "node", "index.js" ]
