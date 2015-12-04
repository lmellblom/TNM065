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

	// check if the username already exists! 
	$usernameQuery = "SELECT * FROM user WHERE name = '$username'";
	$userCheck = mysql_query($usernameQuery);
	if(!mysql_query($usernameQuery)) {
		echo mysql_error();
	}
	// if we got a hit, return to the indexpage with a error message..
	if(mysql_num_rows($userCheck) != 0) {
		$_SESSION['isLoggedIn'] = false;

		mysql_close();
		header("Location: index.php?loginError=username");
		exit();
	}

	// frid och fröjd. kan lägga in i databasen
	$query = "INSERT INTO user (name,pwd)
		VALUES ('$username','$pwd')";	

	if(!mysql_query($query)) {
		echo mysql_error();
	}

	// get information again from the database, so that can get userID 
	$query = "SELECT * FROM user WHERE name = '$username' AND pwd = '$pwd'";
	$result = mysql_query($query);
	$user = mysql_fetch_assoc($result);
	
	// set session variables!!
	$_SESSION['isLoggedIn'] = true;
	$_SESSION['username'] = $user['name'];
	$_SESSION['userid'] = $user['id'];
	$_SESSION['authority'] = $user['authority'];

    mysql_close();

	header("Location: index.php");
?>