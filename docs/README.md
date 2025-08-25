# Indice SaaS - Documentación Unificada

Esta guía unifica la documentación previamente distribuida en los archivos `README*.md`.

## Índice de guías

- [Auditoría del sistema](AUDITORIA_SISTEMA.md)
- [Estándar de nombres de base de datos](DATABASE_NAMING_STANDARD.md)
- [Guía de migraciones de base de datos](README_DATABASE.md)
- [Configuración de email](email_config.md)
- [Roles, permisos e invitaciones](roles_permisos.md)
- [Sistema de gestión de usuarios admin](ADMIN_SYSTEM_COMPLETED.md)
- [Flujo de negocio SaaS](BUSINESS_SYSTEM_COMPLETE.md)
- [Corrección del sistema de invitaciones](CORRECTION_SUMMARY.md)
- [Sistema de invitaciones](INVITATION_SYSTEM_README.md)
- [Análisis del módulo de gastos](GASTOS_ANALYSIS.md)
- [Integración simple con panel root](INTEGRACION_SIMPLE.md)
- [Pase de lista interactivo](PASE_DE_LISTA_README.md)
- [Reorganización de botones y columnas](REORGANIZACION_BOTONES_README.md)

## Guía General

Sistema modular y escalable en PHP + MySQL que permite a múltiples empresas gestionar sus negocios, unidades, personal y servicios desde un solo ecosistema.

## 🎯 Objetivo

**Transformar** el sistema `Indice` (actualmente usado por elcorazondelcaribe.com) en una **plataforma SaaS multicliente**. La solución permite que un mismo usuario administre múltiples empresas, unidades o negocios, con jerarquías, roles y módulos personalizados.

**Visión:** Indice SaaS es una plataforma modular para empresas, diseñada para gestionar múltiples negocios y unidades operativas bajo un solo ecosistema. Este sistema permite escalar desde un solo usuario hasta una red de empresas y sucursales con roles jerárquicos y módulos dinámicos.

---

## ⚙️ Instalación y Configuración

### Requisitos del Sistema
- PHP 7.4 o superior
- MySQL 5.7 o superior  
- Servidor web (Apache/Nginx)
- Extensiones PHP: PDO, PDO_MySQL

### Instalación Paso a Paso
1. **Configurar Base de Datos**: 
   ```bash
   # Crear base de datos
   CREATE DATABASE indice_saas;
   
   # Editar config.php con credenciales
   ```

2. **Instalación automática**:
   ```bash
   php scripts/install_all.php
   ```
   Este comando ejecuta en orden todos los instaladores y migraciones necesarios.

3. **Configurar correo**:
   Revisar [email_config.md](email_config.md) para personalizar las constantes de envío.

### Credenciales Iniciales
- **Root**: `root@indiceapp.com` / `root123`
- **Admin Ejemplo**: `admin@indiceapp.com` / `admin123`

⚠️ **IMPORTANTE**: Cambiar credenciales en producción

---

## ✅ ESTRUCTURA DE ROLES Y JERARQUÍA

| Rol         | Descripción                                                       | Capacidades |
|-------------|-------------------------------------------------------------------|-------------|
| `root`       | Acceso total al sistema SaaS. Administra empresas, usuarios y planes. | Todas |
| `support`    | Soporte técnico limitado. No puede modificar cuentas ni empresas. | Solo lectura |
| `superadmin` | Propietario de empresas. Controla unidades, usuarios y módulos.  | Gestión empresarial |
| `admin`      | Administra una unidad o negocio dentro de una empresa.           | Gestión operativa |
| `moderator`  | Gerente de operación local. Supervisa tareas y registros.        | Supervisión |
| `user`       | Usuario operativo. Accede según permisos del sistema.            | Operación básica |

🔄 **Multi-Empresa**: Un mismo usuario puede tener múltiples roles en distintas empresas.

---

## 🧱 ARQUITECTURA Y ESCALAMIENTO

### Jerarquía de Entidades
```
👤 Usuario
└── 🏢 Empresa (múltiples)
    └── 🏭 Unidad de Negocio (regiones, áreas)
        └── 🏪 Negocio (sucursales físicas/digitales)
            └── 📦 Módulos Funcionales
```

