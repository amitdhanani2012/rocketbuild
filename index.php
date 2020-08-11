<?php

system("sudo /var/www/html/status.sh");

echo "<br><p><b>Create pod</b></p>";
echo "<form name='os-select' method=post action='create_pod.php'>";
echo "<table>";
echo "<tr>";
echo "<td>OS</td>";
echo "<td><select name='podtype' >";
echo "Select OS Version";
echo "<option value='Centos6'>Centos6</option>";
echo "<option value='Centos7'>Centos7</option>";
echo "<option value='Centos8'>Centos8</option>";
echo "</select>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td>Enter Bug description</td>";
echo "<td><input type='text' name='description'></td></tr>";
echo "<tr>";
echo "<td>Enter name of pod</td>";
echo "<td><input type='text' name='podname'></td></tr>";
echo "<tr><td>Enter Email id</td><td><input type=text name=email></td></tr>";
echo "<tr>";
echo "<td></td><td><input type=submit name='submit' value='clicktocreatepod'></td></tr>";
echo "</form>";
echo "</table>";


?>

