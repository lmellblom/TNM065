<?php 
    include 'prefix.php';
    
?>

<blogposts>

 <?php  

    mysql_connect("localhost:8889", "root", "root")
        or die("Could not connect");
    mysql_select_db("tutorial")
        or die("Could not connect to database");
    
    $returnstring = "";

    
    // en sql-fråga som väljer ut alla rader sorterade fallande på år och vecka
    $query = "SELECT  title, text, author
            FROM posts
            ORDER BY title ASC";

    // utför själva frågan. Om du har fel syntax får du felmeddelandet query failed
    $result = mysql_query($query)
        or die("Query failed");
        
    // loopa över alla resultatrader och skriv ut en motsvarande tabellrad
    while ($line = mysql_fetch_object($result)) {
        // lagra innehållet i en tabellrad i variabler
        $title = $line->title; 
        $text = $line->text;
        $author = $line->author; 
              	        
        // bygg upp en sträng innehållande det resultat vi vill ha
        // slå ihop två strängar med ".".blogposts
        $returnstring = $returnstring . "<post>";
        $returnstring = $returnstring . "<title>$title</title>";
        $returnstring = $returnstring . "<text>$text</text>";
        $returnstring = $returnstring . "<author>$author</author>"; 
        $returnstring = $returnstring . "</post>";

    }
    
    // koda för säkerhets skull om till utf-8 innan resultatet
    // skrivs ut.
    print utf8_encode($returnstring); 

    mysql_close();
    ?>

    </blogposts>

<?php include 'postfix.php';?>
