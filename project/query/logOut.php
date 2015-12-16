<?php
	session_unset();
    // destroy the old session
    session_destroy();
    // start a new session
    session_start();

    // reset the session variables.
    $_SESSION['isLoggedIn'] = false;
	$_SESSION['username'] = "";
	$_SESSION['userid'] = "";
	$_SESSION['authority'] = "";

    header("Location: ../index.php");
	exit();
?>