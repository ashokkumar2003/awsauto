#!/bin/bash
echo "Gitting ip list"
python /mnt/get-sg.py > /mnt/HostMeta.txt
echo "Ip list done"

source /mnt/ServiceMeta.txt
source /mnt/HostMeta.txt
n=`cat /mnt/HostMeta.txt | wc -l`

for i in `seq 1 2`
do
    varHost="HostSG$i"
    eval "HostGroup=\${$varHost[@]}"
echo "$varHost"
echo "$HostGroup"
    for host in $HostGroup
    do
        varServices="ServicesSG$i"
        eval "ServicesGroup=\${$varServices[@]}"
	 for service in $ServicesGroup
        do
            echo "------------ Deploying on $host -> $service"

        rsync -avizpg -O  --exclude=.git -e "ssh -i /opt/free.pem" --rsync-path="sudo rsync" /opt/$service ec2-user@$host:/var/www/html/
done
done

		#ssh -i /root/page1.pem  page1user@$host "sudo service nginx status | awk '{if(\$4!=\"running\") {system(\"sudo service nginx start\")}}'"

	#	echo "----------- Nginx service is started"




done

now=$(date +'%Y-%m-%dT-%H-%M-%S')
echo "----------- Code Deployed on all the servers at $now ------------"
