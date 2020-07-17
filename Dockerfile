FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
# --from=0 looks at the process above (FROM node:alpine) and pulls files from that
COPY --from=0 /app/build /usr/share/nginx/html
# Default command for nginx starts up the server, so we don't need to override it