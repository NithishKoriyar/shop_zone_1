<?php
header("Access-Control-Allow-Origin: *"); // For CORS
header("Content-Type: application/json; charset=UTF-8");

include '../db_config.php';

$userID = $_POST['userID'];

$sql = "SELECT itemId, itemCounter FROM usercart WHERE userId = '$userID'"; // Fetching itemIDs and itemCounter for user from cart table
$result = $connectNow->query($sql);

$items = [];
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $itemID = $row["itemId"];
        $itemCounter = $row["itemCounter"];
        
        $itemSql = "SELECT * FROM items WHERE itemID = '$itemID'"; // Fetching item details from items table
        $itemResult = $connectNow->query($itemSql);
        if ($itemResult->num_rows > 0) {
            while($itemRow = $itemResult->fetch_assoc()) {
                $itemRow["itemCounter"] = $itemCounter; // Adding itemCounter to item details
                $items[] = $itemRow;
            }
        }
    }
}

echo json_encode($items);

$connectNow->close();
?>
