<?php
// connect to the database
include '../db_config.php';

$userID = $_POST['userId'];
$itemID = $_POST['itemId'];

$query = "DELETE FROM usercart WHERE userId = '$userID' AND itemId = '$itemID'";
$result = mysqli_query($connectNow, $query);

if($result) {
    echo "Item deleted successfully!";
} else {
    echo "Failed to delete the item!";
}
?>
