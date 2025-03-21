# Använd en liten och säker basimage
FROM node:18-alpine

# Skapa en icke-root användare för att öka säkerheten
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Sätt arbetskatalog och kopiera in projektet
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install --only=production
COPY . .

# Byt till den icke-root användaren
USER appuser

# Exponera port 3000 (så vi kan nå applikationen)
EXPOSE 3000

# Kör applikationen när containern startar
CMD ["npm", "start"]
