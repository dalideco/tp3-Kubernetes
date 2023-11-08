# Use the official Node.js 16 image.
# https://hub.docker.com/_/node
FROM node:19.9.0-alpine

# Create and change to the app directory.
WORKDIR /usr/src/app

# Copy application dependency manifests to the container image.
# A wildcard is used to ensure both package.json AND package-lock.json are copied.
# Copying this separately prevents re-running npm install on every code change.
COPY package*.json ./

# Install production dependencies.
RUN npm install --only=production

# Copy local code to the container image.
COPY . .

# Bind to all network interfaces so that it can be mapped to the host OS.
ENV PORT 3000
EXPOSE 3000

CMD [ "node", "app.js" ]
