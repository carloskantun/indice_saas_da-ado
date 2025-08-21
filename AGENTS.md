# AGENTS.md

## 👤 ROLES Y FLUJO

- El sistema debe ser compatible con múltiples roles y múltiples empresas por usuario.
- Cada entidad (empresa, unidad, negocio) puede tener múltiples usuarios con distintos roles.
- Los permisos deben consultarse antes de mostrar acciones o datos.
- Tabla de roles y permisos: [docs/roles_permisos.md](docs/roles_permisos.md)
- Los *slugs* de los módulos deben estar en **inglés** (p. ej. `expenses`, `maintenance`, `customer-service`).

## ✅ MODULOS

### Módulo: panel_root
Ruta: `/panel_root/`

Archivos clave:
- index.php
- plans.php
- controller.php
- modals/modal_add_plan.php
- modals/modal_edit_plan.php
- js/root_panel.js

Permisos:
- panel_root.ver
- panel_root.editar

Ejemplo:
```php
auth();
checkRole(['root']);
```

### Módulo: analytics
Ruta: `/modules/analytics/`

Archivos clave:
- index.php
- controller.php
- js/

Permisos:
- analytics.ver
- analytics.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```


### Módulo: chat
Ruta: `/modules/chat/`

Archivos clave:
- index.php
- controller.php
- js/

Permisos:
- chat.ver
- chat.editar

Ejemplo:
```php
auth();
checkRole(['user', 'admin']);
```


### Módulo: cleaning
Ruta: `/modules/cleaning/`

Archivos clave:
- index.php
- controller.php
- js/

Permisos:
- cleaning.ver
- cleaning.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```


### Módulo: crm
Ruta: `/modules/crm/`

Archivos clave:
- index.php
- controller.php
- js/

Permisos:
- crm.ver
- crm.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```


### Módulo: expenses
Ruta: `/modules/expenses/`

Archivos clave:
- index.php
- controller.php
- config.php
- modals.php
- js/

Permisos:
- expenses.ver
- expenses.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```


### Módulo: forms
Ruta: `/modules/forms/`

Archivos clave:
- index.php
- controller.php
- js/

Permisos:
- forms.ver
- forms.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```


### Módulo: human-resources
Ruta: `/modules/human-resources/`

Archivos clave:
- index.php
- controller.php
- config.php
- modals.php
- js/

Permisos:
- human-resources.ver
- human-resources.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```


### Módulo: inventory
Ruta: `/modules/inventory/`

Archivos clave:
- index.php
- controller.php
- js/

Permisos:
- inventory.ver
- inventory.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```


### Módulo: invoicing
Ruta: `/modules/invoicing/`

Archivos clave:
- index.php
- controller.php
- js/

Permisos:
- invoicing.ver
- invoicing.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```


### Módulo: kpis
Ruta: `/modules/kpis/`

Archivos clave:
- index.php
- controller.php
- js/

Permisos:
- kpis.ver
- kpis.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```


### Módulo: laundry
Ruta: `/modules/laundry/`

Archivos clave:
- index.php
- controller.php
- js/

Permisos:
- laundry.ver
- laundry.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```


### Módulo: maintenance
Ruta: `/modules/maintenance/`

Archivos clave:
- index.php
- controller.php
- modals.php
- js/

Permisos:
- maintenance.ver
- maintenance.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```


### Módulo: minutes
Ruta: `/modules/minutes/`

Archivos clave:
- index.php
- controller.php
- js/

Permisos:
- minutes.ver
- minutes.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```


### Módulo: petty-cash
Ruta: `/modules/petty-cash/`

Archivos clave:
- index.php
- controller.php
- js/

Permisos:
- petty-cash.ver
- petty-cash.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```


### Módulo: pos
Ruta: `/modules/pos/`

Archivos clave:
- index.php
- controller.php
- js/

Permisos:
- pos.ver
- pos.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```


### Módulo: processes-tasks
Ruta: `/modules/processes-tasks/`

Archivos clave:
- index.php
- controller.php
- config.php
- modals.php
- js/

Permisos:
- processes-tasks.ver
- processes-tasks.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```


### Módulo: properties
Ruta: `/modules/properties/`

Archivos clave:
- index.php
- controller.php
- js/

Permisos:
- properties.ver
- properties.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```


### Módulo: sales-agent
Ruta: `/modules/sales-agent/`

Archivos clave:
- index.php
- controller.php
- js/

Permisos:
- sales-agent.ver
- sales-agent.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```


### Módulo: settings
Ruta: `/modules/settings/`

Archivos clave:
- index.php
- controller.php
- js/

Permisos:
- settings.ver
- settings.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```


### Módulo: template-module
Ruta: `/modules/template-module/`

Archivos clave:
- index.php
- controller.php
- modals.php
- js/

Permisos:
- template-module.ver
- template-module.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```


### Módulo: training
Ruta: `/modules/training/`

Archivos clave:
- index.php
- controller.php
- js/

Permisos:
- training.ver
- training.editar

Ejemplo:
```php
auth();
checkRole(['user', 'admin']);
```


### Módulo: transportation
Ruta: `/modules/transportation/`

Archivos clave:
- index.php
- controller.php
- js/

Permisos:
- transportation.ver
- transportation.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```


### Módulo: vehicles
Ruta: `/modules/vehicles/`

Archivos clave:
- index.php
- controller.php
- js/

Permisos:
- vehicles.ver
- vehicles.editar

Ejemplo:
```php
auth();
checkRole(['admin']);
```

### Módulo: Admin (Gestión de usuarios)
Ruta: `/admin/`

Archivos clave:
- invite_user.php
- manage_roles.php
- controller.php
- js/admin_users.js
- modals/modal_invite_user.php

Permisos:
- admin.invite_user
- admin.manage_roles

Ejemplo:
```php
auth();
checkRole(['admin']);
```