### Estructura de Carpetas
```
indice_saas/
├── 📁 config.php              # Configuración global
├── 📁 index.php               # Punto de entrada principal
├── 📁 auth/                   # Sistema de autenticación
│   ├── index.php              # Login
│   ├── register.php           # Registro de usuarios
│   └── logout.php             # Cerrar sesión
├── 📁 companies/              # Gestión de empresas
├── 📁 units/                  # Gestión de unidades
├── 📁 businesses/             # Gestión de negocios
├── 📁 admin/                  # Panel de administración empresarial
│   ├── controller.php         # API para gestión de usuarios
│   ├── permissions_management.php # Sistema de permisos granulares
│   └── accept_invitation.php  # Aceptación de invitaciones
├── 📁 panel_root/             # Panel maestro del sistema SaaS
│   ├── index.php              # Dashboard root
│   ├── plans.php              # Gestión de planes SaaS
│   └── companies.php          # Todas las empresas del sistema
├── 📁 modules/                # Hub de módulos operativos
│   └── index.php              # Catálogo de módulos disponibles
├── 📁 indice-produccion/      # Sistema legacy (base funcional)
└── 📁 lang/                   # Archivos de idioma
    └── es.php                 # Español (idioma base)
```

---

## 🚀 FLUJO DE USUARIO

### Usuario Nuevo
1. **Registro** → `auth/register.php`
2. **Opción**:
   - ✅ Crear empresa (gratis con plan Free)
   - ✅ Unirse con código de invitación
3. **Dashboard** → Detecta contexto y muestra empresas disponibles

### Usuario Existente (Multi-Empresa)
1. **Recibe Invitación** → Email con token
2. **Acepta** → `admin/accept_invitation.php`
3. **Acceso** → Nuevo rol en empresa adicional

### Variables de Sesión
```php
$_SESSION['user_id']      // ID del usuario
$_SESSION['company_id']   // Empresa activa
$_SESSION['unit_id']      // Unidad activa (opcional)
$_SESSION['business_id']  // Negocio activo (opcional)
$_SESSION['current_role'] // Rol actual del usuario
```

---

## 📦 SISTEMA DE MÓDULOS

### Estructura Estándar
```
modules/[modulo]/
├── index.php              # Vista principal
├── controller.php         # Backend del módulo
├── js/[modulo].js         # Scripts JS y AJAX
├── modal_[funcion].php    # Modales reutilizables
├── kpis.php               # Indicadores clave
└── style.css              # Estilos locales
```

### Módulos Disponibles
| Módulo | Estado | Descripción |
|--------|--------|-------------|
| `analytics` | En desarrollo | Análisis y visualización de datos |
| `chat` | En desarrollo | Mensajería interna entre usuarios |
| `cleaning` | En desarrollo | Gestión de tareas de limpieza |
| `crm` | En desarrollo | Relaciones con clientes |
| `expenses` | Activo | Control de gastos e ingresos |
| `forms` | En desarrollo | Constructor de formularios |
| `human-resources` | Activo | Administración de empleados |
| `inventory` | En desarrollo | Seguimiento de inventarios |
| `invoicing` | En desarrollo | Emisión de facturas |
| `kpis` | En desarrollo | Tablero de indicadores clave |
| `laundry` | En desarrollo | Control de lavandería |
| `maintenance` | En desarrollo | Programación de mantenimiento |
| `minutes` | En desarrollo | Actas y minutas |
| `petty-cash` | En desarrollo | Manejo de caja chica |
| `pos` | En desarrollo | Punto de venta |
| `processes-tasks` | En desarrollo | Flujos de procesos y tareas |
| `properties` | En desarrollo | Gestión de propiedades |
| `sales-agent` | En desarrollo | Seguimiento de agentes de venta |
| `settings` | En desarrollo | Configuración del negocio |
| `template-module` | Experimental | Plantilla base para nuevos módulos |
| `training` | En desarrollo | Gestión de capacitaciones |
| `transportation` | En desarrollo | Control de transporte |
| `vehicles` | En desarrollo | Registro de vehículos |

### Características de Módulos
- 📊 **KPIs dinámicos** (Chart.js)
- ☑️ **Sumatorias con checkboxes**
- 🔍 **Filtros rápidos**
- 🖼️ **Carrusel de fotos**
- 📋 **Columnas ordenables/ocultables**
- 🔧 **Botones**: editar, duplicar, eliminar, PDF

