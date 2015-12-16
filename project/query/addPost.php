<?php
	if (!isset($_SESSION['isLoggedIn'])) {
        session_start();
    }

	include 'db_connect.php';

	// get the information from the form and the userid from the session
	$user = $_SESSION['userid']; 
	$theText = $_POST[postText]; 
	$theText = preg_replace("/'/","&#8217;", $theText);

	// do the query
	$query = "INSERT INTO posts (title, text, userid) 
	VALUES ('$_POST[postTitle]', '$theText', '$user');";

	if (!mysqli_query($con,$query)) {
    	echo mysqli_error();
    }

	// save if the user have added hashtags
	$hashtags = $_POST[postHashtags];
	// do not add if the form is empty
	if ($hashtags != "") {
		$arrayHashtags = explode(' ', $hashtags);
		foreach($arrayHashtags as $tag){
		    $query_tag = "INSERT INTO hashtags (postid, name) VALUES (LAST_INSERT_ID(), '$tag');";
		    if (!mysqli_query($con,$query_tag)) {
	    		echo mysqli_error();
	    	}
		}
	}

    mysqli_close($con);

	header("Location: ../index.php");
?>