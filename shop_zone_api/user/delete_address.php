<?php
// Include your database connectNow code here
include '../db_config.php';
// Check if address_id is provided
if (isset($_POST['address_id'])) {
    $addressID = $_POST['address_id'];

    // Perform the delete operation
    $query = "DELETE FROM useraddress WHERE id = $addressID";

    if (mysqli_query($connectNow, $query)) {
        // Deletion was successful
        echo "Address deleted successfully";
    } else {
        // Error occurred during deletion
        echo "Error: " . mysqli_error($connectNow);
    }
} else {
    // address_id is not provided
    echo "Invalid request";
}
?>