---

## 🔐 SISTEMA DE PERMISOS

### Validación por Rol y Empresa
```php
// Verificar permiso específico
if (!hasPermission('gastos.view')) {
    exit('Access denied');
}

// Verificar rol en empresa actual
if (!checkRole(['admin', 'superadmin'])) {
    redirect('companies/');
}
```

### Permisos Granulares (Admin Panel)
- ✅ **Por Usuario**: Asignación individual de permisos
- ✅ **Por Módulo**: Control de ver, crear, editar, eliminar
- ✅ **Plantillas de Rol**: Aplicación automática según rol
- ✅ **Matriz Visual**: Interfaz para gestión masiva
- ✅ **Auditoría**: Log de cambios en permisos

### Archivo Central
📍 Permisos centralizados en `admin/permissions_manager.php`

---

## 🏗️ GESTIÓN DE PLANES SAAS

### Panel Root (`panel_root/`)
Solo usuarios con rol `root` pueden:
- 📊 **Crear/Editar Planes**: Free, Starter, Pro, Enterprise
- 🏢 **Gestionar Empresas**: Asignar planes y límites
- 📈 **Ver Estadísticas**: Uso y límites por empresa
- ⚠️ **Controlar Acceso**: Suspender o forzar upgrades

### Planes Predefinidos
| Plan | Empresas | Usuarios | Módulos | Precio |
|------|----------|----------|---------|--------|
| **Free** | 1 | 3 | 2 | $0 |
| **Starter** | 2 | 10 | 5 | $25 |
| **Pro** | 5 | 25 | 8 | $75 |
| **Enterprise** | ∞ | ∞ | Todos | Custom |

📥 **Detalles**: [`panel_root/README.md`](../panel_root/README.md)

---

## 👥 GESTIÓN DE USUARIOS Y ROLES

### Sistema de Invitaciones
Los `superadmin` pueden:
- 📧 **Invitar usuarios** por correo electrónico
- 🎭 **Asignar roles** por empresa, unidad o negocio
- 🔑 **Controlar acceso** por módulos y acciones
- 👥 **Gestionar multi-empresa**: Un usuario, múltiples roles

### Casos de Uso Multi-Empresa
- **Freelancer**: Múltiples clientes con roles diferentes
- **Empleado Multi-Sucursal**: Acceso a varias ubicaciones
- **Consultor**: Permisos específicos por proyecto
- **Subcontratista**: Acceso temporal a empresas

📥 **Detalles**: [`admin/README.md`](../admin/README.md)

---

## 🌍 INTERNACIONALIZACIÓN (i18n)

### Sistema Multiidioma
```php
// Carpeta /lang/
$lang['login'] = 'Iniciar sesión';
$lang['logout'] = 'Cerrar sesión';
$lang['welcome'] = 'Bienvenido';
```

- 🇪🇸 **Español** (es.php) como base
- 🇺🇸 **Inglés** estructuras preparadas
- 🔧 **Variables** en inglés para desarrollo

---

## 📁 ORGANIZACIÓN DE ARCHIVOS

### Componentes Reutilizables
| Carpeta | Uso |
|---------|-----|
| `/includes/` | Controladores globales |
| `/utils/` | Funciones comunes (auth, slugify, etc.) |
| `/components/` | Formularios, tablas, modales |

### Uploads y Almacenamiento
```
/uploads/[modulo]/[YYYY]/[MM]/archivo.ext
```

---

## 🧪 ESTADO ACTUAL DEL PROYECTO

### ✅ Completado
- 🏗️ **Arquitectura base** funcional
- 🎨 **UI/UX** con Bootstrap 5.3
- 👥 **Sistema multi-empresa** implementado
- 🔐 **Permisos granulares** operativos
- 📧 **Sistema de invitaciones** para usuarios nuevos/existentes
- 👑 **Panel Root** con gestión de planes SaaS
- 📦 **Primer módulo migrado**: Gastos (desde indice-produccion)

### 🔜 En Desarrollo
- 🧩 **Migración de módulos** adicionales
- 🌍 **Sistema i18n** completo
- 📱 **PWA** (Progressive Web App)
- 🔔 **Sistema de notificaciones**

