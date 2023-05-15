FROM richarvey/nginx-php-fpm:1.7.2

# Instalar dependencias necesarias para Laravel
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    zip \
    unzip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copiar los archivos de la aplicación a la imagen
COPY . /var/www/html

# Instalar dependencias de PHP con Composer
RUN composer install --no-dev --no-scripts --no-interaction --optimize-autoloader

# Configurar la aplicación Laravel
ENV APP_ENV production
ENV APP_DEBUG false
ENV LOG_CHANNEL stderr

# Definir el directorio de trabajo
WORKDIR /var/www/html

# Definir el puerto en el que se ejecutará la aplicación
EXPOSE 80

# Ejecutar el servidor web y PHP-FPM
CMD ["/start.sh"]