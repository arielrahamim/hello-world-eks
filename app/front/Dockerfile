# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory to /app
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install any needed packages specified in package.json
RUN npm install -g http-server
RUN npm install

# Copy the current directory contents into the container at /app
COPY . .
# 
EXPOSE 8080
# Run client.js when the container launches
CMD ["node", "client.js"]
