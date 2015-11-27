<?php
	if (!isset($_SESSION['isLoggedIn'])) {
        session_start();
    }

	include 'db_connect.php';

	// do validation on the form here??

	// can only delete the post at the moment.
	// should delete all the likes that are connected to the post
	// delete all hashtags that belongs to the post

	if(isset($_GET[delete])) {
		// if delete, then delete this post.. 
		$postID = $_GET[delete];

		$query = "DELETE FROM posts WHERE id = $postID;";
		$query1 = "DELETE FROM likes WHERE postid = $postID;";
		$query2 = "DELETE from hashtags WHERE postid = $postID;";

		// vet inte varför, men gick inte att skicka alla på samma gång.. :/ 
		if(!mysql_query($query)) {
			echo mysql_error();
		}
		if(!mysql_query($query1)) {
			echo mysql_error();
		}
		if(!mysql_query($query2)) {
			echo mysql_error();
		}
	} else { // should update the form instead.. 

		// delete all the hashtags associated with the post and then add the new once to be sure..
		$user = $_SESSION['userid']; // get from the session id. ska finnas en sådan variabel.. 
		$theText = $_POST[postText]; 
		$theText = preg_replace("/'/","&#8217;", $theText);

		$query = "INSERT INTO posts (title, text, userid) 
		VALUES ('$_POST[postTitle]', '$theText', '$user');";

		if (!mysql_query($query)) {
	    	echo mysql_error();
	    }

		// take the hashtags..
		$hashtags = $_POST[postHashtags];
		// gör inte detta ifall det är tomt!! funkar det??
		if ($hashtags != "") {
			$arrayHashtags = explode(' ', $hashtags);
			foreach($arrayHashtags as $tag){
			    //echo $tag.'<br>';  
			    $query_tag = "INSERT INTO hashtags (postid, name) VALUES (LAST_INSERT_ID(), '$tag');";
			    if (!mysql_query($query_tag)) {
		    		echo mysql_error();
		    	}
			}
		} 
	}

    mysql_close();

	header("Location: index.php");
?>