#!/bin/bash

echo "User Name: "
read username
echo "Password: "
read password
echo "Server: "
read server
echo "Mount point: "
read mount_point

curlftpfs -o allow_other "$username":"$passord"@"$server" "$mount_point"
