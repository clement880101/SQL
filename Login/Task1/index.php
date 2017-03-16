<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Teacher Database Entry Form</title>
    <link type="text/css" rel="stylesheet" href="style.css"/>
</head>

<body>

<form class="form-style" action="entry.php" method="post">
    <h1>Teachers</h1>

    <br>First Name:
    <input type="text" name="firstname" >

    <br>Last Name:
    <input type="text" name="lastname" >

    <br>Email Address:
    <input type="email" name="email">

    <br>Department:

    <?php
        require("config.php");
        $connection = pg_connect("host=$dbhost dbname=$databasename user=$user password=$password");
        if(!$connection){
            echo "Error connecting to DB";
        }

        $department = pg_query("select * from department");

        echo "<select name='dept_name'>";
        while($dept_row = pg_fetch_array($department)){
            echo "<option>",$dept_row["deptname"] ,"</option>";
        }

    echo"</select>";
    pg_close($connection);
    ?>
    <br>
    <br>

    <input type="submit" value="Submit">
    <input type="reset" value="Reset">
</form>

</body>

</html>