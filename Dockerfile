# Gerando uma imagem para a produção
# Primeiro a imagem para compilar o código
FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Depois a imagem para instalar o servidor em produção
FROM nginx
EXPOSE 80
# Copia o resultado do build no container 0 para a pasta específica do servidor HTTP
COPY --from=0 /app/build /usr/share/nginx/html
