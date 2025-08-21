<?php
/**
 * Módulo Maintenance - vista principal
 */

require_once '../../config.php';

if (!checkAuth()) {
    redirect('auth/');
}

function hasPermission($permission) {
    if (!checkAuth()) {
        return false;
    }

    $role = $_SESSION['current_role'] ?? 'user';
    if (in_array($role, ['root', 'superadmin'])) {
        return true;
    }

    $permission_map = [
        'admin' => ['maintenance.view', 'maintenance.edit'],
        'user'  => ['maintenance.view']
    ];

    return in_array($permission, $permission_map[$role] ?? []);
}

// Contenido del módulo...
?>
