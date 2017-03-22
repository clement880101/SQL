<?php
// --- secure connection to the database
require ("config.php");
$connection = pg_connect ("host=$DB_HOST dbname=$DB_DATABASE user=$DB_USER password=$DB_PASSWORD");
if(!$connection){
    $word = "Error Connecting to SQL";
    $valid = false;
}else{
    $query = pg_query("SELECT * FROM users;");
    $valid = true;
    while($row = pg_fetch_array($query)){
        if(($row['email'] == $_POST['emailsignup'])||($row['username'] == $_POST['usernamesignup'])){
            $word = "Invalid Entry";
            $valid = false;
        }
    }
}


if($valid){
    $query = "INSERT INTO users(username, email, password) VALUES
('$_POST[usernamesignup]', '$_POST[emailsignup]', crypt('$_POST[passwordsignup]', gen_salt('md5')));";

    $result = pg_query($query);

    if (!$result) {
        $word = "Error Inserting";
    }else{
        $word = "Success";
    }
}
?>

<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8" />
    <title>Register</title>
    <link rel="stylesheet" type="text/css" href="css/demo.css" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="stylesheet" type="text/css" href="css/animate-custom.css"/>
</head>
<body>
<div class="container">
    <header>
        <h1>Register</h1>
    </header>
    <section>
        <div id="wrapper" >
            <div id="login" class="animate form">
                <?php
                    echo "<p>", $word, "</p>";
                    if ($word == "Success") {
                        echo "<form  action='index.php#tologin'>
                        <p class='login button'>
                        <input type='submit' value='To Login' />
                        </p>
                        </form>";
                    }else{
                        echo "<form  action='index.php#toregister'>
                        <p class='login button'>
                        <input type='submit' value='To Register' />
                        </p>
                        </form>";
                    }

                ?>
            </div>
        </div>
    </section>
</div>
</body>