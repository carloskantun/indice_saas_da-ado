<?php
/**
 * Módulo Petty Cash - vista principal
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
        'admin' => ['petty-cash.view', 'petty-cash.edit'],
        'user'  => ['petty-cash.view']
    ];

    return in_array($permission, $permission_map[$role] ?? []);
}

// Contenido del módulo...
?>
