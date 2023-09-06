<?php
include '../db_config.php';

$uid = $_GET['uid'];

$sql = "SELECT earnings FROM sellers_table WHERE seller_id = '$uid'";
$result = $connectNow->query($sql);

if ($result->num_rows > 0) {
    // Output data of the row
    $row = $result->fetch_assoc();
    echo json_encode(['earnings' => $row['earnings']]);
} else {
    echo json_encode(['error' => 'No data found']);
}

$connectNow->close();
?>
