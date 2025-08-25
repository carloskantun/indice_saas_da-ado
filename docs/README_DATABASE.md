# Base de datos

Este proyecto utiliza un sistema sencillo de migraciones para mantener el esquema actualizado.

## Estructura

Los scripts se encuentran en `database/migrations` y están numerados en el orden en que deben ejecutarse.
Los archivos `.sql` son aplicados automáticamente; los scripts `.php` requieren ejecución manual.

## Crear nuevas migraciones

1. Agrega el script en `database/migrations/` usando un prefijo numérico incremental
   (por ejemplo `015_create_attendance_table.sql`).
2. Utiliza la extensión `.sql` para migraciones automáticas o `.php` para las que
   necesiten lógica personalizada.

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

4. Las migraciones nuevas (a partir de `016_`) reemplazan los antiguos archivos
   `.sql` que estaban en la raíz del proyecto y se aplican automáticamente con
   el mismo comando de migración.

El script registrará las migraciones aplicadas en la tabla `migrations` para evitar ejecuciones repetidas.

## Seeds de datos iniciales

Para insertar el usuario **root** y activar los módulos esenciales, ejecuta:

```bash
php database/seeds/seed_initial_data.php
```
