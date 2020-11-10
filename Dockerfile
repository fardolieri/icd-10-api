FROM node:lts-alpine AS builder
WORKDIR /usr/src/node-builder
COPY . .
RUN npm install && \
    npm run build && \
    mkdir ./builder && \
    mv ./build ./builder/build && \
    mv ./tsconfig.json ./builder/tsconfig.json && \
    mv ./package.json ./builder/package.json

FROM node:lts-alpine
WORKDIR /usr/src/project
COPY --from=builder /usr/src/node-builder/builder .
RUN npm install --production
CMD npm run production
