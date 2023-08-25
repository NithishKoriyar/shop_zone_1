<?php
include '../db_config.php';

$itemInfo = $_POST['itemInfo'];
$itemTitle = $_POST['itemTitle'];
$itemDescription = $_POST['itemDescription'];
$itemPrice = $_POST['itemPrice'];
$itemID = $_POST['itemID'];
$brandID = $_POST['brandID'];
$sellerUID = $_POST['sellerUID'];
$sellerName = $_POST['sellerName'];

if(isset($_FILES['image'])){
    $file_name = $_FILES['image']['name'];
    $file_tmp = $_FILES['image']['tmp_name'];
    
    // Get the file extension (like jpg, png, etc.)
    $file_extension = pathinfo($file_name, PATHINFO_EXTENSION);
    
    // Generate a unique name based on the current date and time
    $new_file_name = date('YmdHis') . rand(100, 999) . "." . $file_extension;
    
    // Move the uploaded file to the new location
    move_uploaded_file($file_tmp, "items/" . $new_file_name);
    
    // Create the thumbnail URL
    $thumbnailUrl = "items/" . $new_file_name;

    $stmt = $connectNow->prepare("INSERT INTO items (brandID, itemID, sellerUID, sellerName, itemInfo, itemTitle, longDescription, price, publishedDate, status, thumbnailUrl) VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), 'available', ?)");
    $stmt->bind_param("sssssssss", $brandID, $itemID, $sellerUID, $sellerName, $itemInfo, $itemTitle, $itemDescription, $itemPrice, $thumbnailUrl);
    
    if($stmt->execute()){
        echo json_encode(["success" => true, "message" => "Item uploaded successfully!"]);
    } else {
        echo json_encode(["success" => false, "message" => "Error uploading item."]);
    }
    $stmt->close();
} else {
    echo json_encode(["success" => false, "message" => "No image received."]);
}
$connectNow->close();
?>
