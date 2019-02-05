#!/bin/bash
d='~/Documents/Misc'
f="$d/InstagramIDs.txt"
if [[ -z $1 ]]; then
    echo "Enter a username."
    exit 0
fi
ex=$(curl -I "https://www.instagram.com/$1/" --silent | grep -o "Page Not Found")
if [[ -z $(ls $d | grep "InstagramIDs.txt") ]]; then
    touch $f
fi
if [[ $1 =~ ^[0-9]+$ ]]; then
    if [[ -z $2 ]]; then
        echo "Enter an access token after the ID to get the username."
    fi
    #ex=$(curl -I "https://i.instagram.com/api/v1/users/$1/info/" --silent | grep -o "HTTP/2 404")
    ex=$(curl -I "https://api.instagram.com/v1/users/$1/?access_token=$2" --silent | grep -o "HTTP/2 404\|HTTP/2 405")
    if [[ -n $ex ]]; then
        echo "ID is invalid or user is suspended."
        if [[ -n $(grep -iF "$1" $f) ]]; then
            echo "Usernames were: $(grep -iF "$1" $f)"
        fi
        exit 0
    else
        #usr=$(curl "https://i.instagram.com/api/v1/users/$1/info/" --silent | sed 's/.*username": "//g; s/".*//g')
        usr=$(curl "https://api.instagram.com/v1/users/$1/?access_token=$2" --silent | sed 's/.*username": "//g; s/".*//g')
        echo "$usr"
        if [[ -z $(grep -iF "$usr" $f) ]]; then
            echo -e "$1  ==>  $usr\n" >> $f
        fi
    fi
    exit 0
elif [[ -n $ex ]]; then
    echo "User doesn't exist, is deactivated or suspended."
    if [[ -n $(grep -iF "$1" $f) ]]; then
            echo "Usernames were: $(grep -iF "$1" $f)"
    fi
    exit 0
else
    id=$(curl --silent "https://www.instagram.com/$1/" | sed -e $'s/,/\\\n/g' | grep '"id":"' | sed 's/"id":"//g; s/"//g' | head -n 1)
    echo $id
    if [[ -z $(grep -iF "$1" $f) ]]; then
        echo -e "$id  ==>  $1\n" >> $f
    fi
fi
exit 0
