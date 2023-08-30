<?php
include '../db_config.php';

$data = json_decode(file_get_contents("php://input"));

$addressID = mysqli_real_escape_string($connectNow, $data->addressID);
$totalAmount = mysqli_real_escape_string($connectNow, $data->totalAmount);
$orderBy = mysqli_real_escape_string($connectNow, $data->orderBy);
$productIDs = mysqli_real_escape_string($connectNow, json_encode($data->productIDs));  // since this is a list in Flutter
$paymentDetails = mysqli_real_escape_string($connectNow, $data->paymentDetails);
$orderTime = mysqli_real_escape_string($connectNow, $data->orderTime);
$orderId = mysqli_real_escape_string($connectNow, $data->orderId);
$isSuccess = mysqli_real_escape_string($connectNow, $data->isSuccess);
$sellerUID = mysqli_real_escape_string($connectNow, $data->sellerUID);
$status = mysqli_real_escape_string($connectNow, $data->status);

$sql = "INSERT INTO users_orders (orderId, addressID, totalAmount, orderBy, productIDs, paymentDetails, orderTime, isSuccess, sellerUID, status) 
        VALUES ('$orderId', '$addressID', $totalAmount, '$orderBy', '$productIDs', '$paymentDetails', '$orderTime', $isSuccess, '$sellerUID', '$status')";

$result = $connectNow->query($sql);

if ($result) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false, "error" => $connectNow->error]);
}

$connectNow->close();
?>
