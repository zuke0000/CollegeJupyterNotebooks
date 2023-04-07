<html>
<head>
  <title>Employee Table Search Results</title>
</head>
<body>
<h1>Employee Table Search Results</h1>
<?php
  // create short variable names
  $searchterm=$_POST["searchterm"];

  $searchterm= trim($searchterm);

echo "Search term entered: $searchterm";
echo "<br>"; 

  if (!$searchterm)
  {
     echo 'You have not entered search details.  Please go back and try again.';
     exit;
  }
  

  // connect to database
  $link=mysqli_connect("localhost", "dn145897", "okah7iegh7exu1huoMaedah9eiThai","company")
     or die('Could not connect ');
  echo "Connected successfully <br>";

  $query = "SELECT * from employee where fname like '%".$searchterm."%' ";
  $result = mysqli_query($link,$query) 
	  or die("Query failed ");
  echo "query ok\n";

  
  $num_results = mysqli_num_rows($result);

  echo '<p>Number of rows found: '.$num_results.'</p>';

  echo " <table border='1'>\n";

  //print column headings
  echo "\t<tr>\n";
  while ($fieldinfo = $result -> fetch_field()){
    echo "\t\t<td>$fieldinfo->name</td>\n";
    //echo"";
  }
  echo "\t</tr>\n";

  
  while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {

	 echo "\t<tr>\n";
	 foreach ($row as $col_value) {
	 	echo "\t\t<td>$col_value</td>\n";
	 }
	 echo "\t</tr>\n";
}
echo "</table>\n";


//Free result set
mysqli_free_result($result);

//close connection
mysqli_close($link);
?>



</body>
</html>
