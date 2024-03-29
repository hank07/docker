# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install the application dependencies
RUN npm install

# Copy the application source code to the container
COPY . .

# Expose the port on which the app will run
EXPOSE 3000

# Define the command to run the application
CMD ["npm", "start"]
