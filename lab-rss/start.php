<?php header("Content-type:text/html;charset=utf-8");?>
<html>
  <head>
    <title>Kaffelista</title>
  </head>
  <body>
    <table>
      <tr>
        <td>År</td>
        <td>Vecka</td>
        <td>Namn</td>
      </tr>
 <?php  
    // koppla upp mot databasen med med användarnamn "rsslab", utan lösenord
    $link = mysql_connect("mysql.itn.liu.se", "rsslab")
        or die("Could not connect");
    // välj databasen rsslab
    mysql_select_db("rsslab")
        or die("Could not select database");
    $returnstring ="";
    
    // en sql-fråga som väljer ut alla rader sorterade fallande på år och vecka
    $query = "SELECT  name,week,year
            FROM calendar
            ORDER BY year, week ASC";

    // utför själva frågan. Om du har fel syntax får du felmeddelandet query failed
    $result = mysql_query($query)
        or die("Query failed");
        
    // loopa över alla resultatrader och skriv ut en motsvarande tabellrad
    while ($line = mysql_fetch_object($result)) {
        // lagra innehållet i en tabellrad i variabler
        $year = $line->year; 
        $week = $line->week;
        $name = $line->name;
        $name = preg_replace("/ö/","&#246;", $name);
              	        
        // bygg upp en sträng innehållande det resultat vi vill ha
        // slå ihop två strängar med ".".
        $returnstring = $returnstring . "<tr>";
        $returnstring = $returnstring . "<td>$year</td>"; 
        $returnstring = $returnstring . "<td>$week</td>";
        $returnstring = $returnstring . "<td>$name</td>";
        $returnstring = $returnstring . "</tr>";
    }
    
    // koda för säkerhets skull om till utf-8 innan resultatet
    // skrivs ut.
    print utf8_encode($returnstring); 
    ?>

    </table>
  </body>
</html>