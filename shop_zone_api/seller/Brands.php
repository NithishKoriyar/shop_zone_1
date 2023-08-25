<?php
include '../db_config.php';

$sellerID = $_GET['sellerID'];

$response = array();

$query = "SELECT * FROM brands WHERE sellerUID = '$sellerID' ORDER BY publishedDate DESC";
$result = mysqli_query($connectNow, $query);

if (mysqli_num_rows($result) > 0) {
    while ($row = mysqli_fetch_assoc($result)) {
        $response[] = $row;
    }
    echo json_encode($response);
} else {
    echo json_encode(array('error' => 'No brands exists'));
}

mysqli_close($connectNow);
?>

