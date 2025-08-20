-- Agregar campo business_id a la tabla providers
ALTER TABLE providers ADD COLUMN business_id INT(11) DEFAULT NULL;

-- Crear índice para company_id en providers
CREATE INDEX idx_providers_company_id ON providers(company_id);

-- Crear índice compuesto para user_companies
CREATE INDEX idx_user_companies_user_company ON user_companies(user_id, company_id);

-- Crear índice para id en companies
CREATE INDEX idx_companies_id ON companies(id);
