<?php
	if (!isset($_SESSION['isLoggedIn'])) {
        session_start();
    }

	include 'db_connect.php';

	// do validation on the form here??

	if(isset($_GET[delete])) {
		// if delete, then delete this post, all the likes that are connected to the post and also the hashtags. 
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
		$postID = $_GET[postID];

		$query = "UPDATE posts SET title='$_POST[postTitle]', text='$_POST[postText]' WHERE id = $postID";
		if (!mysql_query($query)) {
	    	echo mysql_error();
	    }

	    // delete all the hashtags
	    $deleteHashtagsquery = "DELETE FROM hashtags WHERE postid = $postID;";
	    if(!mysql_query($deleteHashtagsquery)) {
			echo mysql_error();
		}

		// updatera hashtagsen, gör så att jag deletar alla som finns i databasen tillhörande postID och sen lägger till igen på samma sätt som i add post

		// TODO: kan råka lägga till mellanslag som hashtags.. inte så bra!

		$hashtags = $_POST[postHashtags];
		// gör inte detta ifall det är tomt!! funkar det??
		if ($hashtags != "") {
			$arrayHashtags = explode(' ', $hashtags);
			foreach($arrayHashtags as $tag){
			    //echo $tag.'<br>';  
			    $query_tag = "INSERT INTO hashtags (postid, name) VALUES ($postID, '$tag');";
			    if (!mysql_query($query_tag)) {
		    		echo mysql_error();
		    	}
			}
		}
	}

    mysql_close();

	header("Location: index.php");
?>