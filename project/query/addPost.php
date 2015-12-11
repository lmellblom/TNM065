<?php
	if (!isset($_SESSION['isLoggedIn'])) {
        session_start();
    }

	include 'db_connect.php';

	// do validation on the form here??

	$user = $_SESSION['userid']; // get from the session id. ska finnas en sådan variabel.. 
	$theText = $_POST[postText]; 
	$theText = preg_replace("/'/","&#8217;", $theText);

	$query = "INSERT INTO posts (title, text, userid) 
	VALUES ('$_POST[postTitle]', '$theText', '$user');";

	if (!mysqli_query($con,$query)) {
    	echo mysqli_error();
    }

	// take the hashtags..
	$hashtags = $_POST[postHashtags];
	// gör inte detta ifall det är tomt!! funkar det??
	if ($hashtags != "") {
		$arrayHashtags = explode(' ', $hashtags);
		foreach($arrayHashtags as $tag){
		    //echo $tag.'<br>';  
		    $query_tag = "INSERT INTO hashtags (postid, name) VALUES (LAST_INSERT_ID(), '$tag');";
		    if (!mysqli_query($con,$query_tag)) {
	    		echo mysqli_error();
	    	}
		}
	}

    mysqli_close($con);

	header("Location: ../index.php");
?>