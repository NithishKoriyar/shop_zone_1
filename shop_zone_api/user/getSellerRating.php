<?php
include '../db_config.php';

$sellerId = $_POST['sellerId'];

$query = "SELECT rating FROM sellers_table WHERE seller_id = ?";
$stmt = $connectNow->prepare($query);
$stmt->bind_param('i', $sellerId);
$stmt->execute();
$result = $stmt->get_result();

$response = array();

if($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $response = $row;
}

echo json_encode($response);
?>
