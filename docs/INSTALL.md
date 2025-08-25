# Guía de Instalación

## Variables de entorno necesarias
Copia el archivo `.env.example` a `.env` y ajusta las siguientes variables:

```bash
DB_HOST=localhost
DB_NAME=tu_base_de_datos
DB_USER=tu_usuario
DB_PASS=tu_contraseña

MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=tu_email@gmail.com
MAIL_PASSWORD=tu_contraseña_de_aplicacion
MAIL_ENCRYPTION=tls

APP_ENV=production
APP_DEBUG=false
APP_URL=https://tudominio.com

SESSION_LIFETIME=120
SESSION_ENCRYPT=false

CACHE_DRIVER=file
CACHE_PREFIX=indice_saas_
```

## Instalación de dependencias
Ejecuta los siguientes comandos en la raíz del proyecto:

```bash
composer install
npm install    # si el proyecto requiere recursos de Node.js
```

## Verificación rápida
Confirma que tu entorno cumple con los requisitos mínimos:

```bash
php -v
php -m | grep -i pdo
```

Debe mostrarse la versión de PHP y las extensiones `PDO` y `pdo_mysql` habilitadas.

## Prueba de instalación
Ejecuta el test de humo para verificar la conexión a la base de datos y los datos iniciales:

```bash
composer test
# o
vendor/bin/phpunit tests/InstallSmokeTest.php
```
