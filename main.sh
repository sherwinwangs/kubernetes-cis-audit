#!/bin/bash

source ./common.sh

# 1.1 Control Plane Components, Master Node Configuration Files
function master_configuration_file_permission_audit(){
    echo "#### master_configuration_file_permission_audit ####"
    source ./config/config.sh
    check_ownership_and_permission permission ${master_configuration_file_items["apiserver_pod_specification_file"]} 644 1.1.1
    check_ownership_and_permission ownership ${master_configuration_file_items["apiserver_pod_specification_file"]} root:root 1.1.2
    check_ownership_and_permission permission ${master_configuration_file_items["controller_manager_pod_specification_file"]} 644 1.1.3
    check_ownership_and_permission ownership ${master_configuration_file_items["controller_manager_pod_specification_file"]} root:root 1.1.4
    check_ownership_and_permission permission ${master_configuration_file_items["scheduler_pod_specification_file"]} 644 1.1.5
    check_ownership_and_permission ownership ${master_configuration_file_items["scheduler_pod_specification_file"]} root:root 1.1.6
    check_ownership_and_permission permission ${master_configuration_file_items["etcd_pod_specification_file"]} 644 1.1.7
    check_ownership_and_permission ownership ${master_configuration_file_items["etcd_pod_specification_file"]} root:root 1.1.8
    check_ownership_and_permission permission ${master_configuration_file_items["cni_file"]} 644 1.1.9
    check_ownership_and_permission ownership ${master_configuration_file_items["cni_file"]} root:root 1.1.10
    check_ownership_and_permission permission ${master_configuration_file_items["etcd_data_directory"]} 700 1.1.11
    check_ownership_and_permission ownership ${master_configuration_file_items["etcd_data_directory"]} etcd:etcd 1.1.12
    check_ownership_and_permission permission ${master_configuration_file_items["admin_conf_file"]} 644 1.1.13
    check_ownership_and_permission ownership ${master_configuration_file_items["admin_conf_file"]} root:root 1.1.14
    check_ownership_and_permission permission ${master_configuration_file_items["scheduler_conf_file"]} 644 1.1.15
    check_ownership_and_permission ownership ${master_configuration_file_items["scheduler_conf_file"]} root:root 1.1.16
    check_ownership_and_permission permission ${master_configuration_file_items["controller_manager_conf_file"]} 644 1.1.17
    check_ownership_and_permission ownership ${master_configuration_file_items["controller_manager_conf_file"]} root:root 1.1.18
    check_ownership_and_permission ownership ${master_configuration_file_items["pki_directory_and_file"]} root:root 1.1.19
    check_ownership_and_permission permission ${master_configuration_file_items["pki_cert_file"]} 644 1.1.20
    check_ownership_and_permission permission ${master_configuration_file_items["pki_key_file"]} 600 1.1.21
}


