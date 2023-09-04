<?php
header("Access-Control-Allow-Origin: *"); // For CORS
header("Content-Type: application/json; charset=UTF-8");

include '../db_config.php';

$userID = $_POST['userID'];

// Use prepared statements to avoid SQL injection
$stmt = $connectNow->prepare("SELECT orderId, addressID, orderTime, itemQuantity, totalAmount, itemID, orderStatus FROM users_orders WHERE orderBy = ? AND orderStatus = 'normal'");
$stmt->bind_param("s", $userID);
$stmt->execute();

$result = $stmt->get_result();
$orders = [];

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $itemID = $row["itemID"];
        $addressID = $row["addressID"];
        
        $itemStmt = $connectNow->prepare("SELECT * FROM items WHERE itemID = ?");
        $itemStmt->bind_param("s", $itemID);
        $itemStmt->execute();
        $itemResult = $itemStmt->get_result();

        $addressStmt = $connectNow->prepare("SELECT name, phoneNumber, completeAddress FROM useraddress WHERE id = ?");
        $addressStmt->bind_param("s", $addressID);
        $addressStmt->execute();
        $addressData = $addressStmt->get_result()->fetch_assoc();

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
        } else {
            $errors = [];
            if (!$addressData) {
                $errors[] = "No address details found for addressID: $addressID.";
            }
            if ($itemResult->num_rows == 0) {
                $errors[] = "No item details found for itemID: $itemID.";
            }
            echo json_encode(['errors' => $errors]);
            exit;
        }
    }
} else {
    echo json_encode(['error' => 'No orders found for the user.']);
    exit;
}

echo json_encode(['orders' => $orders]);

$connectNow->close();
?>
