<?php
include '../db_config.php';

header('Content-Type: application/json');


$uid = $_GET['uid'];
$brandID = $_GET['brandID'];


$sql = "SELECT * FROM items WHERE sellerUID = '$uid' AND brandID = '$brandID' ORDER BY publishedDate DESC";
$result = $connectNow->query($sql);

$items = [];

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $items[] = $row;
    }
    sendSuccessResponse('Data retrieved successfully', $items);
} else {
    sendErrorResponse('No data found');
}

$connectNow->close();

function sendSuccessResponse($message, $data = null) {
    $response = [
        'status' => 'success',
        'message' => $message
    ];

    if (!is_null($data)) {
        $response['data'] = $data;
    }

    echo json_encode($response);
    exit();
}

function sendErrorResponse($message) {
    $response = [
        'status' => 'error',
        'message' => $message
    ];

    echo json_encode($response);
    exit();
}

?>
