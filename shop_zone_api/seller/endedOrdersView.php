<?php
header("Access-Control-Allow-Origin: *"); // For CORS
header("Content-Type: application/json; charset=UTF-8");

include '../db_config.php';

$sellerID = $_POST['sellerID'];
// Fetching data from users_orders table where orderBy matches userID and orderStatus is "normal"
$sql = "SELECT orderId, addressID, orderTime, itemQuantity, totalAmount, itemID, orderStatus FROM users_orders WHERE  orderStatus = 'ended' AND sellerUID = '$sellerID'";
$result = $connectNow->query($sql);

$orders = [];
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $itemID = $row["itemID"];
        $addressID = $row["addressID"];

        // Fetching item details from items table using itemID
        $itemSql = "SELECT * FROM items WHERE itemID = '$itemID'";
        $itemResult = $connectNow->query($itemSql);

        // Fetching address details from useraddress table using addressID
        $addressSql = "SELECT name, phoneNumber, completeAddress FROM useraddress WHERE id = '$addressID'";
        $addressResult = $connectNow->query($addressSql);
        $addressData = $addressResult->fetch_assoc();

        if ($itemResult->num_rows > 0 && $addressData) {
            while($itemRow = $itemResult->fetch_assoc()) {
                $itemRow["orderId"] = $row["orderId"];
                $itemRow["orderTime"] = $row["orderTime"];
                $itemRow["totalAmount"] = $row["totalAmount"];
                $itemRow["itemQuantity"] = $row["itemQuantity"];
                $itemRow["orderStatus"] = $row["orderStatus"]; // Include orderStatus in the result
                
                // Adding address details to the result
                $itemRow["name"] = $addressData["name"];
                $itemRow["phoneNumber"] = $addressData["phoneNumber"];
                $itemRow["completeAddress"] = $addressData["completeAddress"];
                
                $orders[] = $itemRow;
            }
        } elseif (!$addressData) {
            echo json_encode(['error' => "No address details found for addressID: $addressID."]);
            exit;  // Stop further execution
        } else {
            echo json_encode(['error' => "No item details found for itemID: $itemID."]);
            exit;  // Stop further execution
        }
    }
} else {
    echo json_encode(['error' => 'No orders found for the user.']);
    exit;  // Stop further execution
}

echo json_encode(['orders' => $orders]);

$connectNow->close();
?>
