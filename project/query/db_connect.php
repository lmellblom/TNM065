<?php
	$con=mysqli_connect("localhost:8889", "root", "root");
	mysqli_select_db($con,"blogposts");
	mysqli_query($con,"set names 'utf8'");
?>