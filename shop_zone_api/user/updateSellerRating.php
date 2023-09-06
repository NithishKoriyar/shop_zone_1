<?php
include '../db_config.php';

$sellerId = $_POST['sellerId'];
$rating = $_POST['rating'];

$query = "UPDATE sellers_table SET rating = ? WHERE seller_id = ?";
$stmt = $connectNow->prepare($query);
$stmt->bind_param('di', $rating, $sellerId);
$stmt->execute();

$response = array('status' => 'success');
echo json_encode($response);
?>
