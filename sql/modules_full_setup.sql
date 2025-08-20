-- Estructura completa y datos iniciales para la tabla modules
DROP TABLE IF EXISTS modules;

CREATE TABLE modules (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  slug VARCHAR(100) NOT NULL,
  description TEXT NOT NULL,
  icon VARCHAR(50) NOT NULL,
  color VARCHAR(20) NOT NULL,
  url VARCHAR(255) NOT NULL,
  status VARCHAR(20) DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO modules (id, name, slug, description, icon, color, url, status, created_at, updated_at) VALUES
(1, 'Dashboard', 'dashboard', 'Panel principal con estadísticas', 'fas fa-tachometer-alt', '#3498db', '/dashboard', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(2, 'Gestión de Usuarios', 'users', 'Administración de usuarios del sistema', 'fas fa-users', '#2ecc71', '/users', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(3, 'Gestión de Empresas', 'companies', 'Administración de empresas clientes', 'fas fa-building', '#e74c3c', '/companies', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(4, 'Facturación', 'billing', 'Sistema de facturación y pagos', 'fas fa-file-invoice-dollar', '#f39c12', '/billing', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(5, 'Reportes', 'reports', 'Generación de reportes y análisis', 'fas fa-chart-line', '#9b59b6', '/reports', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(6, 'Configuración', 'settings', 'Configuraciones del sistema', 'fas fa-cog', '#34495e', '/settings', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(7, 'Soporte', 'support', 'Sistema de tickets de soporte', 'fas fa-life-ring', '#1abc9c', '/support', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(8, 'API', 'api', 'Gestión de API y integraciones', 'fas fa-code', '#e67e22', '/api', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(9, 'Gastos', 'expenses', 'Gestión completa de gastos y proveedores empresariales', 'fas fa-coins', '#e74c3c', '/modules/expenses/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(10, 'Recursos Humanos', 'human-resources', 'Gestión completa de empleados, departamentos y posiciones', 'fas fa-users', '#3498db', '/modules/human-resources/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(11, 'Índice Agente de Ventas (IA)', 'ai-sales-agent', 'Asistente de ventas impulsado por IA para optimizar el proceso de ventas', 'fas fa-robot', 'primary', '/modules/ai-sales-agent/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(12, 'Índice Analítica (IA)', 'ai-analytics', 'Análisis avanzado de datos con inteligencia artificial', 'fas fa-brain', 'info', '/modules/ai-analytics/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(13, 'Inventario', 'inventory', 'Gestión de productos y stock', 'fas fa-boxes', '#2ecc71', '/modules/inventory/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(14, 'Formularios', 'forms', 'Creación y gestión de formularios', 'fas fa-file-alt', '#3498db', '/modules/forms/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(15, 'Capacitación', 'training', 'Gestión de cursos y empleados asignados', 'fas fa-chalkboard-teacher', '#f39c12', '/modules/training/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(16, 'Vehículos', 'vehicles', 'Registro y control de vehículos', 'fas fa-car', '#e67e22', '/modules/vehicles/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(17, 'Inmuebles', 'properties', 'Registro y gestión de inmuebles', 'fas fa-home', '#9b59b6', '/modules/properties/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(18, 'Limpieza', 'cleaning', 'Asignación de rutinas de limpieza', 'fas fa-broom', '#1abc9c', '/modules/cleaning/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(19, 'Lavandería', 'laundry', 'Registro de cargas de lavandería', 'fas fa-tshirt', '#e74c3c', '/modules/laundry/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(20, 'Transporte', 'transportation', 'Programación de traslados', 'fas fa-bus', '#34495e', '/modules/transportation/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(21, 'Chat', 'chat', 'Comunicación interna y conversaciones', 'fas fa-comments', '#3498db', '/modules/chat/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(22, 'Facturación', 'invoicing', 'Emisión y gestión de facturas', 'fas fa-file-invoice', '#f39c12', '/modules/invoicing/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(23, 'Analítica', 'analytics', 'Generación de escenarios y KPIs', 'fas fa-chart-bar', '#9b59b6', '/modules/analytics/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(24, 'Punto de Venta', 'pos', 'Registro de ventas y cobros', 'fas fa-cash-register', '#2ecc71', '/modules/pos/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(25, 'CRM', 'crm', 'Gestión de clientes y etapas', 'fas fa-user-tie', '#e67e22', '/modules/crm/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(26, 'Caja Chica', 'petty-cash', 'Solicitudes y control de fondos', 'fas fa-wallet', '#e74c3c', '/modules/petty-cash/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(27, 'Configuración', 'settings', 'Edición de empresa y módulos', 'fas fa-cogs', '#34495e', '/modules/settings/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(28, 'KPIs', 'kpis', 'Visualización de indicadores clave', 'fas fa-bullseye', '#3498db', '/modules/kpis/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(29, 'Agente de Ventas', 'sales-agent', 'Recomendaciones IA para ventas', 'fas fa-robot', '#f39c12', '/modules/sales-agent/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22'),
(30, 'Mantenimiento', 'maintenance', 'Gestión y cierre de servicios', 'fas fa-tools', '#2ecc71', '/modules/maintenance/', 'active', '2025-08-18 12:12:22', '2025-08-18 12:12:22');
