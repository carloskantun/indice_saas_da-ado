# Configuración de Correo

El sistema utiliza un archivo único para la configuración de correo ubicado en `admin/email_config.php`.

## Constantes Disponibles
- `MAIL_FROM_EMAIL`
- `MAIL_FROM_NAME`
- `MAIL_REPLY_TO`
- `EMAIL_DEBUG`
- `EMAIL_USE_SMTP`

Estas constantes se pueden ajustar según el entorno.

## Variantes Locales
Para mantener credenciales personalizadas fuera del control de versiones:

1. Copiar el archivo base:
   ```bash
   cp admin/email_config.php admin/email_config_local.php
   ```
2. Editar `admin/email_config_local.php` con los valores específicos.
3. Incluir este archivo en tu entorno local, se cargará automáticamente si existe.

> `admin/email_config_local.php` está incluido en `.gitignore` para evitar su seguimiento.
