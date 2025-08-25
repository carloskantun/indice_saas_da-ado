# Roles y Permisos

## Flujo de creación, invitación y asignación

1. **Seleccionar empresa en `panel_root/`** (solo `root`): desde el panel maestro se define la empresa activa antes de invitar usuarios.
2. **Enviar invitación**: `POST admin/controller.php` con `action=send_invitation`. El controlador valida rol y empresa y registra la invitación.
3. **Aceptar invitación**: el usuario sigue el enlace a `admin/accept_invitation.php`, que llama al mismo controlador con `action=accept_invitation` para crear la cuenta.
4. **Asignar rol**: una vez creado el usuario, se puede ajustar su rol mediante `action=update_user_role` o aplicar plantillas (`action=apply_role_template`).
5. **Asignar permisos**: para permisos granulares se usa `action=update_permissions`, que escribe en `user_module_permissions`.

### Ejemplo de API: invitación de usuario

```bash
curl -X POST https://indice.example.com/admin/controller.php \
  -d 'action=send_invitation' \
  -d 'email=nuevo@indiceapp.com' \
  -d 'role=admin' \
  -d 'company_id=1' \
  -d 'csrf_token=TOKEN'
```

El usuario finalizará el registro con:

```bash
curl -X POST https://indice.example.com/admin/controller.php \
  -d 'action=accept_invitation' \
  -d 'token=TOKEN_RECIBIDO' \
  -d 'name=Nombre Usuario' \
  -d 'password=Secreta123'
```

### Ejemplo de API: asignación de permisos

```bash
curl -X POST https://indice.example.com/admin/controller.php \
  -d 'action=update_permissions' \
  -d 'user_id=42' \
  -d 'company_id=1' \
  -d 'module_id=expenses' \
  -d 'permissions={"can_view":1,"can_edit":1}' \
  -d 'csrf_token=TOKEN'
```

## Tabla de Roles y Permisos

| Módulo | Permisos | Roles con acceso |
| --- | --- | --- |
| panel_root | panel_root.ver, panel_root.editar | root |
| analytics | analytics.ver, analytics.editar | admin |
| chat | chat.ver, chat.editar | admin, user |
| cleaning | cleaning.ver, cleaning.editar | admin |
| crm | crm.ver, crm.editar | admin |
| expenses | expenses.ver, expenses.editar, expenses.kpis | admin |
| forms | forms.ver, forms.editar | admin |
| human-resources | hr.ver, hr.editar | admin |
| inventory | inventory.ver, inventory.editar | admin |
| invoicing | invoicing.ver, invoicing.editar | admin |
| kpis | kpis.ver, kpis.editar | admin |
| laundry | laundry.ver, laundry.editar | admin |
| maintenance | maintenance.ver, maintenance.editar | admin |
| minutes | minutes.ver, minutes.editar | admin |
| petty-cash | petty-cash.ver, petty-cash.editar | admin |
| pos | pos.ver, pos.editar | admin |
| processes-tasks | processes-tasks.ver, processes-tasks.editar | admin |
| properties | properties.ver, properties.editar | admin |
| sales-agent | sales-agent.ver, sales-agent.editar | admin |
| settings | settings.ver, settings.editar | admin |
| template-module | template-module.ver, template-module.editar | admin |
| training | training.ver, training.editar | admin, user |
| transportation | transportation.ver, transportation.editar | admin |
| vehicles | vehicles.ver, vehicles.editar | admin |
