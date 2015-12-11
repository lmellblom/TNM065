<?php 
    // start the session.. 
    if (!isset($_SESSION['isLoggedIn'])) {
        session_start();
    }
    include 'prefix.php';
?>

<blogposts>

 <?php  

    include 'query/db_connect.php';
    
    $returnstring = "";

    // ändra query-frågan beroende på om man vill se en specifik profil eller alla
    // kanske ta bort detta sen...
    if(isset($_GET['profile'])) {
        // koll på om det är ett id?
        $profileID = $_GET['profile']; 
        $query = "SELECT user.name, user.id as 'userid', user.picture,  posts.title, posts.text, posts.date, posts.id
            FROM posts
            INNER JOIN user on posts.userid = user.id
            WHERE user.id = $profileID
            ORDER BY posts.date DESC, user.name DESC";
    } else if(isset($_GET['search']) && $_GET['search'] != "") {
        $hashtag = $_GET['search']; 
        $query = $test="SELECT user.name, user.id as 'userid',user.picture,  posts.title, posts.text, posts.date, posts.id
            FROM posts
            INNER JOIN user on posts.userid = user.id
            JOIN hashtags on posts.id = hashtags.postid
            WHERE hashtags.name LIKE '%$hashtag%' 
            ORDER BY posts.date DESC, user.name DESC";

        $returnstring = $returnstring . "<search>$hashtag</search>";

    } else {
        // en sql-fråga som väljer ut alla rader sorterade fallande på år och vecka
        $query = "SELECT user.name, user.id as 'userid',user.picture, posts.title, posts.text, posts.date, posts.id
            FROM posts
            INNER JOIN user on posts.userid = user.id
            ORDER BY posts.date DESC, user.name DESC";
    }


    // utför själva frågan. Om du har fel syntax får du felmeddelandet query failed
    $result = mysqli_query($con,$query)
        or die("Query failed");

    // add information about the user that is logged in right now
    if (isset($_SESSION['isLoggedIn'])) {
        if ($_SESSION['isLoggedIn']) {
            $userID = $_SESSION['userid'];
            $username = $_SESSION['username'];
            $authority = $_SESSION['authority'];
            $returnstring = $returnstring . "<currentUser id='$userID' name='$username' authority='$authority' />";
        }
    }

    if(isset($_GET['loginError'])) {
        $errorMessage = $_GET['loginError'];
        $errorString = "fail";
        if ($errorMessage == 'noMatch'){
            $errorString =  "Inlogg misslyckades.";
        } else if ($errorMessage == 'username'){
            $errorString = "Användarnamnet finns redan registrerat.";
        } else if ($errorMessage == 'password'){
            $errorString = "Lösenordena matchade inte varandra.";
        }
        $returnstring = $returnstring . "<errormessage>$errorString</errormessage>";
    }
        
    // loopa över alla resultatrader och skriv ut en motsvarande tabellrad
    while ($line = mysqli_fetch_object($result)) {
        // lagra innehållet i en tabellrad i variabler
        $title = $line->title; 
        $text = $line->text;
        $author = $line->name; 
        $userid = $line->userid; 
        $postID = $line->id;
        $date = $line->date;
        $picid = $line->picture;


        $date = strtotime($date);
        // skriva ut timmen? kanske göra check och bara skriva ut om det är samma dag
        $currentYear = date('Y');
        $postYear =  date('Y', $date);
        if ($currentYear == $postYear) { // only write the year if it is not the same year
            $date = date('d M.', $date);
        } else {
            $date = date('d M.Y', $date);
        }

        // bygg upp en sträng innehållande det resultat vi vill ha
        // slå ihop två strängar med ".".blogposts
        $returnstring = $returnstring . "<post id='$postID'>";
        $returnstring = $returnstring . "<title>$title</title>";
        $returnstring = $returnstring . "<text>$text</text>";
        $returnstring = $returnstring . "<author picid='$picid' id='$userid'>$author</author>"; 
        $returnstring = $returnstring . "<publish_date>$date</publish_date>";


        // get the hashtags
        $query_hashtags = "SELECT hashtags.name
                    FROM posts
                    JOIN hashtags on posts.id = hashtags.postid
                    where posts.id = $postID";

        $resultHashtags = mysqli_query($con,$query_hashtags)
            or die("Query likes failed"); 

        if(mysqli_num_rows($resultHashtags) != 0) {
            $returnstring = $returnstring . "<hashtags>";
            while ($hashtagLine = mysqli_fetch_object($resultHashtags)) {
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

        $resultLikes = mysqli_query($con,$query_likes)
            or die("Query likes failed");     

        if(mysqli_num_rows($resultLikes) != 0) {
            $returnstring = $returnstring . "<likes>";
            while ($likeLine = mysqli_fetch_object($resultLikes)) {
                $likeUserID = $likeLine->id;
                $likeUser = $likeLine->name;
                $returnstring = $returnstring . "<like userid='$likeUserID' username='$likeUser' />";
            }
            $returnstring = $returnstring . "</likes>";
        }

        $returnstring = $returnstring . "</post>";

    }
    
    // koda för säkerhets skull om till utf-8 innan resultatet skrivs ut.
    // print utf8_encode($returnstring); // ha kvar ifall att. gjorde på annorlunda sätt med utf8 på connection till databasen.
    // får se om det funkar.
    print ($returnstring); 

    mysqli_close($con);
    ?>

    </blogposts>

<?php include 'postfix.php';?>