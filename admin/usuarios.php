<?php
require_once '../config.php';
require_once __DIR__ . '/controllers/UsuariosController.php';

$controller = new UsuariosController();
$data = $controller->index();
extract($data);
require __DIR__ . '/views/usuarios.php';
