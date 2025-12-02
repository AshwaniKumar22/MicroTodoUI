FROM node:16.20-alpine as build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Build the React app
RUN npm run build

# Stage 2: Create a minimal production-ready image
FROM nginx:alpine 

# Copy the built app from the 'build' stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80