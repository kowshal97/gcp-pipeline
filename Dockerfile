FROM node:20-alpine

ENV NODE_ENV=production

# Set working directory
WORKDIR /app

# Copy package files and install dependencies as root
COPY package*.json ./
RUN npm ci --only=production

# Copy source code
COPY . .

# Create non-root user and give ownership
RUN addgroup -S app && adduser -S app -G app
RUN chown -R app:app /app
USER app

# Expose the port your app listens on
EXPOSE 3000

# Start the app
CMD ["node", "src/index.js"]
