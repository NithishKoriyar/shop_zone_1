<?php
header("Access-Control-Allow-Origin: *"); // For CORS
header("Content-Type: application/json; charset=UTF-8");

include '../db_config.php';

$userID = $_POST['userID'];

// Fetching itemIDs, itemCounter, and totalPrice for user from cart table
$sql = "SELECT cartId, itemId, itemCounter, totalPrice FROM usercart WHERE userId = '$userID'";
$result = $connectNow->query($sql);

$items = [];
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $itemID = $row["itemId"];
        $itemCounter = $row["itemCounter"];
        $totalPrice = $row["totalPrice"];
        $cartId = $row["cartId"];
        
        // Fetching item details from items table
        $itemSql = "SELECT * FROM items WHERE itemID = '$itemID'";
        $itemResult = $connectNow->query($itemSql);
        if ($itemResult->num_rows > 0) {
            while($itemRow = $itemResult->fetch_assoc()) {
                $itemRow["itemCounter"] = $itemCounter; // Adding itemCounter to item details
                $itemRow["totalPrice"] = $totalPrice; // Adding totalPrice to item details
                $itemRow["cartId"] = $cartId; // Adding cartId to item details
                $items[] = $itemRow;
            }
        }
    }
}

echo json_encode($items);

$connectNow->close();
?>
