<?php
// connect to database
$link=mysqli_connect("localhost", "dn145897", "okah7iegh7exu1huoMaedah9eiThai","dn145897")
   or die('Could not connect ');
echo "Connected successfully";


//perform SQL query
$id=$_POST["id"];
$id= trim($id);

$sql = "DELETE FROM WEAPON WHERE uuid=$id";

if (mysqli_query($link, $sql)) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . mysqli_error($link);
}
//print results in html
echo"<h1>Weapon table</h1>";

echo " <table border='1'>\n";
//perform SQL query
$query = "SELECT * from WEAPON";
$result = mysqli_query($link,$query) 
	or die("Query failed ");
echo "query ok";

while ($line = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
	echo "\t<tr>\n";
	foreach ($line as $col_value) {
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




