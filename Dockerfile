# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/engine/reference/builder/

ARG NODE_VERSION=20

FROM node:20-alpine as build-image

WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY . /app
RUN npm run build
RUN ls -la /app/dist


FROM nginx:latest
COPY --from=build-image /app/dist/frontend/ /usr/share/nginx/html


