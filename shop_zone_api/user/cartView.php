<?php
header("Access-Control-Allow-Origin: *"); // For CORS
header("Content-Type: application/json; charset=UTF-8");

include '../db_config.php';

$userID = $_POST['userID'];

$sql = "SELECT itemId FROM usercart WHERE userId = '$userID'"; // Fetching itemIDs for user from cart table
$result = $connectNow->query($sql);

$items = [];
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $itemID = $row["itemId"];
        $itemSql = "SELECT * FROM items WHERE itemID = '$itemID'"; // Fetching item details from items table
        $itemResult = $connectNow->query($itemSql);
        if ($itemResult->num_rows > 0) {
            while($itemRow = $itemResult->fetch_assoc()) {
                $items[] = $itemRow;
            }
        }
    }
}

echo json_encode($items);

$connectNow->close();
?>
