<?php
// --- secure connection to the database
require ("config.php");
$connection = pg_connect ("host=$DB_HOST dbname=$DB_DATABASE user=$DB_USER password=$DB_PASSWORD");
if(!$connection){
    echo "Error Connecting to SQL";
}


$query = pg_query("SELECT * FROM login;");
while($row = pg_fetch_array($query)){
    if(($row['email'] == $_POST['emailsignup'])||($row['username'] == $_POST['usernamesignup'])){
        echo "Invalid Entry";
        exit;
    }
}


$query = "INSERT INTO login(username, email, password) VALUES
('$_POST[usernamesignup]', '$_POST[emailsignup]', crypt('$_POST[passwordsignup]', gen_salt('md5')));";

$result = pg_query($query);

if (!$result) {
    echo "Error Inserting";
    exit;
}else{
    echo "Success";
}

?>