#!/usr/bin/env sh
# 1. register account ./acme.sh --register-account -m email@example.com
#
# 2. create api pasword https://cp.beget.com/settings/access/api
#
# 3. export login and password
# export BEGET_LOGIN="login"
# export BEGET_PASSWORD="PaSsWoRd"

# 4. run:
# ./acme.sh --issue -d '*.example.com' --dns dns_beget --reloadcmd 'service apache2 reload'

# update cert 
# ./acme.sh --renew -d '*.example.com' --force --reloadcmd 'service apache2 reload'


# API: https://beget.com/ru/kb/api/funkczii-upravleniya-dns 

curl=$(which curl)
api="https://api.beget.com/api/dns"

########  Public functions  #####################

dns_beget_add() {
    fulldomain=$1
    txtvalue=$2
    curData="{\"fqdn\":\"${fulldomain}\",\"records\":{\"TXT\":[{\"value\": \"${txtvalue}\"}]}}"
    _info "Adding record ${fulldomain} value: ${txtvalue}"

    ${curl} \
        --data-urlencode "login=${BEGET_LOGIN}" \
        --data-urlencode "passwd=${BEGET_PASSWORD}" \
        --data-urlencode "output_format=json" \
        --data-urlencode "input_format=json" \
        --data-urlencode "input_data=${curData}" \
        "${api}/changeRecords"

    return 0
}

dns_beget_rm() {
    #fulldomain=$1
    #_info "Deletet txt record ${fulldomain}"
    return 0
}
