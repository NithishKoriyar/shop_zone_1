<?php
include '../db_config.php';

$userId = $_POST['userId'];
$itemId = $_POST['itemId'];
$itemCounter = $_POST['itemCounter'];

// Fetch the price of the item using itemId
$priceQuery = "SELECT price FROM items WHERE itemId='$itemId'";
$priceResult = $connectNow->query($priceQuery);
if ($priceResult->num_rows > 0) {
    $priceRow = $priceResult->fetch_assoc();
    $itemPrice = $priceRow['price'];

    // Calculate the total price based on the itemCounter
    $totalPrice = $itemPrice * $itemCounter;

    // Check if the user already has the itemId in their cart
    $query = "SELECT cartId FROM userCart WHERE userId='$userId' AND itemId='$itemId'";
    $result = $connectNow->query($query);

    if ($result->num_rows > 0) {
        // User already has this itemId. Let's update the itemCounter and totalPrice
        $query = "UPDATE userCart SET itemCounter='$itemCounter', totalPrice='$totalPrice' WHERE userId='$userId' AND itemId='$itemId'";
    } else {
        // New item for this user. Insert it into the cart
        $query = "INSERT INTO userCart (userId, itemId, itemCounter, totalPrice) VALUES ('$userId', '$itemId', '$itemCounter', '$totalPrice')";
    }

    if ($connectNow->query($query) === TRUE) {
        echo json_encode(["message" => "Item Added successful."]);
    } else {
        echo json_encode(["message" => "Error: " . $connectNow->error]);
    }

} else {
    echo json_encode(["message" => "Error: Item price not found."]);
}

$connectNow->close();
?>
