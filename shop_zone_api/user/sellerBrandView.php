<?php
//Display errors for debugging purposes (REMOVE THIS IN PRODUCTION)
ini_set('display_errors', 1);
error_reporting(E_ALL);

include '../db_config.php';

if(!isset($_GET['sellerId']) || empty($_GET['sellerId'])) {
    header('Content-Type: application/json');
    echo json_encode(['error' => 'Invalid sellerId provided.']);
    exit;
}

$sellerId = $_GET['sellerId'];

// Directly embedding variables into SQL is NOT SAFE. This is for demonstration purposes only.
$sql = "SELECT * FROM brands WHERE sellerUID = '$sellerId' ORDER BY publishedDate DESC";

if(!$result = $connectNow->query($sql)) {
    header('Content-Type: application/json');
    // echo json_encode(['error' => '.$sellerID.Query execution failed.']);

$error_message = 'Seller ID: '.$sellerId.'. Query execution failed.';
echo json_encode(['error' => $error_message]);
    exit;
}

$brands = [];

while($row = $result->fetch_assoc()) {
    $brands[] = $row;
}

header('Content-Type: application/json');
echo json_encode($brands);

$connectNow->close();



