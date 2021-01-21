# Build phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Run phase
# /usr/share/nginx/html is nginx folder to serve static html files
FROM nginx as runner
COPY --from=builder /app/build /usr/share/nginx/html

# docker build .
# docker run -p PORT_ON_MACHINE:PORT_INSIDE_CONTAINER IMAGE_ID
# docker run -p 8080:80 4e2f24a2778922fae483305a6c387a83a172a36f7e5523622cc2cad151609b47

