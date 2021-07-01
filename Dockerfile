FROM node:alpine as builder
RUN mkdir /app && \
    chown node:node /app
USER node
WORKDIR /app
COPY --chown=node:node package.json .
RUN npm install
COPY --chown=node:node . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html