<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "shop_zone";

$connectNow = new mysqli($host, $username, $password, $database);
if ($connectNow->connect_error) {
    die("Connection failed: " . $connectNow->connect_error);
}
?>
