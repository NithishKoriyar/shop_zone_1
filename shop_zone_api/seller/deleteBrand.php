<?php
include '../db_config.php';

$brandUniqueID = $connectNow->real_escape_string($_GET['brandUniqueID']);
$sellerID = $connectNow->real_escape_string($_GET['uid']);
$thumbnailUrl = $_GET['thumbnailUrl'];

$response = array(
    "status" => "",
    "message" => ""
);

// You should have a safer mechanism to determine the real path for the unlink operation.
// For now, assuming the $thumbnailUrl is a relative path:
if (unlink($thumbnailUrl)) {

    // Delete items associated with the brand
    $itemsQuery = "SELECT thumbnailUrl FROM items WHERE brandID = '$brandUniqueID'";
    $result = $connectNow->query($itemsQuery);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            unlink($row['thumbnailUrl']);
        }
    }
    
    // Delete the items from the DB
    $deleteItemsQuery = "DELETE FROM items WHERE brandID = '$brandUniqueID'";
    $connectNow->query($deleteItemsQuery);

    // Delete the brand
    $sql = "DELETE FROM brands WHERE brandID = '$brandUniqueID' AND sellerUID = '$sellerID'";
    if ($connectNow->query($sql) === TRUE) {
        $response["status"] = "success";
        $response["message"] = "Brand and image files deleted successfully.";
    } else {
        $response["status"] = "error";
        $response["message"] = "Error deleting brand: " . $connectNow->error;
    }
} else {
    $response["status"] = "error";
    $response["message"] = "Error deleting image file.";
}

echo json_encode($response);

$connectNow->close();
