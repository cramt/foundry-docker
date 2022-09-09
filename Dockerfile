FROM ubuntu as build
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install unzip -y
WORKDIR /app
ARG input_zip
COPY ./foundry_zips/${input_zip} /app/foundry.zip
RUN unzip foundry.zip -d /app/foundry/
FROM node:18-alpine
WORKDIR /app
ENV UID=1000
ENV GID=1000
RUN deluser --remove-home node && \
    addgroup -g $GID foundry && \
    adduser -u $UID -G foundry -D foundry 
RUN mkdir /data
COPY --from=build /app/foundry /app/foundry
EXPOSE 30000
CMD ["node", "/app/foundry/resources/app/main.js", "--headless", "--dataPath=/data" ]