<?php
include '../db_config.php';

$userId = $_POST['userId'];

$query = "DELETE FROM usercart WHERE userId='$userId'";

if ($connectNow->query($query) === TRUE) {
    echo json_encode(["message" => "Cart cleared successfully."]);
} else {
    echo json_encode(["message" => "Error: " . $connectNow->error]);
}

$connectNow->close();
?>
