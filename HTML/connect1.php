<?php

$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$bgroup = $_POST['bgroup'];

// $servername = "databasefp.cm6htjqaiy1e.us-east-1.rds.amazonaws.com";
// $username = "maynaDB";
// $password = "12345678";
// $dbname = "database_1";
// $dbport = "3306";

// Create connection
echo phpinfo();
echo "test1";


//$conn = new mysqli($servername, $username, $password, $dbname, $dbport);
echo "test 2";

// Chaeck connection
if ($conn->connect_error) {
    echo "test3";
    die("Connection failed: ". $conn->connect_error);
}
echo "Connected successfully";
$conn = new mysqli("databasefp.cm6htjqaiy1e.us-east-1.rds.amazonaws.com", "marynaDB", "12345678", "database_1", "3306");
$sql= "INSERT INTO `users` (`name`, `email`, `phone`, `bgroup`)  VALUES ('$name', '$email', '$phone', '$bgroup')";

if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
  } else {
    echo "Error: " . $sql . "<br>" . $conn->error;
  }

  $conn->close();

?>