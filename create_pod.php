<?php
$podtype=$_POST['podtype'];
$description=$_POST['description'];
$podname=$_POST['podname'];
$email=$_POST['email'];

#echo $podtype;
#echo $description;
#echo $podname;

system("sudo /var/www/html/create_pod.sh '$podname' '$podtype' '$description' '$email' ");
echo "pod created redirecting";
sleep(20);
header('Location: index.php');

?>
