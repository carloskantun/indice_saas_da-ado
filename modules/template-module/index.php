<?php
require_once '../../config.php';
$moduleName = $lang['template_module'] ?? 'Template Module';
?>
<!DOCTYPE html>
<html lang="<?php echo getCurrentLanguage(); ?>">
<head>
    <meta charset="UTF-8">
    <title><?php echo $moduleName; ?></title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container mt-4">
        <h1><?php echo $moduleName; ?></h1>
        <button class="btn btn-primary mb-2" id="btn-new">
            <i class="fas fa-plus"></i> <?php echo $lang['create'] ?? 'Create'; ?>
        </button>
        <table class="table table-bordered" id="mainTable">
            <thead>
                <tr>
                    <th><?php echo $lang['view'] ?? 'View'; ?></th>
                    <th><?php echo $lang['edit'] ?? 'Edit'; ?></th>
                    <th><?php echo $lang['delete'] ?? 'Delete'; ?></th>
                    <th><?php echo $lang['action'] ?? 'Action'; ?></th>
                </tr>
            </thead>
            <tbody>
                <!-- Rows will be loaded via JS -->
            </tbody>
        </table>
    </div>
    <?php include 'modals.php'; ?>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="js/template-module.js"></script>
</body>
</html>
