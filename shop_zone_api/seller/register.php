<?php
include '../db_config.php';

//POST = send/save data to mysql db
//GET = retrieve/read data from mysql db




$sellerName = $_POST['seller_name'];
$sellerEmail = $_POST['seller_email'];
$sellerPassword = md5($_POST['seller_password']);
$sellerImage = $_POST['seller_profile'];
$sellerPhone = $_POST['seller_phone'];
$sellerAddress = $_POST['seller_address'];


$sqlQuery = "INSERT INTO sellers_table SET seller_name = '$sellerName', seller_email = '$sellerEmail', seller_password = '$sellerPassword',  seller_profile = '$sellerImage', seller_phone='$sellerPhone',seller_address='$sellerAddress'";

$resultOfQuery = $connectNow->query($sqlQuery);

if ($resultOfQuery) {
    $selectQuery = "SELECT * FROM sellers_table WHERE seller_email = '$sellerEmail'";
    $resultOfSelectQuery = $connectNow->query($selectQuery);

    if ($resultOfSelectQuery->num_rows > 0) {
        $userRecord = array();
        while ($rowFound = $resultOfSelectQuery->fetch_assoc()) {
            $userRecord[] = $rowFound;
        }

        echo json_encode(array(
            "success" => true,
            "sellerData" => $userRecord[0]
        ));
    } else {
        echo json_encode(array("success" => false));
    }
} else {
    echo json_encode(array("success" => false));
}
?>


