#!/usr/bin/env bash

#set -eu

declare INVENTORY="$1"

while read line
do
  if [[ $line =~ ^\[.*\]$ ]] ; then
    continue
  fi

  fi [[ $line =~ ^# ]] ; then
    continue
  fi

  ADDRESS="$(echo $line | awk '{print $1}')"
  USERNAME="$(echo $line | awk '{for(i=1;i<=NF;i++){if($i~/^ansible_ssh_user/) print $i}}' | cut -d '=' -f 2)"
  PASSWORD="$(echo $line | awk '{for(i=1;i<=NF;i++){if($i~/^ansible_ssh_pass/) print $i}}' | cut -d '=' -f 2)"

  ./do-ssh-copy-id.expect "$ADDRESS" "$USERNAME" "$PASSWORD"

done < "${INVENTORY}"