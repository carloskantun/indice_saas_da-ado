<?php
require_once __DIR__ . '/../config.php';

try {
    $db = getDB();
} catch (Exception $e) {
    echo "Error connecting to database: " . $e->getMessage() . "\n";
    exit(1);
}

// Ensure migrations table exists
$db->exec(
    "CREATE TABLE IF NOT EXISTS migrations (
        id INT AUTO_INCREMENT PRIMARY KEY,
        filename VARCHAR(255) NOT NULL UNIQUE,
        executed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB"
);

$dir = __DIR__ . '/migrations';
$files = glob($dir . '/*');
sort($files);

foreach ($files as $file) {
    $name = basename($file);
    $stmt = $db->prepare('SELECT COUNT(*) FROM migrations WHERE filename = ?');
    $stmt->execute([$name]);
    if ($stmt->fetchColumn()) {
        echo "Skipping $name (already applied)\n";
        continue;
    }

    $ext = pathinfo($file, PATHINFO_EXTENSION);
    echo "Applying $name...\n";
    if ($ext === 'sql') {
        $sql = file_get_contents($file);
        $db->exec($sql);
        $db->prepare('INSERT INTO migrations (filename) VALUES (?)')->execute([$name]);
        echo "Done.\n";
    } elseif ($ext === 'php') {
        echo "Manual migration required: $name\n";
        echo "Run: php database/migrations/$name\n";
    }
}

echo "Migration process completed.\n";
