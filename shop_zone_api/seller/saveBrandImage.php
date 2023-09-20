<?php
$data = $_POST['thumbnailUrl'];
// You might want to use a better method to generate a unique filename
$filename = uniqid() . ".jpg";

// Extract base64 content from POST data and decode
$image = base64_decode($data);

// Check if the decoding was successful
if ($image === false) {
    echo json_encode(['status' => 'error', 'message' => 'Failed to decode base64 image.']);
    exit();
}

// Store the image on the server
$path = 'Brands/' . $filename; // Modify 'uploads/' to your desired directory
$success = file_put_contents($path, $image);

if ($success) {
    echo json_encode(['status' => 'success', 'imageUrl' => $path]);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Failed to save image.']);
}
