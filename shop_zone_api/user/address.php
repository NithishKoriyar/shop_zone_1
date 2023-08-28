<?php

include '../db_config.php';

$uid = $_GET['uid'];
$query = "SELECT * FROM useraddress WHERE uid = '$uid'";
$result = mysqli_query($connectNow, $query);
$data = mysqli_fetch_all($result, MYSQLI_ASSOC);

echo json_encode($data);

mysqli_close($connectNow);
?>
