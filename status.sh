#!/bin/bash
echo "<p> <b>Pod status</b> </p>"
echo "<p><b> IP for all pod is `hostname -i` </b></p>";
kubectl get pods -o wide|grep Running >/tmp/pod_listing.txt
echo  "<table border=1>"
echo "<tr>"
echo "<td><b>Podname</b></td>"
echo "<td><b>Description</b></td>"
echo "<td><b>OS Version</b></td>";
echo "<td><b>Port</b></td>"
echo "</tr>"
while read  line
do
 podname=$(echo $line |cut -f1 -d" ")
# echo "podname = $podname" 
 ps aux |grep $podname |grep -q port-forward 
 if [[ $? -eq 0 ]];then
    echo "<tr>"
    echo  "<td>" 
    echo  "$podname"  
    echo  "</td>"
    echo  "<td>"
    cat /root/container/${podname}.yaml |grep image|head -1|cut -f2 -d'-'
    echo  "</td>"
    echo  "<td>"
    cat /root/container/${podname}.yaml | grep '^#'|sed 's/#//'
    echo  "</td>"
    linez=`ps aux |grep $podname |head -1|grep 22`
    y=`echo ${linez##* } | cut -f1 -d':'`
    port=`expr $y - 2000`
    port1=`expr $port + 2200`
    echo  "<td>"
    echo  "Port is $port1"
    echo  "<td>"
    echo  "<form action=deletepod.php method=post><input type=hidden name=podname value='$podname' ><input type=hidden name=kubectlport value='$y'><input type=hidden name=port1 value='$port1'><input type=submit value='delete'></form>"
    echo  "</td>"
    echo  "</tr>"
else
   echo "<tr>"
    echo  "<td>" 
    echo  "$podname"
    echo  "</td>"
    echo  "<td>"
    cat /root/container/${podname}.yaml |grep image|head -1|cut -f2 -d'-'
    echo  "</td>"
    echo  "<td>"
    cat /root/container/${podname}.yaml | grep '^#'|sed 's/#//'
    echo  "</td>"
    echo  "<td>Port forwarding is not done yet ask System Admin</td>"
    echo "</tr>"

fi
   
 
done< /tmp/pod_listing.txt
echo "</table>"

#echo "</p>###########</p>"
