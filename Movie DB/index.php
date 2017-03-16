<!DOCTYPE html>
<html>
    <head>
        <title>Movie DB Results</title>
    </head>
    <body>
        <?php
        require("config.php");
        $connection = pg_connect("host=$dbhost dbname=$databasename user=$user password=$password");
        if($connection){
            echo "Connected";
        }else{
            echo "Error connecting to DB";
        }

        $query = "INSERT INTO entry VALUES('$_POST[series_id]','$_POST[title]','$_POST[year]','$_POST[language]', '$_POST[budget]',
        '$_POST[actor_id]', '$_POST[first_name]', '$_POST[last_name]', '$_POST[nationality]', '$_POST[network_id]', '$_POST[network_name]',
        '$_POST[location]', '$_POST[award_id]', '$_POST[award_name]', '$_POST[category]', '$_POST[organizer]')";

        $result = pg_query($query);
        if(!$result){
            echo "Error entering values into DB";
            exit;
        }else{
            echo "Entered";
        }
        ?>
        <table>
            <tr>
                <th>Series ID</th>
                <th>Title</th>
            </tr>
        </table>
    </body>
</html>


