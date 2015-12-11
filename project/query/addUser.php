<?php
	include 'db_connect.php';

	// start the session.. 
	session_start();

	// get the username and password from the form, check if the two passwords are exakt match.. (LATER CHECK; TODO!!!)
	$username = $_POST[usr];

	// when adding the username it should not be case sensitive so transform to lowercases.
	$username = strtolower($username);
	$pwd = $_POST[pwd];
	$pwd2 = $_POST[pwd2];

	// --- http://stackoverflow.com/questions/6781931/how-do-i-create-and-store-md5-passwords-in-mysql ---
	// spara inte lösenordet direkt i databasen! spara hashade lösen istället
	$escapedName = mysqli_real_escape_string($con,$username);
	$escapedPW = mysqli_real_escape_string($con,$pwd);
	# generate a random salt to use for this account
	$salt = bin2hex(mcrypt_create_iv(32, MCRYPT_DEV_URANDOM));
	$saltedPW =  $escapedPW . $salt;
	$hashedPW = hash('sha256', $saltedPW);

	// check if the username already exists! 
	$usernameQuery = "SELECT * FROM user WHERE name = '$username'";
	$userCheck = mysqli_query($con,$usernameQuery);
	if(!mysqli_query($con,$usernameQuery)) {
		echo mysqli_error();
	}

	// if we got a hit, return to the indexpage with a error message..
	if(mysqli_num_rows($userCheck) != 0) {
		$_SESSION['isLoggedIn'] = false;

		mysqli_close($con);
		header("Location: ../index.php?loginError=username");
		exit();
	}

	// skrev fel lösenord mellan inputen
	if($pwd != $pwd2) {
		$_SESSION['isLoggedIn'] = false;
		mysqli_close($con);
		header("Location: ../index.php?loginError=password");
		exit();
	}

	// frid och fröjd. kan lägga in i databasen
	$query = "INSERT INTO  user (name, pwd, salt) values ('$escapedName', '$hashedPW', '$salt'); ";
	if(!mysqli_query($con,$query)) {
		echo mysqli_error();
	}

	// get information again from the database, so that can get userID 
	$query = "SELECT * FROM user WHERE name = '$escapedName' AND pwd = '$hashedPW'";
	$result = mysqli_query($con,$query);
	$user = mysqli_fetch_assoc($result);
	
	// set session variables!!
	$_SESSION['isLoggedIn'] = true;
	$_SESSION['username'] = $user['name'];
	$_SESSION['userid'] = $user['id'];
	$_SESSION['authority'] = $user['authority'];

    mysqli_close($con);

	header("Location: ../index.php");
?>