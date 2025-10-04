# Node LTS, small image
FROM node:20-alpine

ENV NODE_ENV=production

# App folder + non-root user
WORKDIR /app
RUN addgroup -S app && adduser -S app -G app
USER app

# Install only prod deps
COPY --chown=app:app package*.json ./
RUN npm ci --only=production

# Copy source
COPY --chown=app:app . .

# Your app uses 3000
EXPOSE 3000

CMD ["node", "src/index.js"]
