# Contribuir

Este proyecto utiliza [PHP_CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer) para mantener un estilo de código consistente.

## Instalación

```bash
composer install
```

## Linter

Ejecuta el linter antes de hacer un commit:

```bash
composer lint
```

Esto analizará los directorios `modules/`, `admin/` y todos los archivos `*.php` en la raíz del repositorio.

## Integración continua

El flujo de CI ejecuta el mismo comando `composer lint` en cada *push* y *pull request*. Asegúrate de que el comando pase sin errores antes de abrir un PR.
