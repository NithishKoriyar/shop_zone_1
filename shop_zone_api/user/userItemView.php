<?php
include '../db_config.php';

$sellerUID = $_GET['sellerUID'];
$brandID = $_GET['brandID'];

$query = "SELECT * FROM items WHERE sellerUID = $sellerUID AND brandID = $brandID ORDER BY publishedDate DESC";
$result = $connectNow->query($query);

$items = [];
while($row = $result->fetch_assoc()) {
    $items[] = $row;
}

echo json_encode($items);

$connectNow->close();
?>