# 1.2 API Server
function kube_apiserver_audit(){
    echo "#### kube_apiserver_audit ####"
    process_name="kube-apiserver"
    if [ "$(detect_process_and_args ${process_name};echo $?)" != "0" ];then echo -e $(show erro "${process_name} is not running, all item about this components ignored");return 1;fi
    check_args_and_values "1.2.1" "${process_name}" "check_value" "--anonymous-auth" "match" "false"
    check_args_and_values "1.2.2" "${process_name}" "check_name" "--anonymous-auth" "is_none"
    check_args_and_values "1.2.3" "${process_name}" "check_name" "--token-auth-file" "is_none"
    check_args_and_values "1.2.4" "${process_name}" "check_value" "--kubelet-https" "match" "true"
    check_args_and_values "1.2.5" "${process_name}" "check_value" "--kubelet-client-certificate" "match_and_exist"
    check_args_and_values "1.2.5" "${process_name}" "check_value" "--kubelet-client-key" "match_and_exist"
    check_args_and_values "1.2.6" "${process_name}" "check_value" "--kubelet-certificate-authority" "match_and_exist"
    check_args_and_values "1.2.7" "${process_name}" "check_value" "--authorization-mode" "not_contain" "AlwaysAllow"
    check_args_and_values "1.2.8" "${process_name}" "check_value" "--authorization-mode" "contain" "Node"
    check_args_and_values "1.2.9" "${process_name}" "check_value" "--authorization-mode" "contain" "RBAC"
    check_args_and_values "1.2.10" "${process_name}" "check_value" "--enable-admission-plugins" "contain" "EventRateLimit"
    check_args_and_values "1.2.11" "${process_name}" "check_value" "--enable-admission-plugins" "not_contain" "AlwaysAdmit"
    check_args_and_values "1.2.12" "${process_name}" "check_value" "--enable-admission-plugins" "contain" "AlwaysPullImages"
    check_args_and_values "1.2.13" "${process_name}" "custom_function" "not_used" "not_used" "check_ignore_chapter" #ignore
    check_args_and_values "1.2.14" "${process_name}" "check_value" "--enable-admission-plugins" "contain" "ServiceAccount"
    check_args_and_values "1.2.15" "${process_name}" "check_value" "--enable-admission-plugins" "contain" "NamespaceLifecycle"
    check_args_and_values "1.2.16" "${process_name}" "check_value" "--enable-admission-plugins" "contain" "PodSecurityPolicy"
    check_args_and_values "1.2.17" "${process_name}" "check_value" "--enable-admission-plugins" "contain" "NodeRestriction"
    check_args_and_values "1.2.18" "${process_name}" "check_name" "--insecure-bind-address" "is_none"
    check_args_and_values "1.2.19" "${process_name}" "check_value" "--insecure-port" "match" "0"
    check_args_and_values "1.2.20" "${process_name}" "check_value" "--secure-port" "not_match" "0"
    check_args_and_values "1.2.21" "${process_name}" "check_value" "--profiling" "match" "false"
    check_args_and_values "1.2.22" "${process_name}" "check_name" "--audit-log-path" "not_none"
    check_args_and_values "1.2.23" "${process_name}" "check_name" "--audit-log-maxage" "not_none"
    check_args_and_values "1.2.24" "${process_name}" "check_name" "--audit-log-maxbackup" "not_none"
    check_args_and_values "1.2.25" "${process_name}" "check_name" "--audit-log-maxsize" "not_none"
    check_args_and_values "1.2.26" "${process_name}" "check_name" "--request-timeout" "not_none"
    check_args_and_values "1.2.27" "${process_name}" "check_value" "--service-account-lookup" "match" "true"
    check_args_and_values "1.2.28" "${process_name}" "check_value" "--service-account-key-file" "match_and_exist"
    check_args_and_values "1.2.29" "${process_name}" "check_value" "--etcd-certfile" "match_and_exist"
    check_args_and_values "1.2.29" "${process_name}" "check_value" "--etcd-keyfile" "match_and_exist"
    check_args_and_values "1.2.30" "${process_name}" "check_value" "--tls-cert-file" "match_and_exist"
    check_args_and_values "1.2.30" "${process_name}" "check_value" "--tls-private-key-file" "match_and_exist"
    check_args_and_values "1.2.31" "${process_name}" "check_value" "--client-ca-file" "match_and_exist"
    check_args_and_values "1.2.32" "${process_name}" "check_value" "--etcd-cafile" "match_and_exist"
    check_args_and_values "1.2.33" "${process_name}" "check_name" "--encryption-provider-config" "not_none"
    check_args_and_values "1.2.34" "${process_name}" "custom_function" "not_used" "not_used" "check_ignore_chapter"
    check_args_and_values "1.2.35" "${process_name}" "custom_function" "not_used" "not_used" "check_strong_cryptographic_ciphers"
}
# 1.3 Controller Manager
function kube_controller_manager_audit(){
    echo "#### kube_controller_manager_audit ####"
    process_name="kube-controller-manager"
    if [ "$(detect_process_and_args ${process_name};echo $?)" != "0" ];then echo -e $(show erro "${process_name} is not running, all item about this components ignored");return 1;fi
    check_args_and_values "1.3.1" "${process_name}" "check_name" "--terminated-pod-gc-threshold" "not_none"
    check_args_and_values "1.3.2" "${process_name}" "check_value" "--profiling" "match" "false"
    check_args_and_values "1.3.3" "${process_name}" "check_value" "--use-service-account-credentials" "match" "true"
    check_args_and_values "1.3.4" "${process_name}" "check_value" "--service-account-private-key-file" "match_and_exist"
    check_args_and_values "1.3.5" "${process_name}" "check_value" "--root-ca-file" "match_and_exist"
    kube_controller_manager_arg_rotatekubeletservercertificate "1.3.6" "${process_name}"
    check_args_and_values "1.3.7" "${process_name}" "check_value" "--bind-address" "match" "127.0.0.1"
}
# 1.4 Scheduler
function kube_scheduler_audit(){
    echo "#### kube_scheduler_audit #### "
    process_name="kube-scheduler"
    if [ "$(detect_process_and_args ${process_name};echo $?)" != "0" ];then echo -e $(show erro "${process_name} is not running, all item about this components ignored");return 1;fi
    check_args_and_values "1.4.1" "${process_name}" "check_value" "--profiling" "match" "false"
    check_args_and_values "1.4.2" "${process_name}" "check_value" "--address" "match" "127.0.0.1"
}

# 2 etcd
function etcd_audit(){
    echo  "#### etcd_audit ####"
    process_name="etcd"
    if [ "$(detect_process_and_args ${process_name};echo $?)" != "0" ];then echo -e $(show erro "${process_name} is not running, all item about this components ignored");return 1;fi
    check_args_and_values "2.1" "${process_name}" "check_value" "--cert-file" "match_and_exist"
    check_args_and_values "2.1" "${process_name}" "check_value" "--key-file" "match_and_exist"
    check_args_and_values "2.2" "${process_name}" "check_value" "--client-cert-auth" "match" "true"
    check_args_and_values "2.3" "${process_name}" "check_value" "--auto-tls" "not_match" "true"
    check_args_and_values "2.4" "${process_name}" "check_value" "--peer-cert-file" "match_and_exist"
    check_args_and_values "2.4" "${process_name}" "check_value" "--peer-key-file" "match_and_exist"
    check_args_and_values "2.5" "${process_name}" "check_value" "--peer-client-cert-auth" "match" "true"
    check_args_and_values "2.6" "${process_name}" "check_value" "--peer-auto-tls" "not_match" "true"
    check_args_and_values "2.7" "${process_name}" "custom_function" "not_used" "not_used" "check_ignore_chapter"
}
# 3 Control Plane Configuration
# TODO

