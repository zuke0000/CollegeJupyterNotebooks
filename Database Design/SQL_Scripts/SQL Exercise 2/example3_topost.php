</head>
<body>
<h1>Insert Test Results</h1>
<?php
  // create short variable names
  $insertfield1=$_POST["insertfield1"];
  $insertfield2=$_POST["insertfield2"];
  $insertfield3=$_POST["insertfield3"];
  
  //use trim function to strip whitespace inadvertently entered 
  $insertfield1= trim($insertfield1);
  $insertfield2= trim($insertfield2);
  $insertfield3= trim($insertfield3);

echo "Enter unique sid (9 chars): $insertfield1";
echo "Enter name: $insertfield2";
echo "Enter unique email: $insertfield3";
echo "<br>"; 

 
 if ((!$insertfield1) or (!$insertfield2) or (!$insertfield3))
  {
     echo 'You have not entered insert details.  Please go back and try again.';
     exit;
  }
  
  // connect to database
  $link=mysqli_connect("localhost", "dn145897", "Kcj#PPa6Eu#5s4Z", "dn145897")
     or die('Could not connect ');
  echo "Connected successfully <br>";

  // insert new data into table
  $result = mysqli_query($link,"INSERT INTO students (sid, name, email, age, gpa) values ('$insertfield1','$insertfield2','$insertfield3',18,4.0)" )		 
	  or die("Query failed ");
  echo "query ok\n";


  // query table to show new data inserted
  $query = "SELECT * from students";
  $result = mysqli_query($link, $query)  
	  or die("Query failed ");
  echo "query ok\n";

  $num_results = mysqli_num_rows($result);

  echo '<p>New number of rows in table: '.$num_results.'</p>';

  //print column headings
  echo "\t\n";
  while ($fieldinfo = $result -> fetch_field()){
    echo "\t\n";
    printf($fieldinfo->name);
    echo"";
  }
  echo "\t\n";

 // show results of table with new data inserted
  echo " <table border='1'>\n";
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
