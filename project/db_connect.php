<?php
	/*mysql_connect("localhost:8889", "root", "root")
		or die("Could not connect");
	//mysql_select_db("tutorial")
	mysql_query("set names 'utf8'");
	mysql_select_db("blogposts")
		or die("Could not connect to database");*/

	$con=mysqli_connect("localhost:8889", "root", "root");
	mysqli_select_db($con,"blogposts");
	mysqli_query($con,"set names 'utf8'");
?>