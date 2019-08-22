FROM node:7.7.0-alpine

# - this app listens on port 3000, but the container should launch on port 80
EXPOSE 3000
  #  so it will respond to http://localhost:80 on your computer
# - then it should use alpine package manager to install tini: 'apk add --update tini'
RUN apk add --update tini 
# - then it should create directory /usr/src/app for app files with 'mkdir -p /usr/src/app'
RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app
# - Node uses a "package manager", so it needs to copy in package.json file
COPY package.json package.json
# - then it needs to run 'npm install' to install dependencies from that file
RUN npm install && npm cache clean --force
# - to keep it clean and small, run 'npm cache clean --force' after above
# - then it needs to copy in all files from current directory
COPY . .
# - then it needs to start container with command '/sbin/tini -- node ./bin/www'
CMD [ "/sbin/tini", "--", "node", "./bin/www" ]