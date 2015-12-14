<?php 
	// start the session.. 
    if (!isset($_SESSION['isLoggedIn'])) {
        session_start();
    }
    include 'prefix.php';

    ?>

<adminsite>

    <?php
    $returnstring = "";

	// add information about the user that is logged in right now
    if (isset($_SESSION['isLoggedIn']) && $_SESSION['isLoggedIn']) {
        $userID = $_SESSION['userid'];
        $username = $_SESSION['username'];
        $authority = $_SESSION['authority'];
        $returnstring = $returnstring . "<currentUser id='$userID' name='$username' authority='$authority' />";

        // logged in, deside what to do. 
	    if ($authority == 0) {
			// gör allt här typ!!
			include 'query/db_connect.php';

			// hämta alla users och dess behörighet..
			$query = "SELECT * FROM user ORDER BY user.authority ASC";

			// utför själva frågan. Om du har fel syntax får du felmeddelandet query failed
   			$result = mysqli_query($con,$query)
        	or die("Query failed");

        	// build up the xml
        	// loopa över alla resultatrader och skriv ut en motsvarande tabellrad
		    while ($line = mysqli_fetch_object($result)) {
		        // lagra innehållet i en tabellrad i variabler
		        $id = $line->id; 
		        $name = $line->name;
		        $picture = $line->picture; 
		        $user_authority = $line->authority; 

		        $returnstring = $returnstring . "<user>";
		        $returnstring = $returnstring . "<name>$name</name>";
		        $returnstring = $returnstring . "<userid>$id</userid>";
		        $returnstring = $returnstring . "<picID>$picture</picID>";
		        $returnstring = $returnstring . "<authority>$user_authority</authority>";
		        $returnstring = $returnstring . "</user>";

		    }
			// kunna ändra lösenord och användarnamn?
			// if updating password, then updating the salt also!!
		} else {
			$returnstring = $returnstring . "<errorMessage> Inte behörig användare för att vara på denna sida. </errorMessage>";
		}
	} else {
		$returnstring = $returnstring . "<errorMessage> Du måste vara inloggad och admin för att nå denna sida.</errorMessage>";
	}

	print ($returnstring); 
    mysqli_close($con);
?>

</adminsite>

<?php include 'postfixAdmin.php';?>