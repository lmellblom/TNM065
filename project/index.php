<?php 
    // start the session.. 
    if (!isset($_SESSION['isLoggedIn'])) {
        session_start();
    }
    include 'prefix.php';
?>

<blogposts>

 <?php  

    include 'db_connect.php';
    
    $returnstring = "";

    // ändra query-frågan beroende på om man vill se en specifik profil eller alla
    if(isset($_GET['profile'])) {
        // koll på om det är ett id?
        $profileID = $_GET['profile']; 
        $query = "SELECT user.name, user.id as 'userid', posts.title, posts.text, posts.date, posts.id
            FROM posts
            INNER JOIN user on posts.userid = user.id
            WHERE user.id = $profileID
            ORDER BY posts.date DESC, user.name DESC";
    } else if(isset($_GET['search'])) {
        $hashtag = $_GET['search']; 
        $query = $test="SELECT user.name, user.id as 'userid', posts.title, posts.text, posts.date, posts.id
            FROM posts
            INNER JOIN user on posts.userid = user.id
            JOIN hashtags on posts.id = hashtags.postid
            WHERE hashtags.name LIKE '%$hashtag%' 
            ORDER BY posts.date DESC, user.name DESC";

        $returnstring = $returnstring . "<search>$hashtag</search>";

    } else {
        // en sql-fråga som väljer ut alla rader sorterade fallande på år och vecka
        $query = "SELECT user.name, user.id as 'userid', posts.title, posts.text, posts.date, posts.id
            FROM posts
            INNER JOIN user on posts.userid = user.id
            ORDER BY posts.date DESC, user.name DESC";
    }


    // utför själva frågan. Om du har fel syntax får du felmeddelandet query failed
    $result = mysql_query($query)
        or die("Query failed");

    // add information about the user that is logged in right now
    if (isset($_SESSION['isLoggedIn'])) {
        if ($_SESSION['isLoggedIn']) {
            $userID = $_SESSION['userid'];
            $username = $_SESSION['username'];
            $authority = $_SESSION['authority'];
            //$returnstring = $returnstring . "<user>$username</user>";
            $returnstring = $returnstring . "<currentUser id='$userID' name='$username' authority='$authority' />";
        }
    }
        
    // loopa över alla resultatrader och skriv ut en motsvarande tabellrad
    while ($line = mysql_fetch_object($result)) {
        // lagra innehållet i en tabellrad i variabler
        $title = $line->title; 
        $text = $line->text;
        $author = $line->name; 
        $userid = $line->userid; 
        $postID = $line->id;
        $date = $line->date;

        $date = strtotime($date);
        $date = date('Y.m.d H:i',$date);//date('c', $date);

        // bygg upp en sträng innehållande det resultat vi vill ha
        // slå ihop två strängar med ".".blogposts
        $returnstring = $returnstring . "<post id='$postID'>";
        $returnstring = $returnstring . "<title>$title</title>";
        $returnstring = $returnstring . "<text>$text</text>";
        $returnstring = $returnstring . "<author id='$userid'>$author</author>"; 
        $returnstring = $returnstring . "<publish_date>$date</publish_date>";


        // get the hashtags
        $query_hashtags = "SELECT hashtags.name
                    FROM posts
                    JOIN hashtags on posts.id = hashtags.postid
                    where posts.id = $postID";

        $resultHashtags = mysql_query($query_hashtags)
            or die("Query likes failed"); 

        if(mysql_num_rows($resultHashtags) != 0) {
            $returnstring = $returnstring . "<hashtags>";
            while ($hashtagLine = mysql_fetch_object($resultHashtags)) {
                $hashtag = $hashtagLine->name;
                $returnstring = $returnstring . "<hashtag>$hashtag</hashtag>";
            }
            $returnstring = $returnstring . "</hashtags>";
        }

        // get all the likes
        $query_likes = "SELECT user.name, user.id
            FROM likes
            INNER JOIN user on likes.userid = user.id
            WHERE likes.postid=$postID";

        $resultLikes = mysql_query($query_likes)
            or die("Query likes failed");     

        if(mysql_num_rows($resultLikes) != 0) {
            $returnstring = $returnstring . "<likes>";
            while ($likeLine = mysql_fetch_object($resultLikes)) {
                $likeUserID = $likeLine->id;
                $likeUser = $likeLine->name;
                $returnstring = $returnstring . "<like userid='$likeUserID' username='$likeUser' />";
            }
            $returnstring = $returnstring . "</likes>";
        }

        $returnstring = $returnstring . "</post>";

    }
    
    // koda för säkerhets skull om till utf-8 innan resultatet
    // skrivs ut.
    print utf8_encode($returnstring); 

    mysql_close();
    ?>

    </blogposts>

<?php include 'postfix.php';?>
