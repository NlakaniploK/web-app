#! /bin/bash
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install docker-ce -y
sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker
sudo usermod -aG docker ubuntu
sudo docker pull nlakaniplok/dotnet-app:latest
sudo docker run --rm -p 5000:5000 -e ASPNETCORE_HTTP_PORT=https://+:5001 -e ASPNETCORE_URLS=http://+:5000 nlakaniplok/dotnet-app:latest