<?php
include('../db_config.php');


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Check if file was uploaded
    if(isset($_FILES['thumbnailUrl']) && $_FILES['thumbnailUrl']['error'] === 0) {
        $uploadDir = 'Brands/';

        // Get the original name and extension
        $originalFileName = basename($_FILES['thumbnailUrl']['name']);
        $file_extension = pathinfo($originalFileName, PATHINFO_EXTENSION);
        
        // Generate a unique name based on current date and time
        $new_file_name = date('YmdHis') . rand(100, 999) . "." . $file_extension;
        
        // Create the full path for the uploaded file with the new name
        $uploadedFile = $uploadDir . $new_file_name;

        // Move the file to the specified directory
        if(move_uploaded_file($_FILES['thumbnailUrl']['tmp_name'], $uploadedFile)) {
            // File upload successful
            $brandInfo = $connectNow->real_escape_string($_POST['brandInfo']);
            $brandTitle = $connectNow->real_escape_string($_POST['brandTitle']);
            $brandUniqueId = $connectNow->real_escape_string($_POST['brandID']);  // Assuming brandID is your unique ID
            $sellerUID = $connectNow->real_escape_string($_POST['sellerUID']);

            // Create SQL
            // $sql = "INSERT INTO brands (brandID, brandInfo, brandTitle, publishedDate, sellerUID, status, thumbnailUrl)
            //         VALUES ('$brandUniqueId','$brandInfo', '$brandTitle', NOW() , '$sellerUID', 'available', '$uploadedFile')";
            $sql = "INSERT INTO brands (brandID, brandInfo, brandTitle, publishedDate, sellerUID, status, thumbnailUrl)
            VALUES ('$brandUniqueId','$brandInfo', '$brandTitle', NOW() , '$sellerUID', 'available', '$uploadedFile')";

            // Execute the query
            if ($connectNow->query($sql) === TRUE) {
                echo json_encode(['status' => 'success']);
            } else {
                echo json_encode(['status' => 'failed', 'message' => 'Database insertion error.']);
            }
        } else {
            echo json_encode(['status' => 'failed', 'message' => 'File upload failed.']);
        }
    } else {
        echo json_encode(['status' => 'failed', 'message' => 'No file uploaded.']);
    }
} else {
    echo json_encode(['status' => 'failed', 'message' => 'Invalid request.']);
}

// Close the connection
$connectNow->close();
?>


