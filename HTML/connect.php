<?php
    
    if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['submit'])) {
        echo "Test1";
        $conn= mysqli_connect('localhost', 'root', '', 'database_1') or die ("Connection Failed:" .mysql_connect_error());
        echo "Test2";
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
        // $conn->close();
    }

?>