<?php

$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$bgroup = $_POST['bgroup'];

$servername = "databasefp.cm6htjqaiy1e.us-east-1.rds.amazonaws.com";
$username = "maynaDB";
$password = "12345678";
$dbname = "database_1";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Chaeck connection
if ($conn->connect_error) {
    die("Connection failed: ". $conn->connect_error);
}
echo "Connected successfully";

$sql= "INSERT INTO `users` (`name`, `email`, `phone`, `bgroup`)  VALUES ('$name', '$email', '$phone', '$bgroup')";

if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
  } else {
    echo "Error: " . $sql . "<br>" . $conn->error;
  }

  $conn->close();

?>