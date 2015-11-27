<?php
	include 'db_connect.php';
    if (!isset($_SESSION['isLoggedIn'])) {
        session_start();
    }

    // can only like if you are logged in
    if ($_SESSION['isLoggedIn']) {
	    $userID = $_SESSION['userid']; // get from the session id. ska finnas en sådan variabel.. userID
	    $postID = $_GET[postID]; 

	    // gör en query för att se om du har gillat posten innan. om får fram 0 rader, lägg då till i databasen. annars ska du ta bort denna rad.. 

	    $query = "SELECT * FROM likes 
	    	WHERE postid = $postID AND userid = $userID";

	    // är result tom? isåfall lägg till, annars ta bort
	    $result = mysql_query($query);
		if(!mysql_query($query)) {
			echo mysql_error();
		}

		if (mysql_num_rows($result) == 0) {
			// add the like
			$query2 = "INSERT INTO likes (postid, userid)
				VALUES ($postID, $userID)"; 
		} else { // remove the like 
			$query2 = "DELETE FROM likes 
				WHERE postid = $postID AND userid = $userID";
		}

		// add or delete like.. 
		if(!mysql_query($query2)) {
			echo mysql_error();
		}

	    mysql_close();
	}

	header("Location: index.php");
	//exit();
?>