FROM debian as gitcloner
RUN apt-get update && apt-get install -y git

FROM gitcloner as builder
RUN apt-get update && apt-get install -y curl build-essential autoconf curl dirmngr apt-transport-https lsb-release ca-certificates
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt update && apt -y install nodejs gcc g++ make

RUN npm install npm@latest -g
RUN npm install pm2@latest -g

FROM builder
RUN git clone https://github.com/NotExpectedYet/OctoFarm.git /var/lib/octofarm && cd /var/lib/octofarm && git checkout 1.1.13-hotfix


ENV MONGOUSER root
ENV MONGOPASS rootpassword
ENV MONGOHOST mongodb

WORKDIR /var/lib/octofarm
RUN mkdir logs
RUN ls && npm install
EXPOSE 4000

RUN rm -Rf /var/lib/octofarm/node_modules/mozjpeg

# works only in Dev mode
CMD ["npm", "run", "dev"]

# Production mode
#CMD ["npm", "start" ]
