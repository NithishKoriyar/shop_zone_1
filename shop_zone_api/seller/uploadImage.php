<?php

if (isset($_POST["data"]) && isset($_POST["name"])) {
    $data = $_POST["data"];
    $name = $_POST["name"];

    // Generate a unique name for the photo
    $uniqueName = uniqid() . '_' . $name;

    $path = "sellerProfile/" . $uniqueName;
   
    if (file_put_contents($path, base64_decode($data))) {
        $response = array("success" => true, "path" => $path);
        echo json_encode($response);
    } else {
        $response = array("success" => false, "message" => "Failed to upload image", "path" => $path);
        echo json_encode($response);
    }
} else {
    $response = array("success" => false, "message" => "Missing data or name parameters");
    echo json_encode($response);
}

?>
