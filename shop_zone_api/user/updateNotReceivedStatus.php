<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include '../db_config.php';

$data = json_decode(file_get_contents("php://input"));

$orderId = $connectNow->real_escape_string($data->orderId);

$connectNow->query("UPDATE users_orders SET orderStatus = 'ended' WHERE orderId = '$orderId'");

echo json_encode(["status" => "success", "message" => "Confirmed successfully"]);

$connectNow->close();
?>
