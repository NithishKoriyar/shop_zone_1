<?php
header('Content-Type: application/json');
include '../db_config.php';

$uid = $_GET['uid']; // you'll need to pass the UID as a parameter to your API

$query = "SELECT * FROM brands WHERE sellerUID = '$uid' ORDER BY publishedDate DESC";

$result = $connectNow->query($query);
$data = [];

while($row = $result->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode($data);

$connectNow->close();
?>

