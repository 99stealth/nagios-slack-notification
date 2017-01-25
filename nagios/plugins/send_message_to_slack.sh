#!/bin/bash

usage() {
    echo "TODO Usage"
    exit 3
}

while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -t|--token)
    SLACK_TOKEN="$2"
    shift
    ;;
    -c|--channel)
    SLACK_CHANNEL="$2"
    shift
    ;;
    -t|--notificationtype)
    NOTIFICATIONTYPE="$2"
    shift
    ;;
    -n|--hostname)
    HOST_NAME="$2"
    shift
    ;;
    -a|--hostaddress)
    HOSTADDRESS="$2"
    shift
    ;;
    --hoststate)
    HOSTSTATE="$2"
    shift
    ;;
    --hostoutput)
    HOSTOUTPUT="$2"
    shift
    ;;
    -s|--servicedesc)
    SERVICEDESC="$2"
    shift
    ;;
    --servicestate)
    SERVICESTATE="$2"
    shift
    ;;
    --serviceoutput)
    SERVICEOUTPUT="$2"
    shift
    ;;
    *)
    usage
    ;;
esac
shift # past argument or value
done

if [ ! ${SLACK_TOKEN} ]; then
    echo "Please provide slack token"
    exit 3
elif [ ! ${SLACK_CHANNEL} ]; then
    echo "Please provide a channel for message pushing"
    exit 3
fi

if [[ ${HOST_NAME} ]] && [[ ! ${SERVICEDESC} ]]; then
    slackcli --token ${SLACK_TOKEN} --channel ${SLACK_CHANNEL} -m "\`${NOTIFICATIONTYPE}\` -> \`${HOST_NAME} (${HOSTADDRESS})\` is \`${HOSTSTATE}\`. ${HOSTOUTPUT}" --asUser
elif [[ ${HOST_NAME} ]] && [[ ${SERVICEDESC} ]]; then
    slackcli --token ${SLACK_TOKEN} --channel ${SLACK_CHANNEL} -m "\`${NOTIFICATIONTYPE}\` -> \`${SERVICEDESC}\` is in \`${SERVICESTATE}\` on host \`${HOST_NAME} (${HOSTADDRESS})\`. ${SERVICEOUTPUT}" --asUser
else
    echo "Parameter --hostname is not provided"
    exit 3 
fi
