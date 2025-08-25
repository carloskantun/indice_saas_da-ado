<?php
use PHPUnit\Framework\TestCase;

require_once __DIR__ . '/../config.php';

final class InstallSmokeTest extends TestCase
{
    private ?PDO $db = null;

    private function db(): PDO
    {
        if ($this->db === null) {
            $dsn = sprintf(
                'mysql:host=%s;dbname=%s;charset=utf8mb4',
                $_ENV['DB_HOST'],
                $_ENV['DB_NAME']
            );
            $this->db = new PDO($dsn, $_ENV['DB_USER'], $_ENV['DB_PASS'], [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false,
            ]);
        }
        return $this->db;
    }

    public function testDatabaseConnection(): void
    {
        $this->assertInstanceOf(PDO::class, $this->db());
    }

    public function testRootUserExists(): void
    {
        $stmt = $this->db()->prepare('SELECT COUNT(*) FROM users WHERE email = ?');
        $stmt->execute(['root@indiceapp.com']);
        $count = (int) $stmt->fetchColumn();
        $this->assertGreaterThan(0, $count, 'Root user not found');
    }

    public function testModulesTableHasRecords(): void
    {
        $count = (int) $this->db()->query('SELECT COUNT(*) FROM modules')->fetchColumn();
        $this->assertGreaterThan(0, $count, 'Modules table is empty');
    }
}
