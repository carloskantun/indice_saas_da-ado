-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 15-08-2025 a las 13:39:01
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

--
-- Volcado de datos para la tabla `businesses`
--

INSERT INTO `businesses` (`id`, `name`, `description`, `type_id`, `unit_id`, `status`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'AMMO', 'Agencia Multimedia Marketing Online. - Diseño web', 6, 2, 'active', 1, '2025-07-30 21:16:12', '2025-07-30 21:16:12'),
(2, 'Transfers', 'Servicio de Transfers privados', 10, 3, 'active', 4, '2025-07-31 02:50:08', '2025-07-31 02:50:08'),
(3, 'css', 'tester', 6, 7, 'active', 3, '2025-08-05 02:07:00', '2025-08-05 02:07:00'),
(4, 'Vegel1707a', '', 9, 6, 'active', 2, '2025-08-05 02:07:51', '2025-08-05 02:07:51'),
(5, 'Cp2518', '', 9, 5, 'active', 2, '2025-08-08 04:56:56', '2025-08-08 04:56:56');

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

--
-- Volcado de datos para la tabla `business_types`
--

INSERT INTO `business_types` (`id`, `name`, `description`, `created_at`) VALUES
(1, 'Restaurante', 'Negocio de comida y bebidas', '2025-07-30 21:04:49'),
(2, 'Tienda de Retail', 'Venta al por menor', '2025-07-30 21:04:49'),
(3, 'Servicios Profesionales', 'Consultoría, asesoría, etc.', '2025-07-30 21:04:49'),
(4, 'E-commerce', 'Comercio electrónico', '2025-07-30 21:04:49'),
(5, 'Manufactura', 'Producción y fabricación', '2025-07-30 21:04:49'),
(6, 'Tecnología', 'Software, hardware, IT', '2025-07-30 21:04:49'),
(7, 'Salud', 'Servicios médicos y de salud', '2025-07-30 21:04:49'),
(8, 'Educación', 'Servicios educativos', '2025-07-30 21:04:49'),
(9, 'Inmobiliario', 'Bienes raíces', '2025-07-30 21:04:49'),
(10, 'Transporte', 'Logística y transporte', '2025-07-30 21:04:49'),
(11, 'Otro', 'Otros tipos de negocio', '2025-07-30 21:04:49');

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

