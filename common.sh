#!/bin/bash

# display stdout messages
function show(){
    source ./config/cis_items.sh
    case ${1} in
       "pass" )
            printf "\033[1;32m[PASS]\033[0m ${2} ${cis_items["${2}"]}";;
       "warn" )
            printf "\033[1;31m[WARN]\033[0m ${2} ${cis_items["${2}"]} \033[1;31m[current: ${3}\033[0m]";;
       "erro" )
            printf "\033[0;31m[ERRO]\033[0m \033[0;33merr_msg: ${2}\033[0m";;
       * )
            printf "\033[0;36m[IGNO]\033[0m ${2} ${cis_items["${2}"]}";;
    esac
}

# detect process exist,and return cmdline args name or value
function detect_process_and_args(){
    process_name=${1}
    operation=${2}
    cmdline_arg=${3}
    pid=$(pgrep ${process_name} || ps -ef |grep ${process_name} |grep -v "grep"|awk '{print $2}'|head -n 1) #when process running in containers, cannot get pid
    #pid=$(ps -ef |grep ${process_name} |grep -v "grep"|awk '{print $2}'|head -n 1)
    #echo "pid ${pid}" 
    if [[ "${pid}" == "" || -z "${pid}" ]];then
       #echo "not found"
       return 1
    else
       if [ "${operation}" == "get_name" ];then
           cat /proc/${pid}/cmdline |strings -1|grep -E "\\${cmdline_arg}" |cut -d "=" -f1
       fi
       if [ "${operation}" == "get_value" ];then
           cat /proc/${pid}/cmdline |strings -1|grep -E "\\${cmdline_arg}" |cut -d "=" -f2-
       fi
       return 0
    fi
}

# stat -c %a  u && g && o
function check_permission(){
    filename=${1}
    required_permission=${2}
    file_permission=$(stat -c %a ${filename})
    if [[ "${file_permission:0:0}" -le "${required_permission:0:0}" ]] &&
       [[ "${file_permission:1:1}" -le "${required_permission:1:1}" ]] &&
       [[ "${file_permission:2:2}" -le "${required_permission:2:2}" ]];then
       echo "ok"
    else
       echo "${file_permission}"
    fi
}

#stat -c %U:%G
function check_ownership(){
    filename=${1}
    required_ownership=${2}
    file_ownership=$(stat -c %U:%G ${filename})
    if [ "${file_ownership}" == "${required_ownership}" ];then echo "ok";else echo "${file_ownership}";fi
}

function check_ownership_and_permission(){
    operation="$1"  #permission,ownership,exist
    filename="$2"
    required_value="$3"
    chapter="$4"
    if [[ ${filename} != "" ]]  && [[ -f ${filename} || -d ${filename} ]];then
        if [[ ${operation} == "permission" ]];then
            permission=$(check_permission ${filename} ${required_value})
            if  [[ "ok" == "${permission}" ]];then
                echo -e $(show pass ${chapter})
            else
                echo -e $(show warn ${chapter} ${permission})
           fi
        fi
        if [[ ${operation} == "ownership" ]];then
            ownership=$(check_ownership ${filename} ${required_value})
            if  [[ "ok" == "${ownership}" ]];then
                echo -e $(show pass ${chapter})
            else
                echo -e $(show warn ${chapter} ${ownership})
            fi
        fi
        return 0
    else
       echo -e $(show warn ${chapter} "${filename} not found");return 1
    fi
}

function check_strong_cryptographic_ciphers(){
    chapter="${1}"
    process_name="${2}"
    res_name=$(detect_process_and_args ${process_name} get_name "--tls-cipher-suites")
    res_value=$(detect_process_and_args ${process_name} get_value "--tls-cipher-suites")
    res_cipher_arr=(${res_value//,/ })
    tls_cipher_allowed=$(echo ${tls_cipher_suites_allowed} |tr "," " ")
    if [[ -z "${res_name}" ]];then echo -e $(show warn ${chapter} "not set");return 1 ;fi
    for cipher in ${res_cipher_arr[@]};do
        if_exist=$(echo ${tls_cipher_suites_allowed}|grep -q ${cipher};echo $?)
        if [ "${if_exist}" != "0" ];then echo -e $(show warn ${chapter} "${cipher} not allowed");return 1;fi
    done
    echo -e $(show pass ${chapter});return 0
}

check_ignore_chapter(){
   chapter="${1}"
   echo -e $(show ignore ${chapter})
}

function check_args_and_values(){
   chapter="$1"
   process_name="$2"
   operation="$3" #check_arg,check_value,check_sub_arg,check_sub_value
   argname="$4" 
   operator="$5" # match not_match not_none is_none contain not_contain
   required_value="$6"
   if [ "${operation}" == "check_name" ];then
       res=$(detect_process_and_args ${process_name} get_name ${argname})
   elif [ "${operation}" == "check_value" ];then
       res=$(detect_process_and_args ${process_name} get_value ${argname})
   elif [ "${operation}" == "custom_function" ];then
       "${required_value}" "${chapter}" "${process_name}";return 0
   fi

   if [ "${operator}" == "match" ];then 
       if [[ -z "$res" ]];then echo -e $(show warn ${chapter} "not set");return 1; fi
       if [[ ${res} == ${required_value} ]];then echo -e $(show pass ${chapter});else echo -e $(show warn ${chapter} "${res}");fi
   elif [ "${operator}" == "not_match" ];then
       if [[ ${res} != ${required_value} ]];then echo -e $(show pass ${chapter});else echo -e $(show warn ${chapter} "${res}");fi
   elif [ "${operator}" == "not_none" ];then
       if [[ ! -z ${res} ]];then echo -e $(show pass ${chapter});else echo -e $(show warn ${chapter} "not set");fi
   elif [ "${operator}" == "is_none" ];then
       if [[ -z ${res} ]];then echo -e $(show pass ${chapter});else echo -e $(show warn ${chapter} "is set");fi
   elif [ "${operator}" == "match_and_exist" ];then
       if [[ "$(check_ownership_and_permission exist ${res};echo $?)" == "0" ]];then echo -e $(show pass ${chapter});else echo -e $(show warn ${chapter} "not exist");fi 
   elif [ "${operator}" == "contain" ];then
       for i in $(echo ${res}|tr "," " ");do 
           if [ "${i}" == "${required_value}" ];then echo -e $(show pass ${chapter});return 0;fi
       done
       echo -e $(show warn ${chapter} "not set");return 1
   elif [ "${operator}" == "not_contain" ];then
       for i in $(echo ${res}|tr "," " ");do
           if [ "${i}" == "${required_value}" ];then echo -e $(show warn ${chapter} ${res});return 1;fi
       done
       echo -e $(show pass ${chapter});return 0
   fi
}

# custom function
source ./special.sh
