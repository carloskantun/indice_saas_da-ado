<?php
use PHPUnit\Framework\TestCase;

class ConfigTest extends TestCase
{
    protected function setUp(): void
    {
        if (session_status() !== PHP_SESSION_ACTIVE) {
            session_start();
        }
        $_SESSION = [];
        $_GET = [];
    }

    public function test_checkAuth_returns_false_without_user(): void
    {
        require_once __DIR__ . '/../../config.php';
        $this->assertFalse(checkAuth());
    }

    public function test_checkRole_with_admin_role(): void
    {
        require_once __DIR__ . '/../../config.php';
        $_SESSION['user_id'] = 1;
        $_SESSION['current_role'] = 'admin';
        $this->assertTrue(checkRole(['admin']));
        $this->assertFalse(checkRole(['superadmin']));
    }

    public function test_getCurrentLanguage_defaults_to_spanish(): void
    {
        require_once __DIR__ . '/../../config.php';
        $this->assertSame('es', getCurrentLanguage());
    }
}
