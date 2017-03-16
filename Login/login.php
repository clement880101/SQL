<?php
// --- secure connection to the database
require ("config.php");
$connection = pg_connect ("host=$DB_HOST dbname=$DB_DATABASE user=$DB_USER password=$DB_PASSWORD");
if(!$connection){
    echo "Error Connecting to SQL";
}

$username = $_POST['username'];
$pass= $_POST['password'];

$query = pg_query("SELECT username FROM users WHERE username = '$username' AND password = crypt('$pass', password);");
$result = pg_fetch_result($query,0,0);
echo $result;

if(!$result){
    header("location: index.html#toregister");
}else{
    $cookie_name = "login";
    $cookie_value = "True";
    setcookie($cookie_name, $cookie_value, time() + (30), "/");
    header("location: welcome.php"."?username=".$username);
}

?>