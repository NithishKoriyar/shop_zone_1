<?php
include '../db_config.php';

$postdata = file_get_contents("php://input");
if(isset($postdata) && !empty($postdata)) {
    $request = json_decode($postdata);
    
    $stmt = $connectNow->prepare("INSERT INTO useraddress (uid, name, phoneNumber, streetNumber, flatHouseNumber, city, stateCountry, completeAddress) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("ssssssss", $request->uid, $request->name, $request->phoneNumber, $request->streetNumber, $request->flatHouseNumber, $request->city, $request->stateCountry, $request->completeAddress);
    
    if($stmt->execute()) {
        echo json_encode(["message" => "New Shipment Address has been saved."]);
    } else {
        echo json_encode(["message" => "Error saving address."]);
    }
}
?>
