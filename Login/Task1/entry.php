<?php
require("config.php");
$connection = pg_connect("host=$dbhost dbname=$databasename user=$user password=$password");
if(!$connection){
    echo "Error connecting to DB";
}

$query = "SELECT dept_id FROM department WHERE deptname = '$_POST[dept_name]'";
$dept_id = pg_query($query);
$dept_id = pg_fetch_result($dept_id, 0, 0);

$query = "INSERT INTO teachers (firstname, lastname, email, dept_id) VALUES ('$_POST[firstname]','$_POST[lastname]',
'$_POST[email]', $dept_id)";
$result = pg_query($query);

if (!$result) {
    echo "An error while inserting occurred.";
    exit;
}

pg_close($connection);
header('location: summary.php');
exit;
?>

