<?php include 'prefix.php';?>
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns="http://purl.org/rss/1.0/"
xmlns:dc="http://purl.org/dc/elements/1.1/">

<channel rdf:about="http://www.itn.liu.se/">
		<title>Bokkatalog</title>
		<link>http://www.itn.liu.se/</link>
		<description>En bokkatalog.</description>
		<dc:language>en</dc:language>
		
 <?php  

    // koppla upp mot databasen med med användarnamn "rsslab", utan lösenord
    $link = mysql_connect("mysql.itn.liu.se", "rsslab")
        or die("Could not connect");
    // välj databasen rsslab
    mysql_select_db("rsslab")
        or die("Could not select database");
    $returnstring ="";
    
    // en sql-fråga som väljer ut alla rader sorterade fallande på år och vecka
    $query = "SELECT  link,title, description, author, publish_date
            FROM bookcatalog
            ORDER BY publish_date DESC";

    // utför själva frågan. Om du har fel syntax får du felmeddelandet query failed
    $result = mysql_query($query)
        or die("Query failed");
		
	// create the dc:date and publisher and creator
	$dateNow = date('c', strtotime("now"));
	$stringLinks = "<dc:date>$dateNow</dc:date>";
	$stringLinks = $stringLinks . "<dc:publisher>LiU/ITN</dc:publisher>";
	$stringLinks = $stringLinks . "<dc:creator>Linnea Mellblom</dc:creator>";
	
	// build up the links
	$stringLinks = $stringLinks . "<items>"; 
	$stringLinks = $stringLinks . "<rdf:Seq>"; 
	
    // loopa över alla resultatrader och skriv ut en motsvarande tabellrad
    while ($line = mysql_fetch_object($result)) {
        // hämtar all data från databasen och lagrar i en variabel
        $date = $line->publish_date;
		$title = $line->title;
		$description = $line->description;
		$author = $line->author;
		$link = $line->link;
		
		// ser till att formateringen blir okej
		$description = preg_replace("/&/","&amp;", $description);
		$title = preg_replace("/&/","&amp;", $title);
		$link = preg_replace(
			array("/&/","/ /"),
			array("&amp;", "%20"),
			$link
		);
		
		// convert the date to a timestamp and then to the right format
		$date = strtotime($date);
		$date = date('c', $date);
		
		// bygg upp links högst upp 
		$stringLinks = $stringLinks . "<rdf:li rdf:resource='$link' />";
              	        
        // bygg upp en sträng innehållande det resultat vi vill ha
        // slå ihop två strängar med ".".
        $returnstring = $returnstring . "<item rdf:about='$link'>";
		$returnstring = $returnstring . "<title>$title</title>";
		$returnstring = $returnstring . "<link>$link</link>";
		$returnstring = $returnstring . "<description>$description</description>";
		$returnstring = $returnstring . "<dc:date>$date</dc:date>";
		$returnstring = $returnstring . "<dc:creator>$author</dc:creator>";
        $returnstring = $returnstring . "</item>";
    }
	
	$stringLinks = $stringLinks . "</rdf:Seq>"; 
	$stringLinks = $stringLinks . "</items>";
	$stringLinks = $stringLinks . "</channel>";
	
	// adding the strings togehter
	$return = $stringLinks . $returnstring; 
    
    // koda för säkerhets skull om till utf-8 innan resultatet
    // skrivs ut.
    print utf8_encode($return); 
    ?>

</rdf:RDF>

<?php include 'postfix.php';?>
