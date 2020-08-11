#!/bin/bash

podname=$1
port=$2
port1=$3
kubectl delete -f /root/container/${podname}.yaml
if [[  $? -eq 0 ]];then
 pid=`ps aux |grep "kubectl port-forward $podname $port:22" |head -1 |awk -F" " '{print $2}'` 
 kill -9 $pid
 pid2=`ps aux |grep "socat TCP-LISTEN:$port1,fork TCP:127.0.0.1:$port"|head -1|awk -F" " '{print $2}'`
 kill -9 $pid2
 echo "<p> pod deleted </p>"
 rm -f /root/container/${podname}.yaml 
   sleep 60
 #echo "header('Location: index.php');"
else
  echo "<p> error in deleteing </p>"
  sleep 60
fi

