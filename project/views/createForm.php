<?php
	// the form to be created in xml
	include "../prefix.php";	
	
	include '../query/db_connect.php';

	header("Content-type:text/xml;charset=utf-8");

	$xml_text = 
	"<?xml version='1.0' encoding='UTF-8'?> 
	<?xml-stylesheet type='text/xsl' href='form.xsl'?>
	<form>";

	// get information from the databas!
	$postID = $_GET['postID'];
	$xml_text = $xml_text . "<postID>$postID</postID>";
	$queryPost = "SELECT title, text FROM posts WHERE id = $postID";
	$queryHashtags = "SELECT hashtags.name
		FROM posts
		JOIN hashtags on posts.id = hashtags.postid
		where posts.id = $postID";

	$postResult = mysqli_query($con,$queryPost)
        or die("Query failed on post");

    while ($line = mysqli_fetch_object($postResult)) {
        // lagra innehållet i en tabellrad i variabler
        $title = $line->title; 
        $text = $line->text;
        $xml_text = $xml_text . "<title>$title</title>";
        $xml_text = $xml_text . "<text>$text</text>";
    }

	$resultHashtags = mysqli_query($con,$queryHashtags)
            or die("Query likes failed"); 

    $returnHashtags = "<hashtags>";
	// the form should be filled with title, text and hashtags.. get these from the database and insert into the form layout xml
	if(mysqli_num_rows($resultHashtags) != 0) {
        while ($hashtagLine = mysqli_fetch_object($resultHashtags)) {
            $hashtag = $hashtagLine->name;
            $returnHashtags = $returnHashtags . "$hashtag ";
        }
    }
    $returnHashtags =  $returnHashtags . "</hashtags>";

	$xml_text = $xml_text . $returnHashtags;
    $xml_text .= "</form>";
	
	print utf8_encode($xml_text);

	mysqli_close($con);

	include "postfixForm.php";
?>