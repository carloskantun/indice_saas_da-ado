# Mantenimiento: scripts PHP

El directorio `scripts/` agrupa scripts de mantenimiento y tareas administrativas que se ejecutan manualmente para actualizar o verificar el sistema.

## Scripts incluidos
- `add_human_resources_module.php`: registra o actualiza el módulo de Recursos Humanos.
- `apply_optimizations.php`: aplica optimizaciones a la base de datos.
- `check_users_structure.php`: verifica la estructura y contenido de la tabla de usuarios.
- `configure_hr_permissions.php`: configura los permisos iniciales del módulo de Recursos Humanos.
- `create_attendance_table.php`: crea la tabla de asistencia.
- `create_employee_trigger.php`: genera el trigger asociado a empleados.
- `create_hr_tables_only.php`: crea únicamente las tablas necesarias para Recursos Humanos.
- `database_analysis.php`: muestra un análisis detallado de la base de datos.
- `expand_users_table.php`: expande la tabla de usuarios con nuevas columnas.
- `list_users.php`: lista usuarios y sus roles para fines de depuración.
- `setup_user_profile.php`: inicializa datos de perfil para un usuario específico.
- `update_position_names.php`: actualiza nombres de posiciones en la base de datos.
- `update_roles.php`: actualiza los roles definidos en el sistema.
- `verify_hr_setup.php`: verifica la configuración del módulo de Recursos Humanos.
- `verify_plans.php`: revisa la configuración de planes del sistema.

Estos scripts no forman parte del flujo normal de la aplicación y están pensados para tareas puntuales de administración.
