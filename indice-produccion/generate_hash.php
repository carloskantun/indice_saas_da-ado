<?php
$password = 'Corazon.01*';
$hash = password_hash($password, PASSWORD_BCRYPT);
echo "El hash para la contrase���a 'Corazon.01*' es: $hash";
?>
