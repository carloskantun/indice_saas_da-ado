<?php
use PHPUnit\Framework\TestCase;

require_once __DIR__ . '/../../admin/role_permissions_helper.php';

class RolePermissionsHelperTest extends TestCase
{
    public function test_can_manage_users(): void
    {
        $this->assertTrue(canManageUsers('root', 'admin'));
        $this->assertTrue(canManageUsers('superadmin', 'user'));
        $this->assertFalse(canManageUsers('support', 'user'));
        $this->assertFalse(canManageUsers('user', 'admin'));
    }

    public function test_has_action_permission(): void
    {
        $this->assertTrue(hasActionPermission('root', 'create_company'));
        $this->assertTrue(hasActionPermission('admin', 'manage_company_users'));
        $this->assertFalse(hasActionPermission('user', 'create_company'));
    }
}
