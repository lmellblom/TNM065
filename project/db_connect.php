<?php
	mysql_connect("localhost:8889", "root", "root")
		or die("Could not connect");
	mysql_select_db("tutorial")
		or die("Could not connect to database");
?>