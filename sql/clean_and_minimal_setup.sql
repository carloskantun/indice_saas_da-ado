-- Limpieza total de la base de datos y creación mínima de usuarios y módulos

-- 1. Borrar todas las tablas relevantes
DROP TABLE IF EXISTS users, user_companies, companies, modules;

-- 2. Crear tablas esenciales
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  role VARCHAR(50) DEFAULT 'user',
  status VARCHAR(20) DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE companies (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  status VARCHAR(20) DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_companies (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  company_id INT NOT NULL,
  role VARCHAR(50) DEFAULT 'user',
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (company_id) REFERENCES companies(id)
);

CREATE TABLE modules (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  slug VARCHAR(100) NOT NULL,
  status VARCHAR(20) DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Insertar usuarios esenciales
INSERT INTO users (email, password, name, role) VALUES
('admin@indiceapp.com', 'adminpassword', 'Admin', 'admin'),
('root@indiceapp.com', 'rootpassword', 'Root', 'root');

-- 4. Insertar empresa de sistema
INSERT INTO companies (name, status) VALUES ('IndiceApp', 'active');

-- 5. Relacionar usuarios con la empresa
INSERT INTO user_companies (user_id, company_id, role) VALUES
(1, 1, 'admin'),
(2, 1, 'root');

-- 6. Insertar módulos básicos
INSERT INTO modules (name, slug, status) VALUES
('Dashboard', 'dashboard', 'active'),
('Usuarios', 'users', 'active'),
('Empresas', 'companies', 'active'),
('Gastos', 'expenses', 'active');
