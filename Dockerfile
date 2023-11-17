# syntax=docker/dockerfile:1

ARG NODE_VERSION=20

FROM node:${NODE_VERSION}-alpine as build-image

WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY . /app
RUN npm run build
RUN ls -la /app/dist


FROM nginx:latest
COPY --from=build-image /app/dist/frontend/ /usr/share/nginx/html


