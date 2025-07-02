# Etapa 1: Compilación
FROM golang:1.23-alpine AS builder

# Instalar dependencias básicas
RUN apk add --no-cache build-base

# Crear directorio de trabajo
WORKDIR /app

# Copiar el código fuente
COPY main.go .
COPY go.mod .

# Compilar el binario de forma estática
RUN go build -ldflags="-s -w" -o main .

# Etapa 2: Imagen final mínima
FROM alpine

# Copiar solo el binario compilado desde el builder
COPY --from=builder /app/main main

# Exponer el puerto usado por el servidor
EXPOSE 8080

# Comando para ejecutar el binario
ENTRYPOINT ["./main"]
