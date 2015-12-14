<?php 
	include 'db_connect.php';
	if (!isset($_SESSION['isLoggedIn'])) {
        session_start();
    }

    // can only like if you are logged in
    if ($_SESSION['isLoggedIn']) {
    	$userID = $_SESSION['userid']; // can only change your profilepic 
    	$picID = $_GET['picture'];

		$query = "UPDATE user SET picture = $picID WHERE id = $userID";
		echo $query;
		if(!mysqli_query($con,$query)) {
			echo mysqli_error();
		}
		mysqli_close($con);
	}
	exit();
?>