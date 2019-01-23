#!/bin/bash

cd /var/www/project/code

for dir in `find . -type d`
do
    if [[ $dir = *"./Controllers" ]]
    then
        echo $dir
        rm -rf /var/www/project/app/Http/Controllers
        mv -v $dir /var/www/project/app/Http/
    fi

    if [[ $dir = *"./Models" ]]
    then
        echo $dir
        rm -rf /var/www/project/app/Models
        mv -v $dir /var/www/project/app/
    fi

    if [[ $dir = *"./migrations" ]]
    then
        echo $dir
        rm -rf /var/www/project/database/migrations
        mv -v $dir /var/www/project/database/
    fi

    if [[ $dir = *"./routes" ]]
    then
        echo $dir
        rm -rf /var/www/project/routes
        mv -v $dir /var/www/project/
    fi
done

cd /var/www/project

php artisan migrate
php -S 0.0.0.0:9000 -t public
