<?php
include '../db_config.php';
$userEmail = $_POST['seller_email'];
$userPassword = md5($_POST['seller_password']);

$sqlQuery = "SELECT * FROM sellers_table WHERE seller_email = '$userEmail' AND seller_password = '$userPassword'";

$resultOfQuery = $connectNow->query($sqlQuery);

if ($resultOfQuery->num_rows > 0) //allow user to login 
{
    $userRecord = array();
    while ($rowFound = $resultOfQuery->fetch_assoc()) {
        $userRecord[] = $rowFound;
    }

    echo json_encode(array(
        "success" => true,
        "sellerData" => $userRecord[0]
    ));
} else //Do NOT allow user to login 
{
    echo json_encode(array("success" => false));
}