--
(1, 'Servicio Multimedia', 'Servicio de Creación Multimedia para empresas, Gestion de programación, redes y webs.', 'active', 1, '2025-07-30 21:14:24', '2025-07-31 01:53:47', 2),
(2, 'Corazón', '', 'active', 1, '2025-07-30 21:22:11', '2025-07-30 21:22:11', 1),
(3, 'Sistema', 'Empresa del sistema para administración', 'active', 3, '2025-07-31 00:56:52', '2025-07-31 00:56:52', 1),
(4, 'Tours Kantun', 'Mi empresa de turismo.', 'active', 4, '2025-07-31 02:49:07', '2025-07-31 02:52:32', 4),
(5, 'El corazon del caribe', 'Empresa de renta vacacional', 'active', 2, '2025-07-31 18:48:56', '2025-08-05 01:44:53', 8),
(6, 'Empresa de carlos kantun', 'Empresa personal creada automáticamente', 'active', 6, '2025-08-02 02:28:22', '2025-08-02 02:28:22', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `credit_notes`

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

--
-- Volcado de datos para la tabla `departments`
--

INSERT INTO `departments` (`id`, `company_id`, `business_id`, `name`, `description`, `manager_id`, `status`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Recursos Humanos', 'Gestión de personal y políticas laborales', NULL, 'active', 1, '2025-08-08 04:34:08', NULL),
(2, 1, 1, 'Tecnología', 'Desarrollo de software y soporte técnico', NULL, 'active', 1, '2025-08-08 04:34:08', NULL),
(3, 1, 1, 'Ventas', 'Gestión comercial y atención a clientes', NULL, 'active', 1, '2025-08-08 04:34:08', NULL),
(4, 1, 1, 'Administración', 'Gestión administrativa y financiera', NULL, 'active', 1, '2025-08-08 04:34:08', NULL),
(5, 1, 1, 'Marketing', 'Promoción y estrategias de mercadeo', NULL, 'active', 1, '2025-08-08 04:34:08', NULL);

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
-- Volcado de datos para la tabla `employees`
--

INSERT INTO `employees` (`id`, `employee_id`, `company_id`, `business_id`, `unit_id`, `employee_number`, `first_name`, `last_name`, `email`, `phone`, `fiscal_id`, `department_id`, `position_id`, `hire_date`, `employment_type`, `contract_type`, `salary`, `salary_frequency`, `payment_frequency`, `status`, `notes`, `created_by`, `created_at`, `updated_at`) VALUES
(10, NULL, 1, 1, NULL, 'EMP001', 'María', 'García', 'maria.garcia@empresa.com', '555-0001', 'RFC001', 1, 1, '2024-01-15', 'Tiempo_Completo', 'Indefinido', 25000.00, 'Mensual', 'Mensual', 'Activo', NULL, 1, '2025-08-12 02:59:02', NULL),
(11, NULL, 1, 1, NULL, 'EMP002', 'Juan', 'Pérez', 'juan.perez@empresa.com', '555-0002', 'RFC002', 2, 3, '2024-02-01', 'Tiempo_Completo', 'Indefinido', 30000.00, 'Mensual', 'Mensual', 'Activo', NULL, 1, '2025-08-12 02:59:02', NULL),
(12, NULL, 1, 1, NULL, 'EMP003', 'Ana', 'López', 'ana.lopez@empresa.com', '555-0003', 'RFC003', 1, 2, '2024-03-01', 'Tiempo_Completo', 'Indefinido', 22000.00, 'Mensual', 'Mensual', 'Activo', NULL, 1, '2025-08-12 02:59:02', NULL),
(13, NULL, 1, 1, NULL, 'EMP004', 'Carlos', 'Martínez', 'carlos.martinez@empresa.com', '555-0004', 'RFC004', 3, 6, '2024-04-01', 'Tiempo_Completo', 'Indefinido', 28000.00, 'Mensual', 'Mensual', 'Activo', NULL, 1, '2025-08-12 02:59:02', NULL),
(14, NULL, 1, 1, NULL, 'EMP005', 'Laura', 'Rodríguez', 'laura.rodriguez@empresa.com', '555-0005', 'RFC005', 4, 8, '2024-05-01', 'Tiempo_Completo', 'Indefinido', 24000.00, 'Mensual', 'Mensual', 'Activo', NULL, 1, '2025-08-12 02:59:02', NULL),
(15, NULL, 1, 1, 2, 'EMP-1754969343090', 'Juan', 'Pérez Test', 'juan.test1754969343090@test.com', '555-0123', NULL, 1, 1, '2024-01-15', 'Tiempo_Completo', 'Indefinido', 50000.00, 'Mensual', 'Mensual', 'Activo', NULL, 1, '2025-08-12 03:29:03', NULL),
(16, NULL, 1, 1, 2, 'EMP-1754969368956', 'Juan', 'Pérez Test', 'juan.test1754969368956@test.com', '555-0123', NULL, 1, 1, '2024-01-15', 'Tiempo_Completo', 'Indefinido', 50000.00, 'Mensual', 'Mensual', 'Activo', NULL, 1, '2025-08-12 03:29:29', NULL);

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
-- Volcado de datos para la tabla `expenses`
--

INSERT INTO `expenses` (`id`, `folio`, `company_id`, `unit_id`, `business_id`, `provider_id`, `employee_id`, `amount`, `payment_date`, `expense_type`, `purchase_type`, `payment_method`, `bank_account`, `status`, `recurring_days`, `next_recurring`, `concept`, `order_folio`, `origin`, `origin_id`, `note_credit_id`, `created_by`, `created_at`, `updated_at`) VALUES
(26, 'EXP000001', 1, 2, 1, 4, NULL, 500.00, '2025-08-06', 'Unico', '', 'Efectivo', '0000001', 'Pagado', NULL, NULL, 'test', '', 'Directo', NULL, NULL, 1, '2025-08-07 01:40:54', '2025-08-07 01:52:52'),
(27, 'ORD000001', 1, 2, 1, 4, NULL, 2500.00, '2025-08-09', 'Recurrente', 'Operativo', 'Transferencia', '', 'Pago parcial', NULL, NULL, 'teset', 'ORD000001', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:53:19'),
(28, 'ORD000002', 1, 2, 1, 4, NULL, 2500.00, '2025-08-16', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000002', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(29, 'ORD000003', 1, 2, 1, 4, NULL, 2500.00, '2025-08-23', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000003', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(30, 'ORD000004', 1, 2, 1, 4, NULL, 2500.00, '2025-08-30', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000004', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(31, 'ORD000005', 1, 2, 1, 4, NULL, 2500.00, '2025-09-06', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000005', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(32, 'ORD000006', 1, 2, 1, 4, NULL, 2500.00, '2025-09-13', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000006', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(33, 'ORD000007', 1, 2, 1, 4, NULL, 2500.00, '2025-09-20', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000007', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(34, 'ORD000008', 1, 2, 1, 4, NULL, 2500.00, '2025-09-27', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000008', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(35, 'ORD000009', 1, 2, 1, 4, NULL, 2500.00, '2025-10-04', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000009', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(36, 'ORD000010', 1, 2, 1, 4, NULL, 2500.00, '2025-10-11', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000010', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(37, 'ORD000011', 1, 2, 1, 4, NULL, 2500.00, '2025-10-18', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000011', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(38, 'ORD000012', 1, 2, 1, 4, NULL, 2500.00, '2025-10-25', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000012', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(39, 'ORD000013', 1, 2, 1, 4, NULL, 2500.00, '2025-11-01', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000013', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(40, 'ORD000014', 1, 2, 1, 4, NULL, 2500.00, '2025-11-08', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000014', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(41, 'ORD000015', 1, 2, 1, 4, NULL, 2500.00, '2025-11-15', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000015', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(42, 'ORD000016', 1, 2, 1, 4, NULL, 2500.00, '2025-11-22', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000016', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(43, 'ORD000017', 1, 2, 1, 4, NULL, 2500.00, '2025-11-29', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000017', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(44, 'ORD000018', 1, 2, 1, 4, NULL, 2500.00, '2025-12-06', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000018', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(45, 'ORD000019', 1, 2, 1, 4, NULL, 2500.00, '2025-12-13', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000019', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(46, 'ORD000020', 1, 2, 1, 4, NULL, 2500.00, '2025-12-20', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000020', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(47, 'ORD000021', 1, 2, 1, 4, NULL, 2500.00, '2025-12-27', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000021', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(48, 'ORD000022', 1, 2, 1, 4, NULL, 2500.00, '2026-01-03', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000022', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(49, 'ORD000023', 1, 2, 1, 4, NULL, 2500.00, '2026-01-10', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000023', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24'),
(50, 'ORD000024', 1, 2, 1, 4, NULL, 2500.00, '2026-01-17', 'Recurrente', 'Operativo', 'Transferencia', '', 'Por pagar', NULL, NULL, 'teset', 'ORD000024', 'Orden', NULL, NULL, 1, '2025-08-07 01:41:24', '2025-08-07 01:41:24');

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

--
-- Volcado de datos para la tabla `expense_payments`
--

INSERT INTO `expense_payments` (`id`, `expense_id`, `amount`, `payment_date`, `comment`, `receipt_file`, `created_by`, `created_at`) VALUES
(1, 26, 500.00, '2025-08-06', 'tester', NULL, 1, '2025-08-07 01:52:52'),
(2, 27, 500.00, '2025-08-06', 'tester para abonado', NULL, 1, '2025-08-07 01:53:19');

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

--
-- Volcado de datos para la tabla `invitations`
--

INSERT INTO `invitations` (`id`, `email`, `company_id`, `unit_id`, `business_id`, `role`, `token`, `status`, `sent_date`, `expiration_date`, `sent_by`) VALUES
(1, 'test@ejemplo.com', 1, 2, 1, 'user', '211294a5e54391af9018b4af18e103ef87eac8a4279ca3309593caf27bd8d481', 'pending', '2025-08-09 02:44:35', '2025-08-16 02:44:35', 1);

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

--
-- Volcado de datos para la tabla `modules`
--

INSERT INTO `modules` (`id`, `name`, `slug`, `description`, `icon`, `color`, `url`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Dashboard', 'dashboard', 'Panel principal con estadísticas', 'fas fa-tachometer-alt', '#3498db', '/dashboard', 'active', '2025-07-31 02:38:10', '2025-07-31 02:38:10'),
(2, 'Gestión de Usuarios', 'users', 'Administración de usuarios del sistema', 'fas fa-users', '#2ecc71', '/users', 'active', '2025-07-31 02:38:10', '2025-07-31 02:38:10'),
(3, 'Gestión de Empresas', 'companies', 'Administración de empresas clientes', 'fas fa-building', '#e74c3c', '/companies', 'active', '2025-07-31 02:38:10', '2025-07-31 02:38:10'),
(4, 'Facturación', 'billing', 'Sistema de facturación y pagos', 'fas fa-file-invoice-dollar', '#f39c12', '/billing', 'active', '2025-07-31 02:38:10', '2025-07-31 02:38:10'),
(5, 'Reportes', 'reports', 'Generación de reportes y análisis', 'fas fa-chart-line', '#9b59b6', '/reports', 'active', '2025-07-31 02:38:10', '2025-07-31 02:38:10'),
(6, 'Configuración', 'settings', 'Configuraciones del sistema', 'fas fa-cog', '#34495e', '/settings', 'active', '2025-07-31 02:38:10', '2025-07-31 02:38:10'),
(7, 'Soporte', 'support', 'Sistema de tickets de soporte', 'fas fa-life-ring', '#1abc9c', '/support', 'active', '2025-07-31 02:38:10', '2025-07-31 02:38:10'),
(8, 'API', 'api', 'Gestión de API y integraciones', 'fas fa-code', '#e67e22', '/api', 'active', '2025-07-31 02:38:10', '2025-07-31 02:38:10'),
(9, 'Gastos', 'expenses', 'Gestión completa de gastos y proveedores empresariales', 'fas fa-coins', '#e74c3c', '/modules/expenses/', 'active', '2025-08-05 02:59:31', '2025-08-05 02:59:31'),
(10, 'Recursos Humanos', 'human-resources', 'Gestión completa de empleados, departamentos y posiciones', 'fas fa-users', '#3498db', '/modules/human-resources/', 'active', '2025-08-08 04:26:43', '2025-08-08 04:34:08'),
(11, 'Índice Agente de Ventas (IA)', 'ai-sales-agent', 'Asistente de ventas impulsado por IA para optimizar el proceso de ventas', 'fas fa-robot', 'primary', '/modules/ai-sales-agent/', 'active', '2025-08-14 17:44:30', '2025-08-14 17:44:30'),
(12, 'Índice Analítica (IA)', 'ai-analytics', 'Análisis avanzado de datos con inteligencia artificial', 'fas fa-brain', 'info', '/modules/ai-analytics/', 'active', '2025-08-14 17:44:30', '2025-08-14 17:44:30');

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

--
-- Volcado de datos para la tabla `permissions`
--

INSERT INTO `permissions` (`id`, `key_name`, `description`, `module`, `created_at`) VALUES
(1, 'gastos.ver', 'Ver gastos', 'gastos', '2025-07-31 03:45:26'),
(2, 'gastos.crear', 'Crear gastos', 'gastos', '2025-07-31 03:45:26'),
(3, 'gastos.editar', 'Editar gastos', 'gastos', '2025-07-31 03:45:26'),
(4, 'gastos.eliminar', 'Eliminar gastos', 'gastos', '2025-07-31 03:45:26'),
(5, 'usuarios.ver', 'Ver usuarios', 'usuarios', '2025-07-31 03:45:26'),
(6, 'usuarios.invitar', 'Invitar usuarios', 'usuarios', '2025-07-31 03:45:26'),
(7, 'usuarios.editar', 'Editar usuarios', 'usuarios', '2025-07-31 03:45:26'),
(8, 'usuarios.suspender', 'Suspender usuarios', 'usuarios', '2025-07-31 03:45:26'),
(9, 'reportes.ver', 'Ver reportes', 'reportes', '2025-07-31 03:45:26'),
(10, 'configuracion.ver', 'Ver configuración', 'configuracion', '2025-07-31 03:45:26'),
(11, 'configuracion.editar', 'Editar configuración', 'configuracion', '2025-07-31 03:45:26'),
(45, 'expenses.view', 'View expenses', 'expenses', '2025-07-31 04:06:01'),
(46, 'expenses.create', 'Create expenses', 'expenses', '2025-07-31 04:06:01'),
(47, 'expenses.edit', 'Edit expenses', 'expenses', '2025-07-31 04:06:01'),
(48, 'expenses.delete', 'Delete expenses', 'expenses', '2025-07-31 04:06:01'),
(49, 'users.view', 'View users', 'users', '2025-07-31 04:06:01'),
(50, 'users.invite', 'Invite users', 'users', '2025-07-31 04:06:01'),
(51, 'users.edit', 'Edit users', 'users', '2025-07-31 04:06:01'),
(52, 'users.suspend', 'Suspend users', 'users', '2025-07-31 04:06:01'),
(53, 'reports.view', 'View reports', 'reports', '2025-07-31 04:06:01'),
(54, 'settings.view', 'View settings', 'settings', '2025-07-31 04:06:01'),
(55, 'settings.edit', 'Edit settings', 'settings', '2025-07-31 04:06:01'),
(100, 'businesses.view', 'Ver negocios', 'businesses', '2025-08-05 02:06:36'),
(101, 'businesses.create', 'Crear negocios', 'businesses', '2025-08-05 02:06:36'),
(102, 'businesses.edit', 'Editar negocios', 'businesses', '2025-08-05 02:06:36'),
(103, 'businesses.delete', 'Eliminar negocios', 'businesses', '2025-08-05 02:06:36'),
(104, 'expenses.pay', 'Registrar pagos', 'expenses', '2025-08-05 02:59:30'),
(105, 'expenses.export', 'Exportar gastos', 'expenses', '2025-08-05 02:59:30'),
(106, 'expenses.kpis', 'Ver KPIs de gastos', 'expenses', '2025-08-05 02:59:30'),
(107, 'providers.view', 'Ver proveedores', 'expenses', '2025-08-05 02:59:30'),
(108, 'providers.create', 'Crear proveedores', 'expenses', '2025-08-05 02:59:30'),
(109, 'providers.edit', 'Editar proveedores', 'expenses', '2025-08-05 02:59:30'),
(110, 'providers.delete', 'Eliminar proveedores', 'expenses', '2025-08-05 02:59:30'),
(115, 'employees.view', 'Ver empleados', 'human-resources', '2025-08-08 04:26:43'),
(116, 'employees.create', 'Crear empleados', 'human-resources', '2025-08-08 04:26:43'),
(117, 'employees.edit', 'Editar empleados', 'human-resources', '2025-08-08 04:26:43'),
(118, 'employees.delete', 'Eliminar empleados', 'human-resources', '2025-08-08 04:26:43'),
(119, 'employees.export', 'Exportar datos de empleados', 'human-resources', '2025-08-08 04:26:43'),
(120, 'employees.kpis', 'Ver estadísticas de empleados', 'human-resources', '2025-08-08 04:26:43'),
(121, 'departments.view', 'Ver departamentos', 'human-resources', '2025-08-08 04:26:43'),
(122, 'departments.create', 'Crear departamentos', 'human-resources', '2025-08-08 04:26:43'),
(123, 'departments.edit', 'Editar departamentos', 'human-resources', '2025-08-08 04:26:43'),
(124, 'departments.delete', 'Eliminar departamentos', 'human-resources', '2025-08-08 04:26:43'),
(125, 'positions.view', 'Ver posiciones', 'human-resources', '2025-08-08 04:26:43'),
(126, 'positions.create', 'Crear posiciones', 'human-resources', '2025-08-08 04:26:43'),
(127, 'positions.edit', 'Editar posiciones', 'human-resources', '2025-08-08 04:26:43'),
(128, 'positions.delete', 'Eliminar posiciones', 'human-resources', '2025-08-08 04:26:43');

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

--
-- Volcado de datos para la tabla `plans`
--

INSERT INTO `plans` (`id`, `name`, `description`, `price_monthly`, `modules_included`, `users_max`, `units_max`, `businesses_max`, `storage_max_mb`, `is_active`, `created_at`, `updated_at`, `status`, `monthly_price`, `annual_price`) VALUES
(1, 'Free', 'Plan gratuito para empresas pequeñas', 0.00, '[]', 1, 1, 1, 100, 1, '2025-07-31 00:44:33', '2025-07-31 03:01:25', 'active', 49.99, 499.99),
(2, 'Starter', 'Plan inicial para empresas en crecimiento', 25.00, '[\"gastos\", \"mantenimiento\", \"servicio_cliente\", \"compras\", \"lavanderia\"]', 10, 5, 10, 500, 1, '2025-07-31 00:44:33', '2025-07-31 02:45:14', 'active', 49.99, 499.99),
(3, 'Pro', 'Plan profesional con todas las funciones', 75.00, '[\"gastos\", \"mantenimiento\", \"servicio_cliente\", \"compras\", \"lavanderia\", \"transfers\", \"kpis\", \"reportes\"]', 25, 10, 25, 2000, 1, '2025-07-31 00:44:33', '2025-07-31 02:45:14', 'active', 99.99, 999.99),
(4, 'Enterprise', 'Plan empresarial sin límites', 200.00, '[\"gastos\", \"mantenimiento\", \"servicio_cliente\", \"compras\", \"lavanderia\", \"transfers\", \"kpis\", \"reportes\", \"integraciones\", \"api\"]', -1, -1, -1, -1, 1, '2025-07-31 00:44:33', '2025-07-31 02:45:14', 'active', 199.99, 1999.99),
(5, 'Lavanderias', 'Plan Sencillo para empresas pequeñas', 10.00, '[\"gastos\", \"servicio_cliente\", \"compras\", \"lavanderia\", \"kpis\"]', 5, 2, 3, 1024, 1, '2025-07-31 00:56:52', '2025-07-31 02:45:14', 'active', 49.99, 499.99),
(6, 'Starter', 'Plan inicial para empresas en crecimiento', 25.00, '[\"gastos\", \"mantenimiento\", \"servicio_cliente\", \"compras\", \"lavanderia\"]', 10, 5, 10, 500, 1, '2025-07-31 00:56:52', '2025-07-31 02:45:14', 'active', 49.99, 499.99),
(7, 'Pro', 'Plan profesional con todas las funciones', 75.00, '[\"gastos\", \"mantenimiento\", \"servicio_cliente\", \"compras\", \"lavanderia\", \"transfers\", \"kpis\", \"reportes\"]', 25, 10, 25, 2000, 1, '2025-07-31 00:56:52', '2025-07-31 02:45:14', 'active', 99.99, 999.99),
(8, 'Enterprise', 'Plan empresarial sin límites', 200.00, '[\"gastos\", \"mantenimiento\", \"servicio_cliente\", \"compras\", \"lavanderia\", \"transfers\", \"kpis\", \"reportes\", \"integraciones\", \"api\"]', -1, -1, -1, -1, 1, '2025-07-31 00:56:52', '2025-07-31 02:45:14', 'active', 199.99, 1999.99);

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

--
-- Volcado de datos para la tabla `plan_modules`
--

INSERT INTO `plan_modules` (`id`, `plan_id`, `module_id`, `created_at`) VALUES
(1, 1, 1, '2025-07-31 02:38:10'),
(2, 1, 2, '2025-07-31 02:38:10'),
(3, 1, 3, '2025-07-31 02:38:10'),
(4, 1, 4, '2025-07-31 02:38:10'),
(5, 1, 5, '2025-07-31 02:38:10'),
(6, 1, 6, '2025-07-31 02:38:10'),
(7, 1, 7, '2025-07-31 02:38:10'),
(8, 1, 8, '2025-07-31 02:38:10'),
(9, 2, 1, '2025-07-31 02:38:10'),
(10, 2, 2, '2025-07-31 02:38:10'),
(11, 2, 3, '2025-07-31 02:38:10'),
(12, 2, 4, '2025-07-31 02:38:10'),
(13, 2, 5, '2025-07-31 02:38:10'),
(14, 2, 6, '2025-07-31 02:38:10'),
(15, 2, 7, '2025-07-31 02:38:10'),
(16, 2, 8, '2025-07-31 02:38:10'),
(17, 3, 1, '2025-07-31 02:38:10'),
(18, 3, 2, '2025-07-31 02:38:10'),
(19, 3, 3, '2025-07-31 02:38:10'),
(20, 3, 4, '2025-07-31 02:38:10'),
(21, 3, 5, '2025-07-31 02:38:10'),
(22, 3, 6, '2025-07-31 02:38:10'),
(23, 3, 7, '2025-07-31 02:38:10'),
(24, 3, 8, '2025-07-31 02:38:10'),
(25, 4, 1, '2025-07-31 02:38:10'),
(26, 4, 2, '2025-07-31 02:38:10'),
(27, 4, 3, '2025-07-31 02:38:10'),
(28, 4, 4, '2025-07-31 02:38:10'),
(29, 4, 5, '2025-07-31 02:38:10'),
(30, 4, 6, '2025-07-31 02:38:10'),
(31, 4, 7, '2025-07-31 02:38:10'),
(32, 4, 8, '2025-07-31 02:38:10'),
(33, 5, 1, '2025-07-31 02:38:10'),
(34, 5, 2, '2025-07-31 02:38:10'),
(35, 5, 3, '2025-07-31 02:38:10'),
(36, 5, 4, '2025-07-31 02:38:10'),
(37, 5, 5, '2025-07-31 02:38:10'),
(38, 5, 6, '2025-07-31 02:38:10'),
(39, 5, 7, '2025-07-31 02:38:10'),
(40, 5, 8, '2025-07-31 02:38:10'),
(41, 6, 1, '2025-07-31 02:38:10'),
(42, 6, 2, '2025-07-31 02:38:10'),
(43, 6, 3, '2025-07-31 02:38:10'),
(44, 6, 4, '2025-07-31 02:38:10'),
(45, 6, 5, '2025-07-31 02:38:10'),
(46, 6, 6, '2025-07-31 02:38:10'),
(47, 6, 7, '2025-07-31 02:38:10'),
(48, 6, 8, '2025-07-31 02:38:10'),
(49, 7, 1, '2025-07-31 02:38:10'),
(50, 7, 2, '2025-07-31 02:38:10'),
(51, 7, 3, '2025-07-31 02:38:10'),
(52, 7, 4, '2025-07-31 02:38:10'),
(53, 7, 5, '2025-07-31 02:38:10'),
(54, 7, 6, '2025-07-31 02:38:10'),
(55, 7, 7, '2025-07-31 02:38:10'),
(56, 7, 8, '2025-07-31 02:38:10'),
(57, 8, 1, '2025-07-31 02:38:10'),
(58, 8, 2, '2025-07-31 02:38:10'),
(59, 8, 3, '2025-07-31 02:38:10'),
(60, 8, 4, '2025-07-31 02:38:10'),
(61, 8, 5, '2025-07-31 02:38:10'),
(62, 8, 6, '2025-07-31 02:38:10'),
(63, 8, 7, '2025-07-31 02:38:10'),
(64, 8, 8, '2025-07-31 02:38:10');

-- --------------------------------------------------------

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
  `timezone` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'America/Mexico_City',
  `language` varchar(10) COLLATE utf8_unicode_ci DEFAULT 'es',
  `notifications_email` tinyint(1) DEFAULT '1',
  `notifications_sms` tinyint(1) DEFAULT '0',
  `avatar` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `login_attempts` int(11) DEFAULT '0',
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('active','inactive') COLLATE utf8_unicode_ci DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `first_name`, `last_name`, `email`, `phone`, `birth_date`, `gender`, `fiscal_id`, `address`, `city`, `state`, `country`, `postal_code`, `bio`, `timezone`, `language`, `notifications_email`, `notifications_sms`, `avatar`, `last_login`, `login_attempts`, `password`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Administrador', 'Administrador', '', 'admin@indiceapp.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'México', NULL, NULL, 'America/Mexico_City', 'es', 1, 0, NULL, NULL, 0, '$2y$10$A3HwjNQrquiWWabCb004tex8lOKqBdW46wwUmzj9V354q2515wzuG', 'active', '2025-07-30 21:04:49', '2025-08-09 03:05:43'),
(2, 'Nahum', 'Nahum', '', 'nahum@indiceapp.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'México', NULL, NULL, 'America/Mexico_City', 'es', 1, 0, NULL, NULL, 0, '$2y$10$st67D.Pam5XAEGRgLTDOBOJ.DjJ0tZ0pC8DpHnfT4/ik0tmIb/xLO', 'active', '2025-07-31 00:54:14', '2025-08-09 03:05:43'),
(3, 'Root Administrator', 'Root', 'Administrator', 'root@indiceapp.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'México', NULL, NULL, 'America/Mexico_City', 'es', 1, 0, NULL, NULL, 0, '$2y$10$tSP25D8X.qY7L7a4ghGSP.5FEqOQ62yu/P/i/FyQp3maicXksVrV6', 'active', '2025-07-31 00:56:52', '2025-08-09 03:05:43'),
(4, 'Carlos', 'Carlos', '', 'carlos@indiceapp.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'México', NULL, NULL, 'America/Mexico_City', 'es', 1, 0, NULL, NULL, 0, '$2y$10$S/9A1gPTkWkg3unrHH/2ZuJ.wH8mGnoL.J5sb/7dlousO0P31quHi', 'active', '2025-07-31 02:48:31', '2025-08-09 03:05:43'),
(5, 'Root User', 'Root', 'User', 'root@localhost', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'México', NULL, NULL, 'America/Mexico_City', 'es', 1, 0, NULL, NULL, 0, '$2y$10$d3gypgDEw5tmBlHMaB5FSe7B9t/jV5L1QWk.rEkASOQuwNidYL1c2', 'active', '2025-08-01 21:32:51', '2025-08-09 03:05:43'),
(6, 'carlos kantun', 'carlos', 'kantun', 'carlosadmin@indiceapp.com', '', '0000-00-00', '', '', '', '', '', 'México', '', '', 'America/Mexico_City', 'es', 1, 1, NULL, NULL, 0, '$2y$10$SRDz6Tb4RBlO1ShkeGYl/u8gKcxAimWkwxkjB.7D2yPsHDynn9/Hu', 'active', '2025-08-02 02:28:22', '2025-08-09 03:17:57');

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
  `joined_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `user_companies`
--

INSERT INTO `user_companies` (`id`, `user_id`, `company_id`, `role`, `status`, `created_at`, `last_accessed`, `joined_at`) VALUES
(1, 1, 1, 'superadmin', 'active', '2025-07-30 21:14:24', '2025-08-14 17:44:39', '2025-08-05 02:06:36'),
(2, 1, 2, 'superadmin', 'active', '2025-07-30 21:22:11', '2025-08-12 21:40:21', '2025-08-05 02:06:36'),
(3, 3, 3, 'root', 'active', '2025-07-31 00:56:52', '2025-08-12 01:36:32', '2025-08-05 02:06:36'),
(4, 4, 4, 'superadmin', 'active', '2025-07-31 02:49:07', '2025-08-12 00:44:52', '2025-08-05 02:06:36'),
(5, 2, 5, 'superadmin', 'active', '2025-07-31 18:48:56', '2025-08-13 06:12:35', '2025-08-05 02:06:36'),
(6, 5, 1, 'superadmin', 'active', '2025-08-01 21:32:51', '2025-08-01 21:32:51', '2025-08-05 02:06:36'),
(7, 6, 6, 'superadmin', 'active', '2025-08-02 02:28:22', '2025-08-02 02:28:40', '2025-08-05 02:06:36'),
(8, 2, 1, 'admin', 'active', '2025-08-05 01:58:48', '2025-08-05 02:36:08', '2025-08-05 02:06:36'),
(9, 2, 4, 'user', 'active', '2025-08-05 01:59:07', '2025-08-05 02:07:20', '2025-08-05 02:06:36'),
(10, 6, 1, 'admin', 'active', '2025-08-09 02:55:05', '2025-08-09 03:18:10', '2025-08-09 02:55:05'),
(11, 6, 2, 'moderator', 'active', '2025-08-09 03:18:02', '2025-08-09 03:18:02', '2025-08-09 03:18:02'),
(12, 6, 5, 'user', 'active', '2025-08-09 03:18:07', '2025-08-09 03:18:07', '2025-08-09 03:18:07');

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

--
-- Volcado de datos para la tabla `user_invitations`
--

INSERT INTO `user_invitations` (`id`, `email`, `company_id`, `unit_id`, `business_id`, `role`, `token`, `status`, `sent_by`, `sent_date`, `expiration_date`, `accepted_date`, `created_at`, `updated_at`) VALUES
(1, 'nahum@indiceapp.com', 1, 1, NULL, 'admin', 'bc08ff11dc9950c4cec7cd324ec1bc4c08b7004aa550557e72d28c27108530e3', 'accepted', 1, '2025-08-01 19:09:37', '2025-08-01 19:09:37', '2025-08-05 01:58:48', '2025-08-01 19:09:37', '2025-08-05 01:58:48'),
(3, 'carlosadmin@indiceapp.com', 5, NULL, NULL, 'user', 'd6f2761e43d2efff8f449d605f6d0596eacc0022dd1f49189542eab1ba398673', 'accepted', 2, '2025-08-02 03:05:56', '2025-08-09 03:05:56', '2025-08-09 03:18:07', '2025-08-02 03:05:56', '2025-08-09 03:18:07'),
(4, 'carlosadmin@indiceapp.com', 2, NULL, NULL, 'moderator', 'a59ddcf99a029707d48178d5bddc0811e6c54cbfe9ffe2950780d7944a9de939', 'accepted', 1, '2025-08-04 20:38:58', '2025-08-04 20:38:58', '2025-08-09 03:18:02', '2025-08-04 20:38:58', '2025-08-09 03:18:02'),
(5, 'direccion@penaconsulting.com.mx', 5, 5, NULL, 'user', '98e2144c5dbaee0b617b1374c8e23606b334176009bdd09991c3c00a02630dc7', 'pending', 2, '2025-08-05 01:51:00', '2025-08-05 01:51:00', NULL, '2025-08-05 01:51:00', '2025-08-05 01:51:00'),
(6, 'carloskantun@live.com', 2, NULL, NULL, 'user', 'e2beecb534f2d0168422042272111bb018bba627581122c2c3c3de0222227ffb', 'pending', 2, '2025-08-05 01:58:10', '2025-08-12 01:58:10', NULL, '2025-08-05 01:58:10', '2025-08-05 01:58:10'),
(7, 'nahum@indiceapp.com', 4, NULL, NULL, 'user', '35542dc7a0989590caa63129b786c39ad94601c99e4b6c74b8a850737c15c899', 'accepted', 2, '2025-08-05 01:58:32', '2025-08-12 01:58:32', '2025-08-05 01:59:07', '2025-08-05 01:58:32', '2025-08-05 01:59:07');

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `plan_id` (`plan_id`);

--
-- Indices de la tabla `credit_notes`
--
ALTER TABLE `credit_notes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `folio` (`folio`),
  ADD KEY `idx_company_status` (`company_id`,`status`),
  ADD KEY `idx_folio` (`folio`),
  ADD KEY `idx_responsible` (`responsible_user_id`);

--
-- Indices de la tabla `credit_note_payments`
--
ALTER TABLE `credit_note_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_credit_note_id` (`credit_note_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_payment_date` (`payment_date`);

--
-- Indices de la tabla `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_company_business` (`company_id`,`business_id`),
  ADD KEY `idx_manager` (`manager_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indices de la tabla `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_employee_number_company` (`employee_number`,`company_id`),
  ADD KEY `idx_company_business` (`company_id`,`business_id`),
  ADD KEY `idx_department` (`department_id`),
  ADD KEY `idx_position` (`position_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_hire_date` (`hire_date`);

--
-- Indices de la tabla `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `folio` (`folio`),
  ADD KEY `idx_company_business` (`company_id`,`business_id`),
  ADD KEY `idx_payment_date` (`payment_date`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_folio` (`folio`),
  ADD KEY `idx_provider` (`provider_id`),
  ADD KEY `idx_created_by` (`created_by`),
  ADD KEY `idx_unit_id` (`unit_id`);

--
-- Indices de la tabla `expense_payments`
--
ALTER TABLE `expense_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_expense_id` (`expense_id`),
  ADD KEY `idx_payment_date` (`payment_date`),
  ADD KEY `idx_created_by` (`created_by`);

--
-- Indices de la tabla `invitations`
--
ALTER TABLE `invitations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `idx_token` (`token`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_company` (`company_id`),
  ADD KEY `sent_by` (`sent_by`);

--
-- Indices de la tabla `modules`
--
ALTER TABLE `modules`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indices de la tabla `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_company_user` (`company_id`,`user_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_type` (`type`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `key_name` (`key_name`);

--
-- Indices de la tabla `permission_audit_log`
--
ALTER TABLE `permission_audit_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_target_user` (`target_user_id`),
  ADD KEY `idx_company` (`company_id`),
  ADD KEY `idx_module_audit` (`module_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indices de la tabla `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `plan_modules`
--
ALTER TABLE `plan_modules`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_plan_module` (`plan_id`,`module_id`),
  ADD KEY `module_id` (`module_id`);

--
-- Indices de la tabla `positions`
--
ALTER TABLE `positions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_company_business` (`company_id`,`business_id`),
  ADD KEY `idx_department` (`department_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indices de la tabla `processes`
--
ALTER TABLE `processes`
  ADD PRIMARY KEY (`process_id`),
  ADD KEY `idx_company_id` (`company_id`),
  ADD KEY `idx_department_id` (`department_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_priority` (`priority`),
  ADD KEY `idx_created_by` (`created_by`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indices de la tabla `process_automation_rules`
--
ALTER TABLE `process_automation_rules`
  ADD PRIMARY KEY (`rule_id`),
  ADD KEY `idx_company_id` (`company_id`),
  ADD KEY `idx_trigger_event` (`trigger_event`),
  ADD KEY `idx_is_active` (`is_active`),
  ADD KEY `idx_created_by` (`created_by`);

--
-- Indices de la tabla `process_instances`
--
ALTER TABLE `process_instances`
  ADD PRIMARY KEY (`instance_id`),
  ADD KEY `idx_process_id` (`process_id`),
  ADD KEY `idx_company_id` (`company_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_started_by` (`started_by`),
  ADD KEY `idx_started_at` (`started_at`);

--
-- Indices de la tabla `process_steps`
--
ALTER TABLE `process_steps`
  ADD PRIMARY KEY (`step_id`),
  ADD KEY `idx_process_id` (`process_id`),
  ADD KEY `idx_step_order` (`step_order`);

--
-- Indices de la tabla `providers`
--
ALTER TABLE `providers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_company_status` (`company_id`,`status`),
  ADD KEY `idx_name` (`name`),
  ADD KEY `idx_created_by` (`created_by`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_role_name` (`role_name`);

--
-- Indices de la tabla `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_role_permission` (`role`,`permission_id`),
  ADD KEY `permission_id` (`permission_id`);

--
-- Indices de la tabla `role_permission_templates`
--
ALTER TABLE `role_permission_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_role_module` (`role_name`,`module_id`),
  ADD KEY `idx_role` (`role_name`),
  ADD KEY `idx_module_template` (`module_id`);

--
-- Indices de la tabla `system_modules`
--
ALTER TABLE `system_modules`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indices de la tabla `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`task_id`),
  ADD KEY `idx_company_id` (`company_id`),
  ADD KEY `idx_process_id` (`process_id`),
  ADD KEY `idx_assigned_to` (`assigned_to`),
  ADD KEY `idx_assigned_by` (`assigned_by`),
  ADD KEY `idx_department_id` (`department_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_priority` (`priority`),
  ADD KEY `idx_due_date` (`due_date`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_completion_percentage` (`completion_percentage`);

--
-- Indices de la tabla `task_assignments`
--
ALTER TABLE `task_assignments`
  ADD PRIMARY KEY (`assignment_id`),
  ADD KEY `idx_task_id` (`task_id`),
  ADD KEY `idx_assigned_to` (`assigned_to`),
  ADD KEY `idx_assigned_by` (`assigned_by`),
  ADD KEY `idx_is_current` (`is_current`),
  ADD KEY `idx_assigned_at` (`assigned_at`);

--
-- Indices de la tabla `task_attachments`
--
ALTER TABLE `task_attachments`
  ADD PRIMARY KEY (`attachment_id`),
  ADD KEY `idx_task_id` (`task_id`),
  ADD KEY `idx_uploaded_by` (`uploaded_by`),
  ADD KEY `idx_uploaded_at` (`uploaded_at`);

--
-- Indices de la tabla `task_comments`
--
ALTER TABLE `task_comments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `idx_task_id` (`task_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_is_internal` (`is_internal`);

--
-- Indices de la tabla `task_history`
--
ALTER TABLE `task_history`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `idx_task_id` (`task_id`),
  ADD KEY `idx_changed_by` (`changed_by`),
  ADD KEY `idx_changed_at` (`changed_at`),
  ADD KEY `idx_field_changed` (`field_changed`);

--
-- Indices de la tabla `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `user_businesses`
--
ALTER TABLE `user_businesses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_business` (`user_id`,`business_id`),
  ADD KEY `business_id` (`business_id`);

--
-- Indices de la tabla `user_companies`
--
ALTER TABLE `user_companies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_company` (`user_id`,`company_id`),
  ADD KEY `company_id` (`company_id`);

--
-- Indices de la tabla `user_invitations`
--
ALTER TABLE `user_invitations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_pending_invitation` (`email`,`company_id`,`status`),
  ADD KEY `idx_token` (`token`),
  ADD KEY `idx_company_status` (`company_id`,`status`),
  ADD KEY `idx_expiration` (`expiration_date`),
  ADD KEY `sent_by` (`sent_by`);

--
-- Indices de la tabla `user_module_permissions`
--
ALTER TABLE `user_module_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_company_module` (`user_id`,`company_id`,`module_id`),
  ADD KEY `idx_user_company` (`user_id`,`company_id`),
  ADD KEY `idx_module` (`module_id`);

--
-- Indices de la tabla `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_user_role_company` (`user_id`,`role_id`,`company_id`,`business_id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_role` (`role_id`),
  ADD KEY `idx_company` (`company_id`);

--
-- Indices de la tabla `user_units`
--
ALTER TABLE `user_units`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_unit` (`user_id`,`unit_id`),
  ADD KEY `unit_id` (`unit_id`);

--
-- Indices de la tabla `workflow_templates`
--
ALTER TABLE `workflow_templates`
  ADD PRIMARY KEY (`template_id`),
  ADD KEY `idx_company_id` (`company_id`),
  ADD KEY `idx_department_id` (`department_id`),
  ADD KEY `idx_category` (`category`),
  ADD KEY `idx_is_active` (`is_active`),
  ADD KEY `idx_created_by` (`created_by`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `businesses`
--
ALTER TABLE `businesses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `business_types`
--
ALTER TABLE `business_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `companies`
--
ALTER TABLE `companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `credit_notes`
--
ALTER TABLE `credit_notes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `credit_note_payments`
--
ALTER TABLE `credit_note_payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `expense_payments`
--
ALTER TABLE `expense_payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `invitations`
--
ALTER TABLE `invitations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `modules`
--
ALTER TABLE `modules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=157;

--
-- AUTO_INCREMENT de la tabla `permission_audit_log`
--
ALTER TABLE `permission_audit_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `plans`
--
ALTER TABLE `plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `plan_modules`
--
ALTER TABLE `plan_modules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT de la tabla `positions`
--
ALTER TABLE `positions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `processes`
--
ALTER TABLE `processes`
  MODIFY `process_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `process_automation_rules`
--
ALTER TABLE `process_automation_rules`
  MODIFY `rule_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `process_instances`
--
ALTER TABLE `process_instances`
  MODIFY `instance_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `process_steps`
--
ALTER TABLE `process_steps`
  MODIFY `step_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `providers`
--
ALTER TABLE `providers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=320;

--
-- AUTO_INCREMENT de la tabla `role_permission_templates`
--
ALTER TABLE `role_permission_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT de la tabla `tasks`
--
ALTER TABLE `tasks`
  MODIFY `task_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `task_assignments`
--
ALTER TABLE `task_assignments`
  MODIFY `assignment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `task_attachments`
--
ALTER TABLE `task_attachments`
  MODIFY `attachment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `task_comments`
--
ALTER TABLE `task_comments`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `task_history`
--
ALTER TABLE `task_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `units`
--
ALTER TABLE `units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `user_businesses`
--
ALTER TABLE `user_businesses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `user_companies`
--
ALTER TABLE `user_companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `user_invitations`
--
ALTER TABLE `user_invitations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `user_module_permissions`
--
ALTER TABLE `user_module_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `user_units`
--
ALTER TABLE `user_units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `workflow_templates`
--
ALTER TABLE `workflow_templates`
  MODIFY `template_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `businesses`
--
ALTER TABLE `businesses`
  ADD CONSTRAINT `businesses_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `business_types` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `businesses_ibfk_2` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `businesses_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `companies`
--
ALTER TABLE `companies`
  ADD CONSTRAINT `companies_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `companies_ibfk_2` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `credit_note_payments`
--
ALTER TABLE `credit_note_payments`
  ADD CONSTRAINT `fk_credit_note_payments_note` FOREIGN KEY (`credit_note_id`) REFERENCES `credit_notes` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `employees_ibfk_2` FOREIGN KEY (`position_id`) REFERENCES `positions` (`id`),
  ADD CONSTRAINT `employees_ibfk_3` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `employees_ibfk_4` FOREIGN KEY (`position_id`) REFERENCES `positions` (`id`),
  ADD CONSTRAINT `employees_ibfk_5` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `employees_ibfk_6` FOREIGN KEY (`position_id`) REFERENCES `positions` (`id`),
  ADD CONSTRAINT `fk_employees_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `fk_employees_position` FOREIGN KEY (`position_id`) REFERENCES `positions` (`id`);

--
-- Filtros para la tabla `expense_payments`
--
ALTER TABLE `expense_payments`
  ADD CONSTRAINT `fk_expense_payments_expense` FOREIGN KEY (`expense_id`) REFERENCES `expenses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `invitations`
--
ALTER TABLE `invitations`
  ADD CONSTRAINT `invitations_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `invitations_ibfk_2` FOREIGN KEY (`sent_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `plan_modules`
--
ALTER TABLE `plan_modules`
  ADD CONSTRAINT `plan_modules_ibfk_1` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `plan_modules_ibfk_2` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `positions`
--
ALTER TABLE `positions`
  ADD CONSTRAINT `fk_positions_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `positions_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `positions_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `positions_ibfk_3` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`);

--
-- Filtros para la tabla `process_instances`
--
ALTER TABLE `process_instances`
  ADD CONSTRAINT `process_instances_ibfk_1` FOREIGN KEY (`process_id`) REFERENCES `processes` (`process_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `process_steps`
--
ALTER TABLE `process_steps`
  ADD CONSTRAINT `process_steps_ibfk_1` FOREIGN KEY (`process_id`) REFERENCES `processes` (`process_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`process_id`) REFERENCES `processes` (`process_id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `task_assignments`
--
ALTER TABLE `task_assignments`
  ADD CONSTRAINT `task_assignments_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`task_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `task_attachments`
--
ALTER TABLE `task_attachments`
  ADD CONSTRAINT `task_attachments_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`task_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `task_comments`
--
ALTER TABLE `task_comments`
  ADD CONSTRAINT `task_comments_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`task_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `task_history`
--
ALTER TABLE `task_history`
  ADD CONSTRAINT `task_history_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`task_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `units`
--
ALTER TABLE `units`
  ADD CONSTRAINT `units_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `units_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `user_businesses`
--
ALTER TABLE `user_businesses`
  ADD CONSTRAINT `user_businesses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_businesses_ibfk_2` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `user_companies`
--
ALTER TABLE `user_companies`
  ADD CONSTRAINT `user_companies_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_companies_ibfk_2` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `user_invitations`
--
ALTER TABLE `user_invitations`
  ADD CONSTRAINT `user_invitations_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_invitations_ibfk_2` FOREIGN KEY (`sent_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `user_units`
--
ALTER TABLE `user_units`
  ADD CONSTRAINT `user_units_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_units_ibfk_2` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