# 4.1 Worker Nodes,Worker Node Configuration Files
function node_configuration_file_permission_audit(){
    echo "#### node_configuration_file_permission_audit ####"
    source ./config/config.sh
    check_ownership_and_permission permission ${node_configuration_file_items["kubelet_service_file"]} 644 4.1.1
    check_ownership_and_permission ownership ${node_configuration_file_items["kubelet_service_file"]} root:root 4.1.2
    if [[ ! -z "${node_configuration_file_items["proxy_kubeconfig_file"]}" ]];then
       check_ownership_and_permission permission ${node_configuration_file_items["proxy_kubeconfig_file"]} 644 4.1.3
       check_ownership_and_permission ownership ${node_configuration_file_items["proxy_kubeconfig_file"]} root:root 4.1.4
    fi
    check_ownership_and_permission permission ${node_configuration_file_items["kubelet_arg_kubeconfig_kubelet_conf_file"]} 644 4.1.5
    check_ownership_and_permission ownership ${node_configuration_file_items["kubelet_arg_kubeconfig_kubelet_conf_file"]} root:root 4.1.6
    check_ownership_and_permission permission ${node_configuration_file_items["kubelet_ca_file"]} 644 4.1.7
    check_ownership_and_permission ownership ${node_configuration_file_items["kubelet_ca_file"]} root:root 4.1.8
    check_ownership_and_permission permission ${node_configuration_file_items["kubelet_arg_config_configuration_file"]} 644 4.1.9
    check_ownership_and_permission ownership ${node_configuration_file_items["kubelet_arg_config_configuration_file"]} root:root 4.1.10
}

# 4.2 Worker Nodes,Kubelet
function kubelet_audit(){
    echo "#### kubelet_audit  ####"
    process_name="kubelet"
    if [ "$(detect_process_and_args ${process_name};echo $?)" != "0" ];then echo -e $(show erro "${process_name} is not running, all item about this components ignored");return 1;fi
    check_args_and_values "4.2.1" "${process_name}" "check_value" "--anonymous-auth" "match" "false"
    check_args_and_values "4.2.2" "${process_name}" "check_value" "--authorization-mode" "not_contain" "AlwaysAllow"
    check_args_and_values "4.2.3" "${process_name}" "check_value" "--client-ca-file" "match_and_exist"
    check_args_and_values "4.2.4" "${process_name}" "check_value" "--read-only-port" "match" "0"
    check_args_and_values "4.2.5" "${process_name}" "check_value" "--streaming-connection-idle-timeout" "not_match" "0"
    check_args_and_values "4.2.6" "${process_name}" "check_value" "--protect-kernel-defaults" "match" "true"
    check_args_and_values "4.2.7" "${process_name}" "check_value" "--make-iptables-util-chains" "match" "true"
    check_args_and_values "4.2.8" "${process_name}" "check_name" "--hostname-override" "is_none"
    check_args_and_values "4.2.9" "${process_name}" "check_value" "--event-qps" "match" "0"
    check_args_and_values "4.2.10" "${process_name}" "check_value" "--tls-cert-file" "match_and_exist"
    check_args_and_values "4.2.10" "${process_name}" "check_value" "--tls-private-key-file" "match_and_exist"
    check_args_and_values "4.2.11" "${process_name}" "check_value" "--rotate-certificates" "not_match" "false"
    check_args_and_values "4.2.13" "${process_name}" "custom_function" "not_used" "not_used" "check_strong_cryptographic_ciphers"
}

# 5.1 Policies, RBAC and Service Accounts
# 5.2 Policies, Pod Security Policies
# 5.3 Policies, Network Policies and CNI 
# 5.4 Policies, Secrets Management
# 5.5 Policies, Extensible Admission Control
# 5.7 Policies, General Policies
 
#master_configuration_file_permission_audit
#kube_apiserver_audit
#kube_controller_manager_audit
#kube_scheduler_audit
#etcd_audit
#node_configuration_file_permission_audit
#kubelet_audit


master_check(){
    master_configuration_file_permission_audit
    kube_apiserver_audit
    kube_controller_manager_audit
    kube_scheduler_audit
}

node_check(){
    node_configuration_file_permission_audit
    kubelet_audit
}

case $1 in 
    master )
       master_check;;
    node )
       node_check;;
    etcd )
       etcd_audit;;
    all )
       master_check
       node_check
       etcd_audit;;
    * )
      echo "$0 master|node|etcd|all"
esac
