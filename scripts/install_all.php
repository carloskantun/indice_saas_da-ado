<?php
// Ejecuta todos los instaladores y migraciones en orden

$root = dirname(__DIR__);
require_once $root . '/config.php';

$db = getDB();
// Ensure migrations table exists
$db->exec("CREATE TABLE IF NOT EXISTS migrations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    filename VARCHAR(255) NOT NULL UNIQUE,
    executed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB");

$migrationsDir = $root . '/database/migrations';
$phpMigrations = [
    $migrationsDir . '/001_install_database.php',
];

foreach ($phpMigrations as $migration) {
    if (!file_exists($migration)) continue;
    $name = basename($migration);
    echo "Running $name...\n";
    passthru('php ' . escapeshellarg($migration), $status);
    if ($status !== 0) {
        echo "Error executing $name. Aborting.\n";
        exit($status);
    }
    $stmt = $db->prepare('INSERT IGNORE INTO migrations (filename) VALUES (?)');
    $stmt->execute([$name]);
}

// Mark remaining migrations as applied to avoid manual steps
foreach (glob($migrationsDir . '/*') as $file) {
    if (!in_array($file, $phpMigrations)) {
        $stmt = $db->prepare('INSERT IGNORE INTO migrations (filename) VALUES (?)');
        $stmt->execute([basename($file)]);
    }
}

echo "Applying SQL migrations...\n";
passthru('php ' . escapeshellarg($root . '/database/migrate.php'), $status);
if ($status !== 0) {
    echo "Migration script failed. Aborting.\n";
    exit($status);
}

$extraScripts = [
    $root . '/panel_root/create_plans_table.php',
];

foreach ($extraScripts as $script) {
    if (!file_exists($script)) {
        continue;
    }
    $name = basename($script);
    echo "Running $name...\n";
    $dir = dirname($script);
    passthru('cd ' . escapeshellarg($dir) . ' && php ' . escapeshellarg($name), $status);
    if ($status !== 0) {
        echo "Error executing $name. Aborting.\n";
        exit($status);
    }
}

echo "Installation finished successfully.\n";
