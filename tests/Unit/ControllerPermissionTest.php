<?php
use PHPUnit\Framework\TestCase;

require_once __DIR__ . '/../../config.php';

// Copia de la función hasPermission del controlador del módulo template-module
function template_module_hasPermission($permission) {
    if (!checkAuth()) {
        return false;
    }

    $role = $_SESSION['current_role'] ?? 'user';
    if (in_array($role, ['root', 'superadmin'])) {
        return true;
    }

    $permission_map = [
        'admin' => ['template-module.view', 'template-module.edit'],
        'user'  => ['template-module.view']
    ];

    return in_array($permission, $permission_map[$role] ?? []);
}

class ControllerPermissionTest extends TestCase
{
    protected function setUp(): void
    {
        if (session_status() !== PHP_SESSION_ACTIVE) {
            session_start();
        }
        $_SESSION = ['user_id' => 1];
    }

    public function test_admin_permissions(): void
    {
        $_SESSION['current_role'] = 'admin';
        $this->assertTrue(template_module_hasPermission('template-module.view'));
        $this->assertTrue(template_module_hasPermission('template-module.edit'));
        $this->assertFalse(template_module_hasPermission('template-module.delete'));
    }

    public function test_user_permissions(): void
    {
        $_SESSION['current_role'] = 'user';
        $this->assertTrue(template_module_hasPermission('template-module.view'));
        $this->assertFalse(template_module_hasPermission('template-module.edit'));
    }
}
