# Use an official Node.js runtime as the base image
FROM node:20-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy all files from your project into the container
COPY . .

# Optional: expose the port your app will run on
EXPOSE 1337

# Optional: run a simple command (if needed)
CMD ["node"]
