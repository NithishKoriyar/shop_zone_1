<?php
// Check connection
include '../db_config.php';
// Execute the query
$result = $connectNow->query('SELECT * FROM sellers_table');

// Check if the query returned results
if ($result->num_rows > 0) {
    // Fetch all rows as an associative array
    $sellers = $result->fetch_all(MYSQLI_ASSOC);
    echo json_encode($sellers);
} else {
    echo "0 results";
}

// Close the connection
$connectNow->close();
?>
