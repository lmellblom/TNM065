<?php
	include 'db_connect.php';

	// start the session.. 
	session_start();

	// get the username and password from the form, check if the two passwords are exakt match.. (LATER CHECK; TODO!!!)
	$username = $_POST[usr];
	$pwd = $_POST[pwd];
	$pwd2 = $_POST[pwd2];

	$query = "INSERT INTO user (name,pwd)
		VALUES ('$username','$pwd')";

	// TODO, look up so no name and password is the same in the database.. 
	// later issue
	
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