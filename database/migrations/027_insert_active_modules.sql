-- Seed active modules and associate them with all plans

INSERT IGNORE INTO modules (name, slug, url, icon, allowed_roles, status, created_at, updated_at) VALUES
    ('Analytics', 'analytics', '/modules/analytics/', 'fas fa-chart-bar', 'admin', 'active', NOW(), NOW()),
    ('Chat', 'chat', '/modules/chat/', 'fas fa-comments', 'admin,user', 'active', NOW(), NOW()),
    ('Cleaning', 'cleaning', '/modules/cleaning/', 'fas fa-broom', 'admin', 'active', NOW(), NOW()),
    ('CRM', 'crm', '/modules/crm/', 'fas fa-user-tie', 'admin', 'active', NOW(), NOW()),
    ('Expenses', 'expenses', '/modules/expenses/', 'fas fa-coins', 'admin', 'active', NOW(), NOW()),
    ('Settings', 'settings', '/modules/settings/', 'fas fa-cogs', 'admin', 'active', NOW(), NOW()),
    ('Training', 'training', '/modules/training/', 'fas fa-chalkboard-teacher', 'user,admin', 'active', NOW(), NOW()),
    ('Transportation', 'transportation', '/modules/transportation/', 'fas fa-bus', 'admin', 'active', NOW(), NOW()),
    ('Vehicles', 'vehicles', '/modules/vehicles/', 'fas fa-car', 'admin', 'active', NOW(), NOW());

-- Link modules to every plan
INSERT IGNORE INTO plan_modules (plan_id, module_id, created_at)
SELECT p.id, m.id, NOW()
FROM plans p
JOIN modules m ON m.slug IN ('analytics','chat','cleaning','crm','expenses','settings','training','transportation','vehicles');
