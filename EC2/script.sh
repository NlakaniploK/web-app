#! /bin/bash
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo docker pull nlakaniplok/dotnet-app:latest
sudo docker run --rm -p 5000:5000 -e ASPNETCORE_HTTP_PORT=https://+:5001 -e ASPNETCORE_URLS=http://+:5000 nlakaniplok/dotnet-app:latest