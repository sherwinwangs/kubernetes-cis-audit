#!/bin/bash


declare -A master_configuration_file_items node_configuration_file_items

master_configuration_file_items=(
    [apiserver_pod_specification_file]="/etc/kubernetes/manifests/kube-apiserver.yaml"
    [controller_manager_pod_specification_file]="/etc/kubernetes/manifests/kube-controller-manager.yaml"
    [scheduler_pod_specification_file]="/etc/kubernetes/manifests/kube-scheduler.yaml"
    [etcd_pod_specification_file]="/etc/kubernetes/manifests/etcd.yaml"
    [cni_file]="/opt/cni/bin/"
    [etcd_data_directory]="/var/lib/etcd"
    [admin_conf_file]="/root/.kube/config"
    [scheduler_conf_file]="/etc/kubernetes/scheduler.conf"
    [controller_manager_conf_file]="/etc/kubernetes/controller-manager.conf"
    [pki_directory_and_file]="/etc/kubernetes/pki"
    [pki_cert_file]="/etc/kubernetes/pki/"
    [pki_key_file]="/etc/kubernetes/pki"
)

node_configuration_file_items=(
    [kubelet_service_file]="/etc/shadow"
    [proxy_kubeconfig_file]="/etc/hosts"
    [kubelet_arg_kubeconfig_kubelet_conf_file]="/etc/sudoers"
    [kubelet_ca_file]="/etc/resolv.conf"
    [kubelet_arg_config_configuration_file]="/etc/hosts"
)

tls_cipher_suites_allowed="TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305"
