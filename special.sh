#!/bin/bash

# todo
kube_controller_manager_arg_rotatekubeletservercertificate(){
    chapter="${1}"
    process_name="${2}"
    res_name=$(detect_process_and_args ${process_name} get_name "--feature-gates")
    res_value=$(detect_process_and_args ${process_name} get_value "--feature-gates")
    if [[ -z "${res_name}" ]];then echo -e $(show warn ${chapter} "feature gates not set");return 1;fi
    feature_gates_arr=(${res_value//,/ })
    for feature in ${feature_gates_arr[@]};do
        key=$(echo ${feature}|awk -F "=" '{print $1}')
        if [[ ${key} == "RotateKubeletServerCertificate" ]];then
            value=$(echo ${feature}|awk -F "=" '{print $2}')
            if [[ "${vaule}" == "true" ]];then
                echo -e $(show pass ${chapter});return 0;
            fi
        fi
    done
   echo -e $(show warn ${chapter} "feature gates RotateKubeletServerCertificate not set")
}
