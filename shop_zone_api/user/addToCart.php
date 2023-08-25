<?php
include '../db_config.php';

$userId = $_POST['userId'];
$itemId = $_POST['itemId'];
$itemCounter = $_POST['itemCounter'];

// Check if the user already has the itemId in their cart
$query = "SELECT cartId FROM userCart WHERE userId='$userId' AND itemId='$itemId'";
$result = $connectNow->query($query);

if ($result->num_rows > 0) {
    // User already has this itemId. Let's update the itemCounter
    $query = "UPDATE userCart SET itemCounter='$itemCounter' WHERE userId='$userId' AND itemId='$itemId'";
} else {
    // New item for this user. Insert it into the cart
    $query = "INSERT INTO userCart (userId, itemId, itemCounter) VALUES ('$userId', '$itemId', '$itemCounter')";
}

if ($connectNow->query($query) === TRUE) {
    echo json_encode(["message" => "Item Added successful."]);
} else {
    echo json_encode(["message" => "Error: " . $connectNow->error]);
}

$connectNow->close();
?>
