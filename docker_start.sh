#!/bin/bash

docker-compose down --remove-orphans
echo "Subindo banco"
docker-compose up -d db
echo "Aguardando banco"

while true
do
    string=$(docker-compose logs --tail=1)
    if [[ $string = *"database system is ready to accept connections"* ]]
    then
        echo "Banco iniciado"
        break
    fi
    sleep 1
done

echo "Subindo sistema"
docker-compose up -d --force-recreate --build nginx
echo "Aguardando sistema"
sleep 2
