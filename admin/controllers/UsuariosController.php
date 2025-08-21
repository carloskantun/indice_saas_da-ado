<?php

class UsuariosController {
    private $pdo;
    private $lang;

    public function __construct() {
        global $lang;
        $this->pdo = getDB();
        $this->lang = $lang;
    }

    public function index() {
        if (!checkRole(['root', 'superadmin', 'admin'])) {
            redirect('/companies/');
        }

        $current_company = null;
        $company_id = null;

        if (checkRole(['root'])) {
            if (isset($_GET['company_id']) && !empty($_GET['company_id'])) {
                $company_id = (int) $_GET['company_id'];

                $stmt = $this->pdo->prepare("SELECT * FROM companies WHERE id = ? AND status = 'active'");
                $stmt->execute([$company_id]);
                $current_company = $stmt->fetch();

                if ($current_company) {
                    $_SESSION['current_company_id'] = $company_id;
                    $_SESSION['current_company_name'] = $current_company['name'];
                }
            }
        } else {
            $company_id = isset($_GET['company_id']) ? (int) $_GET['company_id'] : ($_SESSION['current_company_id'] ?? $_SESSION['company_id'] ?? null);

            if ($company_id) {
                $stmt = $this->pdo->prepare("SELECT c.*, uc.role FROM companies c INNER JOIN user_companies uc ON c.id = uc.company_id WHERE c.id = ? AND uc.user_id = ? AND uc.role IN ('superadmin', 'admin') AND uc.status = 'active'");
                $stmt->execute([$company_id, $_SESSION['user_id']]);
                $current_company = $stmt->fetch();

                if (!$current_company) {
                    redirect('/companies/');
                }

                $_SESSION['current_company_id'] = $company_id;
                $_SESSION['current_company_name'] = $current_company['name'];
            } else {
                redirect('/companies/');
            }
        }

        return [
            'current_company' => $current_company,
            'company_id' => $company_id,
            'lang' => $this->lang,
        ];
    }
}

