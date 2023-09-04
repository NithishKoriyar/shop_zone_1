<?php
include '../db_config.php';

$userId = $_GET['uid'];
$status = $_GET['status'];

$sql = "SELECT * FROM users_orders WHERE orderBy = '$userId' AND status = '$status'";
$result = $connectNow->query($sql);
$data = array();

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
    echo json_encode([
        'success' => true,
        'message' => 'Data fetched successfully!',
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
