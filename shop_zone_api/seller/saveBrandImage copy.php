<?php
$target_dir = "Brands/";  // Directory to save the uploaded files

// Extract the file extension from the original file name
$file_extension = pathinfo($_FILES["thumbnailUrl"]["name"], PATHINFO_EXTENSION);

// Create a unique filename using the current date and time
$filename = date('YmdHis') . "." . $file_extension;  // Format: YYYYMMDDHHMMSS.ext

$target_file = $target_dir . $filename;

$response = array();

if (move_uploaded_file($_FILES["thumbnailUrl"]["tmp_name"], $target_file)) {
    $response["status"] = "success";
    $response["imageUrl"] = $target_file; // You can use a full path if needed
} else {
    $response["status"] = "error";
    $response["message"] = "Sorry, there was an error uploading your file.";
}

echo json_encode($response);
?>
