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
		if(!mysqli_query($con,$query)) {
			echo mysqli_error();
		}
		if(!mysqli_query($con,$query1)) {
			echo mysqli_error();
		}
		if(!mysqli_query($con,$query2)) {
			echo mysqli_error();
		}
	} else { // should update the form instead.. 
		$postID = $_GET[postID];

		$query = "UPDATE posts SET title='$_POST[postTitle]', text='$_POST[postText]' WHERE id = $postID";
		if (!mysqli_query($con,$query)) {
	    	echo mysqli_error();
	    }

	    // delete all the hashtags
	    $deleteHashtagsquery = "DELETE FROM hashtags WHERE postid = $postID;";
	    if(!mysqli_query($con,$deleteHashtagsquery)) {
			echo mysqli_error();
		}

		// updatera hashtagsen, gör så att jag deletar alla som finns i databasen tillhörande postID och sen lägger till igen på samma sätt som i add post
		$hashtags = $_POST[postHashtags];
		// do not do this if the hashtag is empty
		if ($hashtags != "") {
			$arrayHashtags = explode(' ', $hashtags);
			foreach($arrayHashtags as $tag){
			    if ($tag != ""){ // do not add a empty hashtag.
				    $query_tag = "INSERT INTO hashtags (postid, name) VALUES ($postID, '$tag');";
				    if (!mysqli_query($con,$query_tag)) {
			    		echo mysqli_error();
			    	}
		    	}
			}
		}
	}

    mysqli_close($con);

	header("Location: ../index.php");
?>