<?php
include '../db_config.php';

$itemId = $_GET['itemID'];

$sql = "SELECT * FROM items WHERE itemID = '$itemId'";
$result = $connectNow->query($sql);
$data = array();

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
    echo json_encode([
        'success' => true,
        'message' => 'Items fetched successfully!',
        'data' => $data
    ]);
} else {
    echo json_encode([
        'success' => false,
        'message' => 'No records found!'
    ]);
}

$connectNow->close();
?>