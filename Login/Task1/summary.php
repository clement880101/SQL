<?php
require("config.php");
$connection = pg_connect("host=$dbhost dbname=$databasename user=$user password=$password");
if(!$connection){
    echo "Error connecting to DB";
}
?>
<html>
<head>
    <meta charset="UTF-8">
    <title>PHP Connection Result</title>
    <link type="text/css" rel="stylesheet" href="style.css"/>
</head>
<body>
<form  class="form-style" action="index.php">
    <h1>Results</h1>

    <table>
        <tr>
            <th>Id</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
            <th>Department</th>
        </tr>
        <?php
        $teachers = pg_query(
            "SELECT teachers.id, firstname, lastname, email, deptname FROM teachers LEFT JOIN department USING (dept_id);");
        while ($teach_row = pg_fetch_array($teachers)) {
            echo "<tr>";
            echo "<td>", $teach_row["id"], "</td>
                    <td>", $teach_row["firstname"], "</td>
                    <td>", $teach_row["lastname"], "</td>
                    <td>", $teach_row["email"],"</td>
                    <td>", $teach_row["deptname"],"</td>
                    </tr>";
        }
        pg_close($connection);
        ?>
    </table>

    <input type="submit" value="Back">
</form>
</body>
</html>
