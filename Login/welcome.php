<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8" />
    <title>Welcome</title>
    <link rel="stylesheet" type="text/css" href="css/demo.css" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="stylesheet" type="text/css" href="css/animate-custom.css"/>
</head>
<body>
<div class="container">
    <header>
        <?php
            $cookie_name = "login";
            if(isset($_COOKIE[$cookie_name])){
                $username = $_COOKIE[$cookie_name];
            }else {
                header('location: index.php');
                exit;
            }
            echo "<h1> Welcome ".$username."</h1>";
        ?>
    </header>
    <section>
        <div id="wrapper">
            <div id="login" class="animate form">
                <table>
                    <tr>
                        <th>Username</th>
                        <th>email</th>
                        <th>First Name</th>
                    </tr>
                    <?php
                    require ("config.php");
                    $connection = pg_connect ("host=$DB_HOST dbname=$DB_DATABASE user=$DB_USER password=$DB_PASSWORD");
                    if(!$connection){
                        echo "Error Connecting to SQL";
                    }

                    $query = pg_query("SELECT username, email, firstname FROM profile INNER JOIN users USING (id) WHERE username = '$username';");
                    while ($result = pg_fetch_array($query)) {
                        echo "<tr>";
                        echo "<td>", $result["username"], "</td>
                        <td>", $result["email"], "</td>
                        <td>", $result["firstname"], "</td>
                        </tr>";
                    }
                    ?>
                </table>

                <table>
                    <tr>
                        <th>Last Name</th>
                        <th>Address</th>
                        <th>Phone</th>
                    </tr>
                    <?php
                    $query = pg_query("SELECT lastname, address, phone FROM profile INNER JOIN users USING (id) WHERE username = '$username';");
                    while ($result = pg_fetch_array($query)) {
                        echo "<tr>";
                        echo "<td>", $result["lastname"], "</td>
                        <td>", $result["address"], "</td>
                        <td>", $result["phone"], "</td>
                        </tr>";
                    }
                    ?>
                </table>

                <table>
                    <tr>
                        <th>Department</th>
                    </tr>
                    <?php
                    $query = pg_query("SELECT dept_name FROM department INNER JOIN profile USING (dept_id) INNER JOIN user USING (id) WHERE username = '$username';");
                    while ($result = pg_fetch_array($query)) {
                        echo "<tr>";
                        echo "<td>", $result["name"], "</td>
                        </tr>";
                    }
                    pg_close($connection);
                    ?>
                </table>

                <form  action='index.php#tologin'>
                    <p class='login button'>
                        <input type='submit' value='Logout' />
                    </p>
                </form>
                <form  action='edit.php'>
                    <p class='login button'>
                        <input type='submit' value='Edit' />
                    </p>
                </form>
            </div>
        </div>
    </section>
</div>

</body>
</html>