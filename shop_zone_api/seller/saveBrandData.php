<?php
include '../db_config.php';

$response = array();

$brandInfo = $_POST['brandInfo'];
$brandTitle = $_POST['brandTitle'];
$brandID = $_POST['brandID'];
$sellerUID = $_POST['sellerUID'];
$thumbnailUrl = $_POST['thumbnailUrl'];

$sql = "INSERT INTO brands (brandInfo, brandTitle, brandID, sellerUID, thumbnailUrl, publishedDate, status) VALUES (?, ?, ?, ?, ?, NOW(), 'available')";

$stmt = $connectNow->prepare($sql);
$stmt->bind_param("sssss", $brandInfo, $brandTitle, $brandID, $sellerUID, $thumbnailUrl);

if ($stmt->execute()) {
    $response["status"] = "success";
} else {
    $response["status"] = "error";
    $response["message"] = "Error: " . $sql . "<br>" . $connectNow->error;
}

echo json_encode($response);
$stmt->close();
$connectNow->close();
?>
