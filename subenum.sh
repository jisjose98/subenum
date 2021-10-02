#!/bin/bash

clear
#red='tput setaf 1'
#green='tput setaf 2'   #using tput pkg to set colour in foreground
#blue='tput setaf 4'
#reset='tput sgr0'
#bold='tput bold'

banner()
{
#P=$(tput setaf 125)
#red='tput setaf 1'
#green='tput setaf 2'   #using tput pkg to set colour in foreground
#blue='tput setaf 4'
#reset='tput sgr0'
#bold='tput bold'

echo -e \n"
      ██╗██╗███████╗███████╗    ███████╗██╗   ██╗██████╗ ███████╗███╗   ██╗██╗   ██╗███╗   ███╗███████╗██████╗ 
      ██║██║██╔════╝██╔════╝    ██╔════╝██║   ██║██╔══██╗██╔════╝████╗  ██║██║   ██║████╗ ████║██╔════╝██╔══██╗
      ██║██║███████╗███████╗    ███████╗██║   ██║██████╔╝█████╗  ██╔██╗ ██║██║   ██║██╔████╔██║█████╗  ██████╔╝
 ██   ██║██║╚════██║╚════██║    ╚════██║██║   ██║██╔══██╗██╔══╝  ██║╚██╗██║██║   ██║██║╚██╔╝██║██╔══╝  ██╔══██╗
 ╚█████╔╝██║███████║███████║    ███████║╚██████╔╝██████╔╝███████╗██║ ╚████║╚██████╔╝██║ ╚═╝ ██║███████╗██║  ██║
  ╚═══╝ ╚═╝╚══════╝╚══════╝    ╚══════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝"
 																		echo "Credits:Jiss Jose"
}

#echo "Installing dependencies"
#
		checkersubl=$(command -v sublist3r | wc -l)
		checkerrobe=$(command -v httprobe | wc -l)
	if [[ checkersubl -eq 0 ]] || [[ checkerrobe -eq 0 ]]; then
		installer()
		{
			echo "sublist3r installing..."
			sudo apt-get update -y;
			sudo apt-get install assetfinder -y;
			sudo apt-get install subfinder httprobe -y;
			apt-get install ncurses-bin -y;
			apt-get update;
			echo "if any problem run "apt-get --fix-missing""
			echo "Done ready to go";
			echo "rerunning"
			exit
		}
		installer
		echo "or check completed"
		exit
	elif [[ checkerrobe -eq 1 ]] && [[ checkersubl -eq 1 ]]; then
		echo "done installing dependencies check"
		echo "and check completed"
		clear
		banner

																				
#banner

		echo "What do you want to enumerate or OSINT.Enter your choice"
		echo "1	: for Checking ipv4,ipv6,CNAME"
		echo "2	: for subdomain enumerate"
		echo "Check DNS info,ipv4,ipv6,CNAME record";
	fi                                               #for working 1
	read -p "Please enter your choice::" ch;

	if [[ $ch -eq 1 ]]; then
		echo "case 1 executed via ifelse"	
		
		dns_enum()
		{
		read -p "Enter domain name::" domain
		echo "Target domain=" "$domain"
		echo "Checking DNS info using digtool"
		ipv4=$(dig $domain A +short)
		echo "ipv4 is" \n "$ipv4";
		echo "++++++++++++finished++++++++";
		echo -e "Ipv4 Checked" \n "Next checking ipv6"
		ipv6=$(dig $domain AAAA +short)
		echo -e "$ipv6 is" \n $ipv6
		echo "++++++++++++finished++++++++";
		echo "CNAME Record"
		cname=$(dig $domain CNAME +short)
		echo -e "$cname is" \n $cname
		echo "-******finished---****"
		echo "MX Record"
		mx=$(dig $domain MX +short)
		echo -e "MX record of $domain is" \n "$mx"
		echo "----Finished DNS info records---"
		}
		dns_enum
		exit
	elif [[ $ch -eq 2 ]]; then
		echo "Case 2 executed via if else2"
#		#begin replaced with dev                   #calling another function within function
		path=$(pwd);	
begin()
{
echo "Enter domain name for subdomain enumeration"
read -p "Enter domain:" subenum
rm -rf subs.txt;

}
begin

#assetfinder()
#{
#assetfinder -subs-only $subenum >> $path/tmp/subs.txt | tee
#sleep 30
#count=$(assetfinder -subs-only $subenum | wc -l)
#sleep 2
#echo "subdomains found using assetfinder for $subenum is $count"
#}
#assetfinder;

#echo "assetfinder ended"



sublist3re()
{
echo "Sublist3r"
sleep 5
sublist3r -d $subenum -o subl.txt
count=$(sublist3r -d $subenum | wc -l)
echo "subdomains found using sublist3r for $subenum is $count"
}
sublist3re

sleep 5
echo "Sublist3r ended"

subfindere()
{
echo "Subfinder"
subfinder -d $subenum -o subf.txt | tee;
count=$(subfinder -d $subenum | wc -l)
echo "subdomains found using subfinder for $subenum is $count"
}
subfindere

echo "subfinder ended"

#amassed()
#{
#	echo "Amass scan started"
#amass enum -d $subenum -passive -o output.txt
#echo "Amass scan finished"
#}
#amassed
#sleep 5;
sleep 4
sed -n p subl.txt subf.txt > $(pwd)/subs.txt

echo "Now sorting the list using sort tool"
rm -rf subf subl
	fi
		
#check file name 
alived()
{
alive=$(cat subs.txt | httprobe | tee $path/alive.txt);
count2=$(cat alive.txt | wc -l)  #for no of words
echo "alive subdomains is $count2"
}
alived

#string=(cat alive.txt | grep http)
#if [[ $string -eq http ]]; then
	
#touch urls.txt;
fileread()
{
file=alive.txt     #take 1st argument as file
while read urls;do    #read and save to url variable
	echo "${urls#*//}"  >> urls.txt;      #test to see url printing and strip https and http
done < alive.txt;    #take input file
sleep 3;
}
fileread

duper()
{
	echo "Removing dupes"
sort -u urls.txt > sorted_subs.txt;   # to sort remove dupes
count3=$(cat sorted_subs.txt | wc -l);
echo "$count3 number is left after sorting out duplicates " 
rm -rf tmp_file.txt tmp_file   #remove tmp file created
rm -rf url.txt        #remove url file
}
	duper
#fi

echo "Script execution completed successfully"
	
