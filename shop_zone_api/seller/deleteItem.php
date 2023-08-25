<?php
include '../db_config.php';

$brandUniqueID = $_GET['brandUniqueID'];
$itemID = $_GET['itemID'];
$sellerID = $_GET['uid'];
$thumbnailUrl = $_GET['thumbnailUrl'];


$response = array(
    "status" => "",
    "message" => ""
);

// Delete the file from server
if (unlink($thumbnailUrl)) {
    $sql = "DELETE FROM items WHERE brandID = '$brandUniqueID' AND itemID  = '$itemID' AND sellerUID = '$sellerID'";

    if ($connectNow->query($sql) === TRUE) {
        $response["status"] = "success";
        $response["message"] = "Brand and image file deleted successfully.";
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
?>
