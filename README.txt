Add the following lines to the "Exec Shell" in Job configuration in Jenkins dashboard for CI-CD:

#!/bin/bash
ssh -i /var/lib/jenkins/.ssh/id_rsa ubuntu@172.31.10.86 "
sudo rm -rf /home/ubuntu/Docker_CI-CD/ChatApp
"
echo "copying latest directory of appplication from docker server started..."
rsync -r /var/lib/jenkins/workspace/ChatApp ubuntu@172.31.10.86:/home/ubuntu/Docker_CI-CD/

ssh -i /var/lib/jenkins/.ssh/id_rsa ubuntu@172.31.10.86 "
cd Docker_CI-CD
sudo su -c '
echo "Stopping and removing Container and Image of Mysql"
docker stop sql
docker rm sql
docker rmi sql
echo "Stopping and removing Container and Image of ChatApp"
docker stop chatapp
docker rm chatapp
docker rmi chatapp
echo "Stopping and removing Container and Image of Nginx"
docker stop mynginx
docker rm mynginx
docker rmi iamamit/devoops:webserver-nginx
echo "Configuring Mysql Database"
cd db
docker build -t sql .
docker run -d --name sql sql:latest
echo "Configuring ChatApp"
cd ..
docker build -t chatapp .
docker run -d -p 8000:8000 --link sql:sql --name chatapp chatapp
echo "Configuring NGINX"
docker pull iamamit/devoops:webserver-nginx
docker run -p 80:80 --link=chatapp -d --name mynginx iamamit/devoops:webserver-nginx
'
sudo docker restart mynginx
"