### 🧪 Preparado Para
- ⚙️ **Codex y Copilot** integrados
- 🌍 **Internacionalización**
- 📊 **Analytics** y métricas
- 🔗 **APIs** externas

---

## 📚 Documentación Adicional

| Archivo | Descripción |
|---------|-------------|
| [Estructura de Base de Datos](#estructura-de-base-de-datos) | Estructura SQL completa |
| [Características SaaS](#caracteristicas-saas) | Detalles técnicos del sistema |
| [Gestión de Planes SaaS](#gestion-de-planes-saas) | Gestión de planes SaaS |
| [`AGENTS.md`](../AGENTS.md) | Módulos, rutas y permisos |
| [`admin/README.md`](../admin/README.md) | Panel de administración |
| [`panel_root/README.md`](../panel_root/README.md) | Panel maestro root |

---

## 🚀 Desarrollo y Contribución

### Tecnologías
- **Backend**: PHP 7.4+ nativo, MySQL
- **Frontend**: Bootstrap 5.3, Font Awesome 6, JavaScript Vanilla
- **Arquitectura**: MVC modular, API REST
- **Seguridad**: PDO, sesiones seguras, validación de permisos

### Próximos Módulos
1. **Mantenimiento** - Control de servicios técnicos
2. **Servicio al Cliente** - Gestión de tickets
3. **Inventario** - Control de stock
4. **Ventas** - Facturación y comercial

---

**🎯 Objetivo**: Convertir Indice en la plataforma SaaS líder para gestión empresarial modular, escalable desde startups hasta networks corporativos.

*Desarrollado con ❤️ para la gestión empresarial del futuro.*

## Estructura de Base de Datos

## ENTIDADES PRINCIPALES

### usuarios
- id
- nombre
- email
- password
- activo
- fecha_creacion

### empresas
- id
- nombre
- slug
- creada_por (usuario_id)

### unidades
- id
- nombre
- empresa_id

### negocios
- id
- nombre
- unidad_id

### usuarios_x_empresa
- id
- usuario_id
- empresa_id
- rol

### usuarios_x_unidad
- id
- usuario_id
- unidad_id
- rol

### usuarios_x_negocio
- id
- usuario_id
- negocio_id
- rol

---

## MÓDULOS Y PERMISOS

### permisos
- id
- clave (ej. gastos.ver)
- descripcion

### roles_permisos
- id
- rol (ej. superadmin)
- permiso_id

---

## FORMULARIOS Y ARCHIVOS

### gastos
- id
- concepto
- monto
- unidad_id
- negocio_id
- fecha
- estatus
- usuario_id
- adjuntos (json)

---

## 📝 CONVENCIONES

- Todas las claves foráneas en inglés.
- Los nombres de las columnas y tablas en inglés.
- Los comentarios del sistema estarán traducidos para uso en español (vía lang).

CREATE TABLE invitaciones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255),
  empresa_id INT,
  unidad_id INT DEFAULT NULL,
  negocio_id INT DEFAULT NULL,
  rol VARCHAR(50),
  token VARCHAR(64),
  status ENUM('pendiente', 'aceptada', 'expirada') DEFAULT 'pendiente',
  fecha_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

## Gestión de Planes SaaS
🎯 Objetivo
Establecer las reglas, estructura y funciones que permiten al usuario root controlar la monetización y escalabilidad de la plataforma, a través de planes SaaS con límites definidos por usuarios, módulos, unidades y almacenamiento.

✅ ¿Quién puede gestionar los planes?
El usuario con rol root (desde /panel_root/) es el único que puede:

Crear, editar o eliminar planes

Asignar o cambiar planes a empresas

Ver estadísticas y límites superados

Forzar upgrades o suspender planes


🧩 Estructura de un plan
Los planes se almacenan en la tabla plans con los siguientes campos clave:

| Campo              | Descripción                                          |
| ------------------ | ---------------------------------------------------- |
| `id`               | ID único del plan                                    |
| `name`             | Nombre del plan (ej. Free, Starter, Pro)             |
| `description`      | Descripción del plan                                 |
| `price_monthly`    | Precio mensual                                       |
| `modules_included` | JSON con IDs de módulos habilitados                  |
| `users_max`        | Máximo de usuarios permitidos                        |
| `companies_max`    | (opcional) Número de empresas si aplica multitenancy |
| `units_max`        | Máximo de unidades por empresa                       |
| `businesses_max`   | Máximo de negocios por unidad                        |
| `storage_max_mb`   | Límite de almacenamiento en MB                       |
| `is_active`        | true / false (plan habilitado)                       |


📊 Planes predefinidos sugeridos
Plan	Empresas	Unidades	Negocios	Usuarios	Módulos	Precio
Free	1	1	1	3	2	$0
Starter	2	5	10	10	5	$25 USD
Pro	5	10	25	25	8	$75 USD
Enterprise	Ilimitado	Ilimitado	Ilimitado	Ilimitado	Todos	A medida

🛠️ Panel Root: estructura sugerida
Ubicación: /panel_root/

/panel_root/
├── index.php           # Dashboard general
├── plans.php           # Vista y control de planes
├── companies.php       # Empresas registradas
├── modules.php         # Módulos disponibles del sistema
├── controller.php      # Acciones centralizadas (AJAX)
└── js/
    └── root_panel.js   # Interacciones JS del panel

🔄 Comportamiento esperado
El sistema debe validar los límites del plan activo antes de permitir:

Crear nuevas unidades

Agregar más usuarios

Subir archivos (verificar storage_max_mb)

Activar módulos fuera del plan

🔁 Si el límite se alcanza:

// Mensaje ejemplo
"Tu plan actual no permite agregar más usuarios. Mejora tu plan para continuar."
🔐 Validación en backend
Se recomienda crear una clase o helper en:
/lib/plan_limiter.php

Con funciones como:
function checkLimit($type, $currentValue, $maxAllowed);
function getCurrentUsage($company_id);
function planAllowsModule($company_id, $module_id);

🧪 Flujo típico de upgrade
Desde /panel_admin/planes.php (visible al superadmin):

Se muestra el plan actual

Se comparan límites y características

Se habilita un botón "Mejorar Plan"

Opcional: integración con Stripe / PayPal / Mercado Pago / 

🧾 Notas adicionales
El plan Free es clave como onboarding gratuito

El sistema no debe bloquear el uso si expira un plan, sino mostrar alertas y limitar nuevas acciones

Los upgrades deben aplicarse en tiempo real

Toda empresa (tabla companies) debe tener un campo plan_id


## Estado del Módulo de Gastos

## 🎯 RESUMEN EJECUTIVO

El módulo de **Gastos** está **COMPLETAMENTE IMPLEMENTADO** y funcional dentro del sistema SaaS. Se han migrado exitosamente todas las funcionalidades del sistema original (`indice-produccion`) con mejoras significativas en arquitectura, permisos y funcionalidades.

---

## ✅ FUNCIONALIDADES COMPLETADAS

### 🏗️ **1. Base de Datos y Estructura**
- ✅ **5 tablas creadas** y operativas:
  - `providers` - Gestión de proveedores por empresa
  - `expenses` - Gastos principales con folio auto-generado
  - `expense_payments` - Historial de pagos por gasto
  - `credit_notes` - Notas de crédito
  - `credit_note_payments` - Pagos de notas de crédito

- ✅ **Triggers implementados**:
  - `generate_expense_folio` - Auto-genera folios únicos
  - `generate_credit_note_folio` - Auto-genera folios de notas de crédito

- ✅ **11 permisos granulares** configurados para el módulo

### 🔐 **2. Sistema de Permisos**
- ✅ **Control granular por roles**:
  - **👑 Admin**: Acceso completo (view, create, edit, pay, export, kpis, delete)
  - **👤 Moderator**: Operaciones básicas (view, create, pay, providers.create)  
  - **👁️ User**: Solo lectura (view gastos y proveedores)
  - **🔧 Root/SuperAdmin**: Acceso total sin restricciones

- ✅ **Función `hasPermission()`** implementada y probada
- ✅ **Herramienta de debug** (`debug_permissions.php`) para diagnóstico

### 📋 **3. CRUD Completo de Gastos**
- ✅ **Crear gastos** individuales y desde órdenes
- ✅ **Editar gastos** existentes con validación
- ✅ **Eliminar gastos** (individual y múltiple)
- ✅ **Sistema de folios** automáticos únicos
- ✅ **Filtros avanzados** por proveedor, fechas, estatus, origen
- ✅ **Ordenamiento** por cualquier columna
- ✅ **Paginación** y búsqueda en tiempo real

### 💰 **4. Sistema de Pagos/Abonos**
- ✅ **Pagos parciales** con comprobantes
- ✅ **Múltiples archivos** por pago
- ✅ **Cálculo automático** de saldos
- ✅ **Actualización automática** de estatus
- ✅ **Historial completo** de pagos

### 🏢 **5. Gestión de Proveedores**
- ✅ **CRUD completo** de proveedores
- ✅ **Integración con Select2** para búsqueda rápida
- ✅ **Validación de datos** (RFC, email, teléfono)
- ✅ **Filtros y búsqueda** avanzada

### 📊 **6. Dashboard de KPIs**
- ✅ **7 métricas clave** implementadas:
  - Total gastado este mes
  - Total gastado este año
  - Gastos pendientes de pago
  - Promedio mensual
  - Distribución por status
  - Top 5 proveedores
  - Gastos por tipo
- ✅ **Modal profesional** con visualización clara
- ✅ **Actualización en tiempo real**

### 📄 **7. Generación de Documentos**
- ✅ **PDF individual** por gasto con formato profesional
- ✅ **Exportación CSV** de listados completos
- ✅ **Plantillas HTML** optimizadas para impresión
- ✅ **Validación de permisos** en todas las exportaciones

### 🔄 **8. Órdenes Recurrentes**
- ✅ **Creación automática** de gastos periódicos
- ✅ **Configuración flexible** de periodicidad
- ✅ **Previsualización** de fechas futuras
- ✅ **Herramienta de pruebas** (`test_recurring_orders.php`)

### 🎨 **9. Interfaz y UX**
- ✅ **Diseño responsivo** adaptado al sistema SaaS
- ✅ **Colores y botones** consistentes con la plantilla base
- ✅ **Modales dinámicos** para todas las operaciones
- ✅ **Alertas y notificaciones** informativas
- ✅ **Tablas interactivas** con filtros en tiempo real

---

## 🗂️ ARCHIVOS PRINCIPALES

### **Core del Módulo**
- `../modules/expenses/index.php` - Vista principal completa
- `../modules/expenses/controller.php` - Controlador con todas las operaciones
- `../modules/expenses/config.php` - Configuración del módulo

### **Estilos y Scripts**
- `../modules/expenses/css/expenses.css` - Estilos específicos
- `../modules/expenses/js/expenses-debug.js` - JavaScript principal

### **Herramientas y Debug**
- `../modules/expenses/debug_permissions.php` - Diagnóstico de permisos
- `../modules/expenses/test_recurring_orders.php` - Pruebas de órdenes recurrentes

### **Documentación**
- `../modules/expenses/README.md` - Documentación técnica completa
- `../modules/expenses/IMPLEMENTACIONES_COMPLETADAS.md` - Log de desarrollos

---

## 🛠️ STACK TECNOLÓGICO

- **Backend**: PHP 8.0+ con PDO
- **Frontend**: HTML5, CSS3, JavaScript ES6+
- **Base de Datos**: MySQL 8.0 con triggers y procedimientos
- **Librerías**: 
  - Select2 para autocomplete
  - SweetAlert2 para notificaciones
  - Bootstrap 5 para componentes
- **Exportación**: HTML2PDF, CSV nativo

---

## ⚠️ PENDIENTES MENORES

### 🔧 **Optimizaciones Futuras** (No críticas)
1. **Integración con contabilidad** - Conectar con módulo de contabilidad
2. **Reportes avanzados** - Gráficas y análisis temporal
3. **Aprobaciones multinivel** - Flujo de aprobación de gastos grandes
4. **Integración fiscal** - Conexión con SAT/facturación
5. **App móvil** - Captura de gastos desde móvil

### 📈 **Mejoras de Performance** (Opcionales)
1. **Cache de proveedores** - Redis para búsquedas frecuentes
2. **Índices adicionales** - Optimización de consultas complejas
3. **Paginación server-side** - Para empresas con +10K gastos

---

## 🎯 CONCLUSIÓN

**El módulo de Gastos está 100% funcional y listo para producción.**

✨ **Funcionalidades clave**: CRUD completo, pagos, KPIs, exportaciones, permisos granulares
🛡️ **Seguridad**: Sistema de permisos robusto y validado
🎨 **UX**: Interfaz moderna y responsiva
📊 **Reporting**: KPIs y exportaciones completas
🔧 **Mantenibilidad**: Código limpio, documentado y modular

---

## 🚀 SIGUIENTE PASO: MÓDULO HUMAN RESOURCES

Con la base sólida del módulo de **Gastos**, procederemos a crear el módulo de **Recursos Humanos** (`human-resources`) utilizando la misma arquitectura, patrones de diseño y componentes UI ya probados.

**Template a replicar**: Estructura, botones, colores, tabla, filtros y modales del módulo `expenses`.

---

**📅 Estado actualizado**: 7 de agosto de 2025  
**👨‍💻 Desarrollado por**: GitHub Copilot + Equipo Indice SaaS

## Características SaaS

Sistema SaaS modular desarrollado en PHP nativo + Bootstrap para la gestión de múltiples empresas, unidades de negocio y módulos funcionales.

## 🚀 Características Principales

- **Multi-empresa**: Gestión de múltiples empresas por usuario
- **Estructura jerárquica**: Empresas → Unidades → Negocios → Módulos
- **Sistema de roles**: root, support, superadmin, admin, moderator, user
- **Módulos intercambiables**: Sistema preparado para módulos como gastos, mantenimiento, etc.
- **Responsive**: Bootstrap 5 + Font Awesome
- **Seguridad**: PDO, sesiones seguras, validación de permisos

## 📁 Estructura del Proyecto

```
indice_saas/
├── config.php              # Configuración principal
├── index.php               # Punto de entrada
├── install_database.php    # Script de instalación de BD
├── lang/
│   └── es.php              # Archivo de idioma español
├── auth/                   # Sistema de autenticación
│   ├── index.php          # Login
│   ├── register.php       # Registro
│   └── logout.php         # Cerrar sesión
├── companies/             # Gestión de empresas
│   ├── index.php          # Lista de empresas
│   ├── controller.php     # API REST para empresas
│   ├── style.css          # Estilos
│   └── js/
│       └── companies.js   # JavaScript
├── units/                 # Gestión de unidades
│   ├── index.php          # Lista de unidades
│   ├── controller.php     # API REST para unidades
│   ├── style.css          # Estilos
│   └── js/
│       └── units.js       # JavaScript
├── businesses/            # Gestión de negocios
│   ├── index.php          # Lista de negocios
│   ├── controller.php     # API REST para negocios
│   ├── style.css          # Estilos
│   └── js/
│       └── businesses.js  # JavaScript
└── modules/               # Hub de módulos
    ├── index.php          # Lista de módulos disponibles
    ├── style.css          # Estilos
    └── js/
        └── modules.js     # JavaScript
```

## ⚙️ Instalación

### 1. Requisitos del Sistema
- PHP 7.4 o superior
- MySQL 5.7 o superior
- Servidor web (Apache/Nginx)
- Extensiones PHP: PDO, PDO_MySQL

### 2. Configuración de Base de Datos
1. Crea una base de datos MySQL:
   ```sql
   CREATE DATABASE indice_saas;
   ```

2. Configura la conexión en `config.php`:
   ```php
   define('DB_HOST', 'localhost');
   define('DB_NAME', 'indice_saas');
   define('DB_USER', 'tu_usuario');
   define('DB_PASS', 'tu_password');
   ```

### 3. Instalación de Tablas
Ejecuta el script de instalación:
```bash
php install_database.php
```

Este script creará todas las tablas necesarias e insertará datos iniciales.

### 4. Credenciales Iniciales
- **Email**: admin@indiceapp.com
- **Password**: admin123

⚠️ **IMPORTANTE**: Cambia estas credenciales inmediatamente en producción.

## 🔐 Sistema de Roles y Permisos

### Jerarquía de Roles
1. **root** - Acceso total al sistema
2. **support** - Soporte técnico
3. **superadmin** - Administrador completo de empresa
4. **admin** - Administrador de empresa
5. **moderator** - Moderador con permisos limitados
6. **user** - Usuario básico (solo lectura)

### Variables de Sesión
```php
$_SESSION['user_id']      // ID del usuario
$_SESSION['company_id']   // Empresa actual
$_SESSION['unit_id']      // Unidad actual
$_SESSION['business_id']  // Negocio actual
$_SESSION['current_role'] // Rol actual del usuario
```

## 🏗️ Arquitectura del Sistema

### 1. Estructura Jerárquica
```
👤 Usuario
└── 🏢 Empresa (puede tener múltiples)
    └── 🏭 Unidad de Negocio
        └── 🏪 Negocio
            └── 📦 Módulos Funcionales
```

### API REST
Cada módulo incluye un controlador con endpoints REST:
- `POST` - Crear registro
- `GET` - Listar/obtener registros
- `PUT` - Actualizar registro
- `DELETE` - Eliminar registro

## 🎨 Interfaz de Usuario

### Tecnologías Frontend
- **Bootstrap 5.3** - Framework CSS
- **Font Awesome 6** - Iconografía
- **JavaScript Vanilla** - Interactividad
- **CSS3** - Estilos personalizados

### Características de UX
- Diseño responsive para móviles y escritorio
- Navegación breadcrumb intuitiva
- Alertas dinámicas con auto-dismiss
- Estados de carga y confirmaciones
- Modo claro/oscuro (futuro)

## 🔄 Flujo de Trabajo Típico

1. **Login** → Usuario se autentica
2. **Empresas** → Selecciona o crea empresa
3. **Unidades** → Navega a unidades de la empresa
4. **Negocios** → Accede a negocios específicos
5. **Módulos** → Utiliza módulos funcionales (gastos, etc.)

## 🛠️ Desarrollo de Nuevos Módulos

### 1. Estructura Mínima
Cada módulo debe tener:
```
modulo/
├── index.php          # Vista principal
├── controller.php     # API REST
├── style.css          # Estilos específicos
└── js/
    └── modulo.js      # JavaScript del módulo
```

### 2. Plantilla Base
```php
<?php
require_once '../config.php';

// Verificar autenticación
if (!checkAuth()) {
    redirect('auth/');
}

// Verificar permisos
if (!checkRole(['admin', 'superadmin', 'root'])) {
    redirect('companies/');
}

// Tu código aquí...
?>
```

### 3. Registro en Sistema
Agregar el módulo en `/modules/index.php`:
```php
[
    'id' => 'nuevo_modulo',
    'name' => 'Nuevo Módulo',
    'description' => 'Descripción del módulo',
    'icon' => 'fas fa-icon',
    'color' => 'primary',
    'url' => 'nuevo_modulo/',
    'active' => true
]
```

## 🚨 Consideraciones de Seguridad

- ✅ Contraseñas hasheadas con `password_hash()`
- ✅ Consultas preparadas PDO contra SQL injection
- ✅ Validación de permisos por rol y contexto
- ✅ Sesiones seguras con regeneración de ID
- ✅ Escape de datos en vistas con `htmlspecialchars()`
- ✅ Validación de entrada en formularios
- ✅ Headers de seguridad (futuro)
- ✅ CSRF tokens (futuro)

## 📱 Compatibilidad

- ✅ Chrome 90+
- ✅ Firefox 88+
- ✅ Safari 14+
- ✅ Edge 90+
- ✅ Dispositivos móviles iOS/Android

## 🔮 Roadmap

### Versión 1.1
- [ ] Módulo de Mantenimiento completo
- [ ] Módulo de Servicio al Cliente
- [ ] Sistema de notificaciones
- [ ] API keys para integraciones

### Versión 1.2
- [ ] Módulo de Inventario
- [ ] Módulo de Ventas
- [ ] Dashboard con métricas
- [ ] Exportaciones avanzadas

### Versión 2.0
- [ ] Modo multi-idioma
- [ ] Tema oscuro/claro
- [ ] PWA (Progressive Web App)
- [ ] Integración con WhatsApp/Telegram

## 🤝 Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -am 'Agrega nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Abre un Pull Request

## 📞 Soporte

- **Documentación**: Este README
- **Issues**: GitHub Issues
- **Email**: soporte@indiceapp.com

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

---

Desarrollado con ❤️ para la gestión empresarial moderna.
