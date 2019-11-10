# Specify a base image
# https://hub.docker.com/_/nginx
FROM node:alpine as builder

WORKDIR '/app'

# Install some dependencies
# separate the copy section, speed up when rebuild docker image
COPY ./package.json ./
RUN npm install
COPY ./ ./

# Default command
CMD ["npm", "run", "build"]

# second phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
