<?php

$podname=$_POST['podname'];
$port=$_POST['kubectlport'];
$port1=$_POST['port1'];
system("sudo /var/www/html/delete.sh $podname $port $port1");
sleep(20);
header('Location: index.php');

?>
