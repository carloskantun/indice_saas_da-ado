-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 20-08-2025 a las 14:35:49
-- Versión del servidor: 5.7.23-23
-- Versión de PHP: 8.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `corazon_indicesaas`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `businesses`
--

CREATE TABLE `businesses` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `type_id` int(11) DEFAULT NULL,
  `unit_id` int(11) NOT NULL,
  `status` enum('active','inactive') COLLATE utf8_unicode_ci DEFAULT 'active',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `business_types`
--

CREATE TABLE `business_types` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `companies`
--

CREATE TABLE `companies` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `status` enum('active','inactive') COLLATE utf8_unicode_ci DEFAULT 'active',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `plan_id` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `credit_notes`
--

CREATE TABLE `credit_notes` (
  `id` int(10) UNSIGNED NOT NULL,
  `folio` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_id` int(10) UNSIGNED NOT NULL,
  `unit_id` int(10) UNSIGNED NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `note_date` date NOT NULL,
  `concept` text COLLATE utf8mb4_unicode_ci,
  `status` enum('Disponible','Aplicada','Vencida') COLLATE utf8mb4_unicode_ci DEFAULT 'Disponible',
  `responsible_user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Disparadores `credit_notes`
--
DELIMITER $$
CREATE TRIGGER `generate_credit_note_folio` BEFORE INSERT ON `credit_notes` FOR EACH ROW BEGIN
    DECLARE next_num INT;
    
    IF NEW.folio IS NULL OR NEW.folio = '' THEN
        SELECT COALESCE(MAX(CAST(SUBSTRING(folio, 8) AS UNSIGNED)), 0) + 1 
        INTO next_num
        FROM credit_notes 
        WHERE folio LIKE CONCAT('NC-', YEAR(NOW()), '-%');
        
        SET NEW.folio = CONCAT('NC-', YEAR(NOW()), '-', LPAD(next_num, 6, '0'));
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `credit_note_payments`
--

CREATE TABLE `credit_note_payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `credit_note_id` int(10) UNSIGNED NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_date` date NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `receipt_file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `manager_id` int(11) DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `company_id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `employee_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fiscal_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department_id` int(11) NOT NULL,
  `position_id` int(11) NOT NULL,
  `hire_date` date NOT NULL,
  `employment_type` enum('Tiempo_Completo','Medio_Tiempo','Temporal','Freelance','Practicante') COLLATE utf8mb4_unicode_ci DEFAULT 'Tiempo_Completo',
  `contract_type` enum('Indefinido','Temporal','Por_Obra','Practicas') COLLATE utf8mb4_unicode_ci DEFAULT 'Indefinido',
  `salary` decimal(10,2) DEFAULT '0.00',
  `salary_frequency` enum('Semanal','Quincenal','Mensual') COLLATE utf8mb4_unicode_ci DEFAULT 'Mensual',
  `payment_frequency` enum('Semanal','Quincenal','Mensual') COLLATE utf8mb4_unicode_ci DEFAULT 'Mensual',
  `status` enum('Activo','Inactivo','Vacaciones','Licencia','Baja') COLLATE utf8mb4_unicode_ci DEFAULT 'Activo',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Disparadores `employees`
--
DELIMITER $$
CREATE TRIGGER `generate_employee_number` BEFORE INSERT ON `employees` FOR EACH ROW BEGIN
                IF NEW.employee_number IS NULL OR NEW.employee_number = '' THEN
                    SET NEW.employee_number = CONCAT('EMP', LPAD((
                        SELECT COALESCE(MAX(CAST(SUBSTRING(employee_number, 4) AS UNSIGNED)), 0) + 1 
                        FROM employees 
                        WHERE company_id = NEW.company_id 
                        AND employee_number REGEXP '^EMP[0-9]+$'
                    ), 4, '0'));
                END IF;
            END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `expenses`
--

CREATE TABLE `expenses` (
  `id` int(10) UNSIGNED NOT NULL,
  `folio` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_id` int(10) UNSIGNED NOT NULL,
  `unit_id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `provider_id` int(10) UNSIGNED DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_date` date NOT NULL,
  `expense_type` enum('Recurrente','Unico') COLLATE utf8mb4_unicode_ci DEFAULT 'Unico',
  `purchase_type` enum('Venta','Administrativa','Operativo','Impuestos','Intereses/Créditos') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method` enum('Tarjeta','Transferencia','Efectivo') COLLATE utf8mb4_unicode_ci DEFAULT 'Transferencia',
  `bank_account` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Pagado','Pago parcial','Vencido','Por pagar','Cancelado') COLLATE utf8mb4_unicode_ci DEFAULT 'Por pagar',
  `recurring_days` int(11) DEFAULT NULL,
  `next_recurring` date DEFAULT NULL,
  `concept` text COLLATE utf8mb4_unicode_ci,
  `order_folio` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `origin` enum('Directo','Orden') COLLATE utf8mb4_unicode_ci DEFAULT 'Directo',
  `origin_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note_credit_id` int(10) UNSIGNED DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Disparadores `expenses`
--
DELIMITER $$
CREATE TRIGGER `generate_expense_folio` BEFORE INSERT ON `expenses` FOR EACH ROW BEGIN
    DECLARE next_num INT;
    
    IF NEW.folio IS NULL OR NEW.folio = '' THEN
        SELECT COALESCE(MAX(CAST(SUBSTRING(folio, 9) AS UNSIGNED)), 0) + 1 
        INTO next_num
        FROM expenses 
        WHERE folio LIKE CONCAT('EXP-', YEAR(NOW()), '-%');
        
        SET NEW.folio = CONCAT('EXP-', YEAR(NOW()), '-', LPAD(next_num, 6, '0'));
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `expense_payments`
--

CREATE TABLE `expense_payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `expense_id` int(10) UNSIGNED NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_date` date NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `receipt_file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `invitations`
--

CREATE TABLE `invitations` (
  `id` int(11) NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `company_id` int(11) NOT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `business_id` int(11) DEFAULT NULL,
  `role` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'user',
  `token` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('pending','accepted','expired') COLLATE utf8_unicode_ci DEFAULT 'pending',
  `sent_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expiration_date` timestamp NULL DEFAULT NULL,
  `sent_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modules`
--

CREATE TABLE `modules` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `icon` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'fas fa-puzzle-piece',
  `color` varchar(7) COLLATE utf8_unicode_ci DEFAULT '#3498db',
  `url` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8_unicode_ci DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `message` text COLLATE utf8_unicode_ci,
  `data` json DEFAULT NULL,
  `status` enum('pending','unread','read','completed') COLLATE utf8_unicode_ci DEFAULT 'unread',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `action_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permissions`
--

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `key_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `module` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plans`
--

CREATE TABLE `plans` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `price_monthly` decimal(10,2) NOT NULL DEFAULT '0.00',
  `modules_included` json DEFAULT NULL,
  `users_max` int(11) NOT NULL DEFAULT '1',
  `units_max` int(11) NOT NULL DEFAULT '1',
  `businesses_max` int(11) NOT NULL DEFAULT '1',
  `storage_max_mb` int(11) NOT NULL DEFAULT '100',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `monthly_price` decimal(10,2) DEFAULT '0.00',
  `annual_price` decimal(10,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plan_modules`
--

CREATE TABLE `plan_modules` (
  `id` int(11) NOT NULL,
  `plan_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `positions`
--

CREATE TABLE `positions` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `status` enum('active','inactive') COLLATE utf8_unicode_ci DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `providers`
--

CREATE TABLE `providers` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `status` enum('active','inactive') COLLATE utf8_unicode_ci DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `phone` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8_unicode_ci,
  `rfc` varchar(13) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `business_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `units`
--

CREATE TABLE `units` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `fiscal_id` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `bio` text,
  `timezone` varchar(50) DEFAULT NULL,
  `language` varchar(10) DEFAULT NULL,
  `notifications_email` tinyint(1) DEFAULT '1',
  `notifications_sms` tinyint(1) DEFAULT '0',
  `avatar` varchar(255) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `login_attempts` int(11) DEFAULT '0',
  `password` varchar(255) NOT NULL,
  `status` varchar(20) DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_businesses`
--

CREATE TABLE `user_businesses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `role` enum('admin','moderator','user') COLLATE utf8_unicode_ci DEFAULT 'user',
  `status` enum('active','inactive') COLLATE utf8_unicode_ci DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_companies`
--

CREATE TABLE `user_companies` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `role` enum('root','support','superadmin','admin','moderator','user') COLLATE utf8_unicode_ci DEFAULT 'user',
  `status` enum('active','inactive') COLLATE utf8_unicode_ci DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_accessed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `joined_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `business_id` int(11) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_invitations`
--

CREATE TABLE `user_invitations` (
  `id` int(11) NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_id` int(11) NOT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `business_id` int(11) DEFAULT NULL,
  `role` enum('superadmin','admin','moderator','user') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','accepted','expired','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `sent_by` int(11) NOT NULL,
  `sent_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expiration_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `accepted_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_module_permissions`
--

CREATE TABLE `user_module_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `module_slug` varchar(50) NOT NULL,
  `company_id` int(11) NOT NULL,
  `module_id` varchar(50) NOT NULL,
  `can_view` tinyint(1) DEFAULT '0',
  `can_create` tinyint(1) DEFAULT '0',
  `can_edit` tinyint(1) DEFAULT '0',
  `can_delete` tinyint(1) DEFAULT '0',
  `can_admin` tinyint(1) DEFAULT '0',
  `granted_by` int(11) NOT NULL,
  `granted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_roles`
--

CREATE TABLE `user_roles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `company_id` int(11) DEFAULT NULL,
  `business_id` int(11) DEFAULT NULL,
  `assigned_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_units`
--

CREATE TABLE `user_units` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `role` enum('admin','moderator','user') COLLATE utf8_unicode_ci DEFAULT 'user',
  `status` enum('active','inactive') COLLATE utf8_unicode_ci DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `workflow_templates`
--

CREATE TABLE `workflow_templates` (
  `template_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre de la plantilla',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT 'Descripción de la plantilla',
  `category` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Categoría de la plantilla',
  `department_id` int(11) DEFAULT NULL COMMENT 'Departamento específico (NULL = global)',
  `template_data` json DEFAULT NULL COMMENT 'Estructura del flujo en JSON',
  `is_active` tinyint(1) DEFAULT '1' COMMENT 'Si la plantilla está activa',
  `created_by` int(11) NOT NULL COMMENT 'Usuario creador',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `company_id` int(11) NOT NULL COMMENT 'Empresa (multi-tenant)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Plantillas de flujos de trabajo';

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `businesses`
--
ALTER TABLE `businesses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type_id` (`type_id`),
  ADD KEY `unit_id` (`unit_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indices de la tabla `business_types`
--
ALTER TABLE `business_types`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `companies`
--
ALTER TABLE `companies`
  ADD KEY `idx_companies_id` (`id`);

--
-- Indices de la tabla `modules`
--
ALTER TABLE `modules`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `positions`
--
ALTER TABLE `positions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `providers`
--
ALTER TABLE `providers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_providers_company_id` (`company_id`),
  ADD KEY `idx_providers_business_id` (`business_id`);

--
-- Indices de la tabla `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `user_companies`
--
ALTER TABLE `user_companies`
  ADD KEY `idx_user_companies_user_company` (`user_id`,`company_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `modules`
--
ALTER TABLE `modules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `positions`
--
ALTER TABLE `positions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `providers`
--
ALTER TABLE `providers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `units`
--
ALTER TABLE `units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- DATOS INICIALES PARA SISTEMA SAAS

-- Insertar empresa principal
INSERT INTO companies (id, name, description, status, created_by, created_at, updated_at, plan_id) VALUES
(1, 'IndiceApp', 'Empresa principal del sistema', 'active', 1, NOW(), NOW(), 1);

-- Insertar usuarios root y admin
INSERT INTO users (id, name, first_name, last_name, email, password, status, created_at, updated_at)
VALUES
(1, 'Root', 'Root', 'User', 'root@indiceapp.com', 'rootpassword', 'active', NOW(), NOW()),
(2, 'Admin', 'Admin', 'User', 'admin@indiceapp.com', 'adminpassword', 'active', NOW(), NOW());

-- Relacionar usuarios con la empresa
INSERT INTO user_companies (id, user_id, company_id, role, status, created_at, last_accessed, joined_at)
VALUES
(1, 1, 1, 'root', 'active', NOW(), NOW(), NOW()),
(2, 2, 1, 'admin', 'active', NOW(), NOW(), NOW());

-- Insertar módulos completos
INSERT INTO modules (id, name, slug, description, icon, color, url, status, created_at, updated_at) VALUES
(1, 'Dashboard', 'dashboard', 'Panel principal con estadísticas', 'fas fa-tachometer-alt', '#3498db', '/dashboard', 'active', NOW(), NOW()),
(2, 'Gestión de Usuarios', 'users', 'Administración de usuarios del sistema', 'fas fa-users', '#2ecc71', '/users', 'active', NOW(), NOW()),
(3, 'Gestión de Empresas', 'companies', 'Administración de empresas clientes', 'fas fa-building', '#e74c3c', '/companies', 'active', NOW(), NOW()),
(4, 'Facturación', 'billing', 'Sistema de facturación y pagos', 'fas fa-file-invoice-dollar', '#f39c12', '/billing', 'active', NOW(), NOW()),
(5, 'Reportes', 'reports', 'Generación de reportes y análisis', 'fas fa-chart-line', '#9b59b6', '/reports', 'active', NOW(), NOW()),
(6, 'Configuración', 'settings', 'Configuraciones del sistema', 'fas fa-cog', '#34495e', '/settings', 'active', NOW(), NOW()),
(7, 'Soporte', 'support', 'Sistema de tickets de soporte', 'fas fa-life-ring', '#1abc9c', '/support', 'active', NOW(), NOW()),
(8, 'API', 'api', 'Gestión de API y integraciones', 'fas fa-code', '#e67e22', '/api', 'active', NOW(), NOW()),
(9, 'Gastos', 'expenses', 'Gestión completa de gastos y proveedores empresariales', 'fas fa-coins', '#e74c3c', '/modules/expenses/', 'active', NOW(), NOW()),
(10, 'Recursos Humanos', 'human-resources', 'Gestión completa de empleados, departamentos y posiciones', 'fas fa-users', '#3498db', '/modules/human-resources/', 'active', NOW(), NOW()),
(11, 'Índice Agente de Ventas (IA)', 'ai-sales-agent', 'Asistente de ventas impulsado por IA para optimizar el proceso de ventas', 'fas fa-robot', 'primary', '/modules/ai-sales-agent/', 'active', NOW(), NOW()),
(12, 'Índice Analítica (IA)', 'ai-analytics', 'Análisis avanzado de datos con inteligencia artificial', 'fas fa-brain', 'info', '/modules/ai-analytics/', 'active', NOW(), NOW()),
(13, 'Inventario', 'inventory', 'Gestión de productos y stock', 'fas fa-boxes', '#2ecc71', '/modules/inventory/', 'active', NOW(), NOW()),
(14, 'Formularios', 'forms', 'Creación y gestión de formularios', 'fas fa-file-alt', '#3498db', '/modules/forms/', 'active', NOW(), NOW()),
(15, 'Capacitación', 'training', 'Gestión de cursos y empleados asignados', 'fas fa-chalkboard-teacher', '#f39c12', '/modules/training/', 'active', NOW(), NOW()),
(16, 'Vehículos', 'vehicles', 'Registro y control de vehículos', 'fas fa-car', '#e67e22', '/modules/vehicles/', 'active', NOW(), NOW()),
(17, 'Inmuebles', 'properties', 'Registro y gestión de inmuebles', 'fas fa-home', '#9b59b6', '/modules/properties/', 'active', NOW(), NOW()),
(18, 'Limpieza', 'cleaning', 'Asignación de rutinas de limpieza', 'fas fa-broom', '#1abc9c', '/modules/cleaning/', 'active', NOW(), NOW()),
(19, 'Lavandería', 'laundry', 'Registro de cargas de lavandería', 'fas fa-tshirt', '#e74c3c', '/modules/laundry/', 'active', NOW(), NOW()),
(20, 'Transporte', 'transportation', 'Programación de traslados', 'fas fa-bus', '#34495e', '/modules/transportation/', 'active', NOW(), NOW()),
(21, 'Chat', 'chat', 'Comunicación interna y conversaciones', 'fas fa-comments', '#3498db', '/modules/chat/', 'active', NOW(), NOW()),
(22, 'Facturación', 'invoicing', 'Emisión y gestión de facturas', 'fas fa-file-invoice', '#f39c12', '/modules/invoicing/', 'active', NOW(), NOW()),
(23, 'Analítica', 'analytics', 'Generación de escenarios y KPIs', 'fas fa-chart-bar', '#9b59b6', '/modules/analytics/', 'active', NOW(), NOW()),
(24, 'Punto de Venta', 'pos', 'Registro de ventas y cobros', 'fas fa-cash-register', '#2ecc71', '/modules/pos/', 'active', NOW(), NOW()),
(25, 'CRM', 'crm', 'Gestión de clientes y etapas', 'fas fa-user-tie', '#e67e22', '/modules/crm/', 'active', NOW(), NOW()),
(26, 'Caja Chica', 'petty-cash', 'Solicitudes y control de fondos', 'fas fa-wallet', '#e74c3c', '/modules/petty-cash/', 'active', NOW(), NOW()),
(27, 'Configuración', 'settings', 'Edición de empresa y módulos', 'fas fa-cogs', '#34495e', '/modules/settings/', 'active', NOW(), NOW()),
(28, 'KPIs', 'kpis', 'Visualización de indicadores clave', 'fas fa-bullseye', '#3498db', '/modules/kpis/', 'active', NOW(), NOW()),
(29, 'Agente de Ventas', 'sales-agent', 'Recomendaciones IA para ventas', 'fas fa-robot', '#f39c12', '/modules/sales-agent/', 'active', NOW(), NOW()),
(30, 'Mantenimiento', 'maintenance', 'Gestión y cierre de servicios', 'fas fa-tools', '#2ecc71', '/modules/maintenance/', 'active', NOW(), NOW());
