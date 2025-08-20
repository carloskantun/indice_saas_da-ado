-- 1. Modificar la tabla providers para agregar business_id
ALTER TABLE providers ADD COLUMN business_id INT(11) DEFAULT NULL;

-- 2. Ejemplo de CREATE TABLE actualizado
CREATE TABLE `providers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `business_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `rfc` varchar(50) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_providers_company_id` (`company_id`),
  KEY `idx_providers_business_id` (`business_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 3. Ejemplo de INSERT actualizado
INSERT INTO providers (company_id, business_id, name, phone, email, address, rfc, created_by, status)
VALUES (1, 1, 'Proveedor Ejemplo', '555-1234', 'proveedor@ejemplo.com', 'Calle 1', 'RFC123', 1, 'active');

-- 4. Ejemplo de SELECT actualizado
SELECT * FROM providers WHERE company_id = 1 AND business_id = 1 AND status = 'active';

-- 5. Actualizar todos los scripts y dumps para incluir business_id en definición, inserts y consultas.
