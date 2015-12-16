<?php

	// lokalt på datorn
	$host = "localhost:8889"; 
	$user = "root";
	$pass = "root";

	$con = mysqli_connect($host, $user, $pass);
	mysqli_select_db($con,"blogposts");
	mysqli_query($con,"set names 'utf8'");
?>