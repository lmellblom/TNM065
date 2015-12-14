<?php
    include 'db_connect.php';

	session_unset();
    // destroy the old session
    session_destroy();
    // start a new session
    session_start();

	// get the username and password from the form
	$username = $_POST[usr];
	$username = strtolower($username); // transform to lowercase in order to avoid case sensitiv!
	$pwd = $_POST[pwd];

	// --- http://stackoverflow.com/questions/6781931/how-do-i-create-and-store-md5-passwords-in-mysql ---
	// saved hashed passwords instead
	$escapedName = mysqli_real_escape_string($con,$username);
	$escapedPW = mysqli_real_escape_string($con,$pwd);

	$saltQuery = "SELECT salt FROM user WHERE name = '$escapedName';";
	$result = mysqli_query($con,$saltQuery);
	if(!mysqli_query($con,$result)) {
		echo mysqli_error();
	}
	
	$row = mysqli_fetch_assoc($result);
	$salt = $row['salt'];
	$saltedPW =  $escapedPW . $salt;
	$hashedPW = hash('sha256', $saltedPW);

	// get information again from the database
	$query = "SELECT * FROM user WHERE name = '$escapedName' AND pwd = '$hashedPW'";
	$result = mysqli_query($con,$query);
	if(!mysqli_query($con,$query)) {
		echo mysqli_error();
	}

	// check if we got a match in the log in process?? 
	if(mysqli_num_rows($result) != 0) {
		$user = mysqli_fetch_assoc($result);
		// set session variables!!
		$_SESSION['isLoggedIn'] = true;
		$_SESSION['username'] = $user['name'];
		$_SESSION['userid'] = $user['id'];
		$_SESSION['authority'] = $user['authority'];

	} else {
		// do something here. like give a error message. TODO
		$_SESSION['isLoggedIn'] = false;
		
		mysqli_close($con);
		header("Location: ../login.php?loginError=noMatch");
		exit();
	}

    mysqli_close($con);

	header("Location: ../index.php");
	//exit();
?>