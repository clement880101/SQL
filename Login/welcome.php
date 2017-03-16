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
                $username = $_GET["username"];
            }else {
                header('location: index.html');
                exit;
            }
            echo "<h1> Welcome ".$username."</h1>";
        ?>
    </header>
    <section>
        <div id="container_demo" class="animate form">

            <table>
                <tr>
                    <th>id</th>
                    <th>username</th>
                    <th>email</th>
                </tr>
                <?php
                require ("config.php");
                $connection = pg_connect ("host=$DB_HOST dbname=$DB_DATABASE user=$DB_USER password=$DB_PASSWORD");
                if(!$connection){
                    echo "Error Connecting to SQL";
                }

                $query = pg_query("SELECT * FROM login WHERE username = '$username';");
                while ($result = pg_fetch_array($query)) {
                    echo "<tr>";
                    echo "<td>", $result["id"], "</td>
                    <td>", $result["username"], "</td>
                    <td>", $result["email"], "</td>
                    </tr>";
                }
                pg_close($connection);
            ?>

            </table>
        </div>
    </section>
</div>

</body>
</html>