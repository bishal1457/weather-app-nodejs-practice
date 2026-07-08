# Use Nodd.js 18 image as base image. 
# It incldues Node.js and npm required to run the application.
FROM node:20-alpine

# Set the working directory inside the container. 
# Every commands executes inside the /app. 
WORKDIR /app 

# Copy package files FIRST (caching optimisation) 
# This layer is only rebuilt if package.json changes 
COPY package*.json ./

#Install project dependencies. 
#npm ci instal the exact dependency version form package-lock-json. 
RUN npm ci

#Copy application source code 
#Copies the reamining project files. 
COPY . .

#Create a non-root user. 
#Imprvoes container security 
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

#Switch to non-root user. 
USER appuser 

#The application listens on port 3000. 
EXPOSE 3000

#Start the application 
#Executes the start script form package.json
CMD ["npm", "start"]

