FROM node:alpine

RUN mkdir /opt/app/

WORKDIR /opt/app/

COPY ./app/ .

RUN npm install

CMD ["node", "server.js"]