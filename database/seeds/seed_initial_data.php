<?php
require_once __DIR__ . '/../../config.php';

try {
    $db = getDB();
} catch (Exception $e) {
    echo "Error connecting to database: " . $e->getMessage() . "\n";
    exit(1);
}

// Create root user if not exists
$email = 'root@indiceapp.com';
$defaultPassword = 'root123';

$stmt = $db->prepare("SELECT id FROM users WHERE email = ?");
$stmt->execute([$email]);
if (!$stmt->fetch()) {
    $hash = password_hash($defaultPassword, PASSWORD_DEFAULT);
    $insertUser = $db->prepare("INSERT INTO users (name, email, password, status) VALUES ('Root User', ?, ?, 'active')");
    $insertUser->execute([$email, $hash]);
    echo "Root user created.\n";
} else {
    echo "Root user already exists.\n";
}

// Essential modules list
$modules = [
    ['Analytics', 'analytics', '/modules/analytics/', 'fas fa-chart-bar', 'admin'],
    ['Chat', 'chat', '/modules/chat/', 'fas fa-comments', 'admin,user'],
    ['Cleaning', 'cleaning', '/modules/cleaning/', 'fas fa-broom', 'admin'],
    ['CRM', 'crm', '/modules/crm/', 'fas fa-user-tie', 'admin'],
    ['Expenses', 'expenses', '/modules/expenses/', 'fas fa-coins', 'admin'],
    ['Settings', 'settings', '/modules/settings/', 'fas fa-cogs', 'admin'],
    ['Training', 'training', '/modules/training/', 'fas fa-chalkboard-teacher', 'user,admin'],
    ['Transportation', 'transportation', '/modules/transportation/', 'fas fa-bus', 'admin'],
    ['Vehicles', 'vehicles', '/modules/vehicles/', 'fas fa-car', 'admin'],
];

$insertModule = $db->prepare(
    "INSERT INTO modules (name, slug, url, icon, allowed_roles, status, created_at, updated_at)
     VALUES (?, ?, ?, ?, ?, 'active', NOW(), NOW())
     ON DUPLICATE KEY UPDATE status='active', url=VALUES(url), icon=VALUES(icon), allowed_roles=VALUES(allowed_roles), updated_at=NOW()"
);

foreach ($modules as $module) {
    $insertModule->execute($module);
}

$slugs = array_column($modules, 1);
$placeholders = implode(',', array_fill(0, count($slugs), '?'));
$sql = "INSERT IGNORE INTO plan_modules (plan_id, module_id, created_at)
        SELECT p.id, m.id, NOW()
        FROM plans p
        JOIN modules m ON m.slug IN ($placeholders)";
$stmt = $db->prepare($sql);
$stmt->execute($slugs);

echo "Seed completed.\n";
