<?php
$cookie_name = "login";
if(!isset($_COOKIE[$cookie_name])) {
    header('location: index.php#tologin');
    exit;
}

require ("config.php");
$connection = pg_connect ("host=$DB_HOST dbname=$DB_DATABASE user=$DB_USER password=$DB_PASSWORD");
if(!$connection) {
    echo "Error Connecting to SQL";
}



$query = pg_query("SELECT id FROM users WHERE username = '$_COOKIE[$cookie_name]'");
$id = pg_fetch_result($query ,0 ,0);

$department = pg_fetch_result(pg_query("SELECT dept_id FROM department WHERE dept_name = '$_POST[dept_name]';"), 0, 0);

$query = pg_query("DELETE FROM profile WHERE id = '$id'");

$query = "INSERT INTO profile VALUES ('$id', $department ,'$_POST[firstname]', '$_POST[lastname]', '$_POST[address]','$_POST[phone]');";

$result = pg_query($query);

if (!$result) {
    echo "Error Inserting";
}else{
    echo "Success";
}

header("location: welcome.php")
?>
