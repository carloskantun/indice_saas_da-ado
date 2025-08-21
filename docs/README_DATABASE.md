# Base de datos

Este proyecto utiliza un sistema sencillo de migraciones para mantener el esquema actualizado.

## Estructura

Los scripts se encuentran en `database/migrations` y están numerados en el orden en que deben ejecutarse.
Los archivos `.sql` son aplicados automáticamente; los scripts `.php` requieren ejecución manual.

## Ejecución de migraciones

1. Configura la conexión a base de datos en `config.php`.
2. Ejecuta:
   ```bash
   php database/migrate.php
   ```
3. Si el proceso indica migraciones manuales, ejecútalas con:
   ```bash
   php database/migrations/NOMBRE_DEL_SCRIPT.php
   ```

El script registrará las migraciones aplicadas en la tabla `migrations` para evitar ejecuciones repetidas.
