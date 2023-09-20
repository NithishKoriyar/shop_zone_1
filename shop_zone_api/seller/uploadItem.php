<?php

include '../db_config.php';

$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['image']) && isset($data['itemInfo'])) {
    $imageData = $data['image'];
    $decodedImage = base64_decode($imageData);

    $filename = "items/" . uniqid() . ".jpg";
    file_put_contents($filename, $decodedImage);

    $itemInfo = $connectNow->real_escape_string($data['itemInfo']);
    $itemTitle = $connectNow->real_escape_string($data['itemTitle']);
    $itemID = $connectNow->real_escape_string($data['itemID']);
    $itemDescription = $connectNow->real_escape_string($data['itemDescription']);
    $itemPrice = $connectNow->real_escape_string($data['itemPrice']);
    $brandID = $connectNow->real_escape_string($data['brandID']);
    $sellerUID = $connectNow->real_escape_string($data['sellerUID']);
    $sellerName = $connectNow->real_escape_string($data['sellerName']);
    $filename = $connectNow->real_escape_string($filename);

    $sql = "INSERT INTO items (itemInfo, itemTitle, itemID, longDescription, price, brandID, sellerUID, sellerName, thumbnailUrl, status, publishedDate) 
            VALUES ('$itemInfo', '$itemTitle', '$itemID', '$itemDescription', '$itemPrice', '$brandID', '$sellerUID', '$sellerName', '$filename', 'available', NOW())";

    if ($connectNow->query($sql) === TRUE) {
        echo json_encode(["success" => true, "message" => "Uploaded successfully!"]);
    } else {
        echo json_encode(["success" => false, "message" => "Error: " . $connectNow->error]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Data is missing!"]);
}

$connectNow->close();

?>

