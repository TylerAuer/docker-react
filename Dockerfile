# "as builder" tags process with a name I can reference in docker-compose.yml
# This process generates built project in '/app/build'
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# Default command for nginx starts up the server, so we don't need to override it