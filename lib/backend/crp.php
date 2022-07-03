<?php
$bdd = mysqli_connect("localhost", "root", "", "encypted_app");
$token = openssl_random_pseudo_bytes(16);
//Convert the binary data into hexadecimal representation.
$token = bin2hex($token);
echo json_encode($token);
?>