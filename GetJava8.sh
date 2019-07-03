#!/bin/bash

function fetch {
 url=$1
 dest=$2
 echo "Fetch $url in $dest"
 mkdir -p "$dest"
 rm -Rf /tmp/extJVM29dk03
 mkdir -p /tmp/extJVM29dk03
 file="${url##*/}"
 ext="${file##*.}"
 curl "$url" -o /tmp/vm.tmp
 if [ "$ext" = "zip" ];
 then
 	unzip -o /tmp/vm.tmp -d /tmp/extJVM29dk03/
 else
    tar -xf /tmp/vm.tmp -C /tmp/extJVM29dk03/
 fi
 mv /tmp/extJVM29dk03/*/* "$dest/"
}

# GetJava8.sh linux64 jdk vms/jdk8/

PLATFORM=$1
TYPE=$2
DEST=$3

echo "Platform $PLATFORM type $TYPE dest $DEST"

declare -A JDK=( 
  	[linux64]="https://cdn.azul.com/zulu/bin/zulu8.38.0.13-ca-jdk8.0.212-linux_x64.tar.gz" 
 	[win64]="https://cdn.azul.com/zulu/bin/zulu8.38.0.13-ca-jdk8.0.212-win_x64.zip"
)

declare -A JRE=(
	[linux64]="https://cdn.azul.com/zulu/bin/zulu8.38.0.13-ca-jre8.0.212-linux_x64.tar.gz"
    [win64]="https://cdn.azul.com/zulu/bin/zulu8.38.0.13-ca-jre8.0.212-win_x64.zip"
)

url=""
if [ "$TYPE" = "jdk" ];
then
   echo "Is jdk"
   url=${JDK[$PLATFORM]}
else
   echo "Is jre"
   url=${JRE[$PLATFORM]}
fi
echo "Url: $url"

fetch "$url" "$DEST"