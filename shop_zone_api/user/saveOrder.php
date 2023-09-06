<?php

header('Content-Type: application/json');

include '../db_config.php';

// Assuming POST data is sent as JSON
$data = json_decode(file_get_contents('php://input'), true);

$response = [];

$query = sprintf("INSERT INTO users_orders (addressID, totalAmount, orderBy, productIDs, paymentDetails, orderTime, orderId, isSuccess, sellerUID, orderStatus, itemQuantity, itemID) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')",
    $connectNow->real_escape_string($data["addressID"]),
    $connectNow->real_escape_string($data["totalAmount"]),
    $connectNow->real_escape_string($data["orderBy"]),
    $connectNow->real_escape_string($data["productIDs"]),
    $connectNow->real_escape_string($data["paymentDetails"]),
    $connectNow->real_escape_string($data["orderTime"]),
    $connectNow->real_escape_string($data["orderId"]),
    $connectNow->real_escape_string($data["isSuccess"]),
    $connectNow->real_escape_string($data["sellerUID"]),
    $connectNow->real_escape_string($data["status"]),
    $connectNow->real_escape_string($data["itemQuantity"]),
    $connectNow->real_escape_string($data["itemID"])
);

if ($connectNow->query($query) === TRUE) {
    $response['success'] = true;
    $response['message'] = "Order saved successfully!";
} else {
    $response['success'] = false;
    $response['message'] = "Error: " . $query . "<br>" . $connectNow->error;
}

echo json_encode($response);
$connectNow->close();
