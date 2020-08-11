#!/bin/bash

ix=1
for i in "$@"
do

if [[ ix -eq 1 ]];then
    podname=$i
elif [[ ix -eq 2 ]];then
    podtype=$i
elif [[ ix -eq 3 ]];then
    description=$i
elif [[ ix -eq 4 ]];then
    email=$i
fi

ix=`expr $ix + 1`

done



podimage=""

echo $description

if [[ "$podtype" = "Centos6" ]];then
   podimage="gdb-centos6-ssh"
elif [[ "$podtype" = "Centos7" ]];then
   podimage="gdb-centos7-ssh"
elif [[ "$podtype" = "Centos8" ]];then
   podimage="gdb-centos8-ssh"
else
   podimage="NA"
   echo "wrong option"
   exit 0
fi   

ls /root/container/{podname}.yaml 
if [[ $? -eq 0 ]];then
   echo "pod name exist please retry with new name"
   exit 0
fi

cat <<EOF>/root/container/${podname}.yaml
#$description
---
apiVersion: v1
kind: Pod
metadata:
  name: ${podname}
  labels:
    app: gdb-common
spec:
  containers:
    - name: $podimage
      image: $podimage:local
      imagePullPolicy: Never
      ports:
        - containerPort: 22

EOF


kubectl apply -f /root/container/${podname}.yaml
RC=$?
sleep 60 
if [[ $RC -ne 0 ]];then
  echo "Not able to create pod"
  exit 0
fi

x=2020

while true;
do
  netstat -tanp |grep :$x
  if [[ $? -eq 0 ]];then
     x=`expr $x + 1`
  else
     break;
  fi   
done

port=`expr $x - 2000`
port1=`expr $port + 2200`
kubectl port-forward $podname $x:22 &
socat TCP-LISTEN:$port1,fork TCP:127.0.0.1:$x &
cat <<EOF >body.txt
Your pod ${podname} is created 
pod IP is `hostname -i`
pod port is $port1
Description of pod is $description
OS type is $podtype
Date is `date`
EOF

mail -s "Pod creation `date`"  -r pod@rocketsoftware.com $email < body.txt

#echo "header('Locations: index.php');"
