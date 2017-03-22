<?php
$cookie_name = "login";
if(!isset($_COOKIE[$cookie_name])) {
    header('location: index.php#tologin');
    exit;
}
?>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Login and Registration</title>
    <link rel="stylesheet" type="text/css" href="css/demo.css" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="stylesheet" type="text/css" href="css/animate-custom.css"/>
</head>
<body>
    <div class="container">
        <header>
            <h1>Edit Data</h1>

        </header>
        <section>
            <div id="wrapper">
                <div id="login" class="animate form">
                    <form  action="change.php" method="post" autocomplete="on">
                        <p>
                            <label>First Name</label>
                            <input name="firstname" placeholder="Joe" />
                        </p>
                        <p>
                            <label>Last Name</label>
                            <input name = "lastname" placeholder="Green"/>
                        </p>
                        <p>
                            <label>Address</label>
                            <input name= "address" placeholder="1530 Mayflower St. St.Louis"/>
                        </p>
                        <p>
                            <label>Phone</label>
                            <input name = "phone" placeholder="0920123536"/>
                        </p>

                        <p>
                            <label for="select1">Department</label>
                            <select name='dept_name' id = 'select1'>
                            <?php
                            require("config.php");
                            $connection = pg_connect("host=$dbhost dbname=$databasename user=$user password=$password");
                            if(!$connection){
                                echo "Error connecting to DB";
                            }

                            $department = pg_query("select * from department");

                            while($dept_row = pg_fetch_array($department)){
                                echo "<option>",$dept_row["dept_name"] ,"</option>";
                                echo $dept_row["dept_name"];
                            }
                            ?>
                            </select>
                        </p>
                        <p class="signin button">
                            <input type="submit" value="Change"/>
                        </p>
                    </form>
                </div>
            </div>
        </section>
    </div>
</body>
</html>