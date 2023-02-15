<?php
    
    if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['submit'])) {
        $conn= mysqli_connect('database1.cm6htjqaiy1e.us-east-1.rds.amazonaws.com', 'maynaDB', '12345678', 'database_1') or die ("Connection Failed:" .mysql_connect_error());
        if(isset($_POST['name']) && isset($_POST['email']) && isset($_POST['phone']) && isset($_POST['bgroup'])) {
            $name= $_POST['name'];
            $email= $_POST['email'];
            $phone= $_POST['phone'];
            $bgroup= $_POST['bgroup'];

            $sql= "INSERT INTO `users` (`name`, `email`, `phone`, `bgroup`)  VALUES ('$name', '$email', '$phone', '$bgroup')";

            $query = mysqli_query($conn,$sql);
            if($query) {
                echo 'Entry Successfull';
            }
            else {
                echo 'Error Occurred';
            }
        }
        $conn->close();
    }

?>