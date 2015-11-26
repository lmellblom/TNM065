<?php
	include 'db_connect.php';

	// do validation on the form here??

	$user = 1; // ändra senare, hämtar alltså userID och lägger till i posten..
	// lägg till datum som den skrevs, alltså hämta dagens datum
	$theText = $_POST[postText]; 
	$theText = preg_replace("/'/","&#8217;", $theText);

	$query = "INSERT INTO posts (title, text, userid) 
	VALUES ('$_POST[postTitle]', '$theText', '$user');";

	if (!mysql_query($query)) {
    	echo mysql_error();
    }

	// take the hashtags..
	$hashtags = $_POST[postHashtags];
	$arrayHashtags = explode(' ', $hashtags);

	foreach($arrayHashtags as $tag){
	    //echo $tag.'<br>';  
	    $query_tag = "INSERT INTO hashtags (postid, name) VALUES (LAST_INSERT_ID(), '$tag');";
	    if (!mysql_query($query_tag)) {
    		echo mysql_error();
    }
	}

	//$queryOut = $query . $query_tag; 

	//echo $queryOut;
	
    //if (!mysql_query($queryOut)) {
   // 	echo mysql_error();
    //}

    mysql_close();

	header("Location: index.php");
?>