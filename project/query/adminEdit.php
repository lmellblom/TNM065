<?php
    include 'db_connect.php';

    // start the session
    session_start();

    // get the userid
    $userid = $_GET[userid];
    // get the values from the form, if password is empty or just spaces, do not update that!
    $username = $_POST[userName];
    $userpwd = $_POST[pwd];
    $userauth = $_POST[auth]; // 0 or 1

    // check if logged in and admin
    if ($_SESSION['isLoggedIn'] && 	$_SESSION['authority']==0) { 

    	// if the password is not empty and no spaces then update the salt and the password
    	if($userpwd != "") {
	    	$escapedPW = mysqli_real_escape_string($con,$userpwd);
	    	# generate a random salt to use for this account
			$salt = bin2hex(mcrypt_create_iv(32, MCRYPT_DEV_URANDOM));
			$saltedPW =  $escapedPW . $salt;
			$hashedPW = hash('sha256', $saltedPW);
			// then update the salt and pwd in the database with the new value
			$query = "UPDATE user SET pwd='$hashedPW', salt='$salt' WHERE id = $userid";
			if(!mysqli_query($con,$query)) {
				echo mysqli_error();
			}
		}

		// update authority and update user name
		$username = strtolower($username);
		$escapedName = mysqli_real_escape_string($con,$username);
		$updateQuery = "UPDATE user SET name = '$escapedName', authority = '$userauth' 
						WHERE id = $userid";
		if(!mysqli_query($con,$updateQuery)) {
			echo mysqli_error();
		}

    } else {
    	mysqli_close($con);
    	header("Location: ../admin.php?message=error?");
		exit();
    }

    mysqli_close($con);

	header("Location: ../admin.php?message=successful");
	//exit();
?>