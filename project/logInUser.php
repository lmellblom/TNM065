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

	// get information again from the database
	$query = "SELECT * FROM user WHERE name = '$username' AND pwd = '$pwd'";
	$result = mysql_query($query);
	if(!mysql_query($query)) {
		echo mysql_error();
	}

	// check if we got a match in the log in process?? 
	if(mysql_num_rows($result) != 0) {
		$user = mysql_fetch_assoc($result);
		// set session variables!!
		$_SESSION['isLoggedIn'] = true;
		$_SESSION['username'] = $user['name'];
		$_SESSION['userid'] = $user['id'];
		$_SESSION['authority'] = $user['authority'];

	} else {
		// do something here. like give a error message. TODO
		$_SESSION['isLoggedIn'] = false;
		
		mysql_close();
		header("Location: index.php?loginError=noMatch");
		exit();
	}

    mysql_close();

	header("Location: index.php");
	//exit();
?>