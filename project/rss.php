<?php header("Content-type:text/xml;charset=utf-8");?>
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns="http://purl.org/rss/1.0/"
xmlns:dc="http://purl.org/dc/elements/1.1/">

<channel rdf:about="http://www.itn.liu.se/">
        <title>Moments</title>
        <link>http://localhost:8888</link>
        <description>En mikroblogg med ögonblick som fångar dig.</description>
        <dc:language>en</dc:language>
        
 <?php  
 
    // koppla upp mot databasen
    include 'query/db_connect.php';
    
    // en sql-fråga
    $query = "SELECT user.name, user.id as 'userid', posts.title, posts.text, posts.date, posts.id
            FROM posts
            INNER JOIN user on posts.userid = user.id
            ORDER BY posts.date DESC, user.name DESC";

    // utför själva frågan. Om du har fel syntax får du felmeddelandet query failed
    $result = mysqli_query($con, $query)
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
    while ($line = mysqli_fetch_object($result)) {
        // hämtar all data från databasen och lagrar i en variabel
        $title = $line->title; 
        $text = $line->text;
        $author = $line->name; 
        $userid = $line->userid; 
        $postID = $line->id;
        $date = $line->date;
        
        // ser till att formateringen blir okej
        // inte bästa länken men för nu.
        $link = "http://localhost:8888/views/post.php?id=$postID";

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
        $returnstring = $returnstring . "<description>$text</description>";
        $returnstring = $returnstring . "<dc:date>$date</dc:date>";
        $returnstring = $returnstring . "<dc:creator>$author</dc:creator>";
        $returnstring = $returnstring . "</item>";
    }
        
    $stringLinks = $stringLinks . "</rdf:Seq>"; 
    $stringLinks = $stringLinks . "</items>";
    $stringLinks = $stringLinks . "</channel>";
    
    // adding the strings togehter
    $return = $stringLinks . $returnstring; 

    mysqli_close($con); // stäng connection
    
    // koda för säkerhets skull om till utf-8 innan resultatet skrivs ut.
    print ($return);  // utf8_encode, tog bort. databasen har utf-8, blir knas annars.
    ?>

</rdf:RDF>
