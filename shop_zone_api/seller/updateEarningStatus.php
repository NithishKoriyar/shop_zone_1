<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include '../db_config.php';

$data = json_decode(file_get_contents("php://input"));

$uid = $connectNow->real_escape_string($data->uid);
$totalAmount = $connectNow->real_escape_string($data->totalAmount);
$orderId = $connectNow->real_escape_string($data->orderId);

// Fetch previousEarning from database
$result = $connectNow->query("SELECT earnings FROM sellers WHERE uid = '$uid'");
$previousEarningRow = $result->fetch_assoc();
$previousEarning = $previousEarningRow['earnings'];

$newEarning = $previousEarning + $totalAmount;

// Update earnings
$connectNow->query("UPDATE sellers SET earnings = '$newEarning' WHERE uid = '$uid'");

// Update order status to shifted
$connectNow->query("UPDATE orders SET status = 'shifted' WHERE orderId = '$orderId'");

echo json_encode(["status" => "success", "message" => "Updated successfully"]);

$connectNow->close();
?>
