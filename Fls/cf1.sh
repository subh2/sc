#!/bin/bash
MYIP=$(wget -qO- icanhazip.com);
apt install jq curl -y
clear
echo -e ""
echo -e "\033[96;1m============================\033[0m"
echo -e "\033[93;1m      INPUT SUBDOMAIN"
echo -e "\033[96;1m============================\033[0m"
echo -e "\033[91;1m Note. contoh Subdomain :\033[0m \033[93mbodoh22 \033[0m"
echo -e " "
read -p "SUBDOMAIN :  " SUB
echo -e ""
DO="tokodswara.my.id"
SUB_DOMAIN=${SUB}.${DO}
NS_DOMAIN=*.${SUB_DOMAIN}
CF_KEY=64a18c14afb45351140fad994e00ffded2dad
set -euo pipefail
echo "Pointing Domain for $SUB_DOMAIN..."
ZONE=$(
		curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DO}&status=active" \
		-H "Authorization: Bearer ${CF_KEY}" \
		-H "Content-Type: application/json" | jq -r .result[0].id
	)

	RECORD=$(
		curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
		-H "Authorization: Bearer ${CF_KEY}" \
		-H "Content-Type: application/json" | jq -r .result[0].id
	)
	
	RECORD1=$(
		curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${NS_DOMAIN}" \
		-H "Authorization: Bearer ${CF_KEY}" \
		-H "Content-Type: application/json" | jq -r .result[0].id
	)

	if [[ "${#RECORD}" -le 10 ]]; then
		RECORD=$(
			curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
			-H "Authorization: Bearer ${CF_KEY}" \
			-H "Content-Type: application/json" \
			--data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${MYIP}'","proxied":false}' | jq -r .result.id
		)
	else
		RESULT=$(
		curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
		-H "Authorization: Bearer ${CF_KEY}" \
		-H "Content-Type: application/json" \
		--data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${MYIP}'","proxied":false}'
	)
	fi
		
	if [[ "${#RECORD1}" -le 10 ]]; then
		RECORD2=$(
			curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
			-H "Authorization: Bearer ${CF_KEY}" \
			-H "Content-Type: application/json" \
			--data '{"type":"A","name":"'${NS_DOMAIN}'","content":"'${MYIP}'","proxied":true}' | jq -r .result.id
		)
	else

	RESULT2=$(
		curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD1}" \
		-H "Authorization: Bearer ${CF_KEY}" \
		-H "Content-Type: application/json" \
		--data '{"type":"A","name":"'${NS_DOMAIN}'","content":"'${MYIP}'","proxied":true}'
	)	
	fi
echo "IP=" >> /var/lib/kyt/ipvps.conf
echo $SUB_DOMAIN > /etc/xray/domain
echo $SUB_DOMAIN > /root/domain
cd
