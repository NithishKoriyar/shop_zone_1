<?php
include '../db_config.php';
// Get the search term from request
$textEnteredbyUser = $_GET['searchTerm'];

// Fetch sellers based on the search term
$sql = "SELECT * FROM sellers_table WHERE seller_name LIKE '$textEnteredbyUser%'";
$result = $connectNow->query($sql);

$data = [];

if ($result->num_rows > 0) {
    // Fetch all rows as associative array
    $data = $result->fetch_all(MYSQLI_ASSOC);
}

// Return data as JSON
echo json_encode($data);

$connectNow->close();
?>
