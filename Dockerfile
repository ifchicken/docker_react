# Specify a base image
# https://hub.docker.com/_/nginx
FROM node:alpine as builder

WORKDIR '/app'

# Install some dependencies
# separate the copy section, speed up when rebuild docker image
COPY ./package.json ./
RUN npm install
# COPY ./ ./
COPY package*.json ./

# Default command
CMD ["npm", "run", "build"]

# second phase
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
