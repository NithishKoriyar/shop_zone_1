<?php
include '../db_config.php';

//POST = send/save data to mysql db
//GET = retrieve/read data from mysql db

$userName = $_POST['user_name'];
$userEmail = $_POST['user_email'];
$userPassword = md5($_POST['user_password']); 
$profilePic = $_POST['user_profile'];


$userName = $_POST['user_name'];
$userEmail = $_POST['user_email'];
$userPassword = md5($_POST['user_password']);
$userImage = $_POST['user_profile'];

$sqlQuery = "INSERT INTO users_table SET user_name = '$userName', user_email = '$userEmail', user_password = '$userPassword',  user_profile = '$userImage'";

$resultOfQuery = $connectNow->query($sqlQuery);

if ($resultOfQuery) {
    $selectQuery = "SELECT * FROM users_table WHERE user_email = '$userEmail'";
    $resultOfSelectQuery = $connectNow->query($selectQuery);

    if ($resultOfSelectQuery->num_rows > 0) {
        $userRecord = array();
        while ($rowFound = $resultOfSelectQuery->fetch_assoc()) {
            $userRecord[] = $rowFound;
        }

        echo json_encode(array(
            "success" => true,
            "userData" => $userRecord[0]
        ));
    } else {
        echo json_encode(array("success" => false));
    }
} else {
    echo json_encode(array("success" => false));
}
?>


