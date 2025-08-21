<?php
/**
 * 014_normalize_module_access.php
 * Agrega columna allowed_roles a modules y normaliza slugs en inglés.
 */

require_once __DIR__ . '/../config.php';

try {
    $db = getDB();

    echo "\n🔧 Actualizando tabla modules...\n";
    // Agregar columna allowed_roles si no existe
    $stmt = $db->query("SHOW COLUMNS FROM modules LIKE 'allowed_roles'");
    if (!$stmt->fetch()) {
        $db->exec("ALTER TABLE modules ADD COLUMN allowed_roles VARCHAR(255) NOT NULL DEFAULT 'admin'");
        echo "✅ Columna allowed_roles agregada.\n";
    } else {
        echo "ℹ️  Columna allowed_roles ya existe.\n";
    }

    echo "\n🔧 Normalizando slugs...\n";
    $slugUpdates = [
        'gastos' => 'expenses',
        'mantenimiento' => 'maintenance',
        'inventario' => 'inventory',
        'ventas' => 'sales',
        'servicio_cliente' => 'customer-service',
        'lavanderia' => 'laundry',
        'compras' => 'purchases'
    ];
    $stmt = $db->prepare("UPDATE modules SET slug = ? WHERE slug = ?");
    foreach ($slugUpdates as $old => $new) {
        $stmt->execute([$new, $old]);
    }
    echo "✅ Slugs normalizados.\n";

    echo "\n🔧 Estableciendo roles permitidos por módulo...\n";
    $roleUpdates = [
        'expenses' => 'admin,moderator,user',
        'human-resources' => 'admin,moderator',
        'maintenance' => 'admin,moderator,user',
        'inventory' => 'admin,moderator,user',
        'sales' => 'admin,moderator,user',
        'customer-service' => 'admin,moderator,user'
    ];
    $stmt = $db->prepare("UPDATE modules SET allowed_roles = ? WHERE slug = ?");
    foreach ($roleUpdates as $slug => $roles) {
        $stmt->execute([$roles, $slug]);
    }
    echo "✅ Roles actualizados.\n";

    echo "\n✔️ Migración completada.\n";
} catch (Exception $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
}
