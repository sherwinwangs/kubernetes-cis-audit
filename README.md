## Kubernetes cis audit script



### Description

Auditing & Hardening script for Kubernetes

This script is written to audit kubernetes security refer to CIS document `CIS_Kubernetes_Benchmark_v1.6.0.pdf`

### Usage

```bash
sh main.sh [master|node|etcd|all]

# master used to audit master components
# node used to audit node components
# etcd used to audit etcd service
# all used to audit all componentsa
```

Status

- [PAAS] for OK
- [WARN] Does not meet the requirements in the CIS document
- [ERRO] some error occored,eg. service is not running for check
- [INGO] ignore check

### Code directory

```
├── common.sh   # common function 
├── config
│   ├── cis_items.sh  # cis items as direcctory
│   └── config.sh     # config need to change adjust your environment
├── control-plane-config.sh  # todo
├── docs
│   └── CIS_Kubernetes_Benchmark_v1.6.0.pdf  # CIS doc
├── main.sh      # progrem entrypoint
└── special.sh   # some func does not currency
```



### Demo

```
#### master_configuration_file_permission_audit ####
[PASS] 1.1.1 (level 1) Ensure that the API server pod specification file permissions are set to 644 or more restrictive
[PASS] 1.1.2 (level 1) Ensure that the API server pod specification file ownership is set to root:root
[PASS] 1.1.3 (level 1) Ensure that the controller manager pod specification file permissions are set to 644 or more restrictive
[PASS] 1.1.4 (level 1) Ensure that the controller manager pod specification file ownership is set to root:root
[PASS] 1.1.5 (level 1) Ensure that the scheduler pod specification file permissions are set to 644 or more restrictive
[PASS] 1.1.6 (level 1) Ensure that the scheduler pod specification file ownership is set to root:root
[PASS] 1.1.7 (level 1) Ensure that the etcd pod specification file permissions are set to 644 or more restrictive
[PASS] 1.1.8 (level 1) Ensure that the etcd pod specification file ownership is set to root:root
[WARN] 1.1.9 (level 1) Ensure that the Container Network Interface file permissions are set to 644 or more restrictive [current: 755]
[PASS] 1.1.10 (level 1) Ensure that the Container Network Interface file ownership is set to root:root
[WARN] 1.1.11 (level 1) Ensure that the etcd data directory permissions are set to 700 or more restrictive [current: 755]
[WARN] 1.1.12 (level 1) Ensure that the etcd data directory ownership is set to etcd:etcd [current: root:root]
[PASS] 1.1.13 (level 1) Ensure that the admin.conf file permissions are set to 644 or more restrictive
[PASS] 1.1.14 (level 1) Ensure that the admin.conf file ownership is set to root:root
[PASS] 1.1.15 (level 1) Ensure that the scheduler.conf file permissions are set to 644 or more restrictive
[PASS] 1.1.16 (level 1) Ensure that the scheduler.conf file ownership is set to root:root
[PASS] 1.1.17 (level 1) Ensure that the controller-manager.conf file permissions are set to 644 or more restrictive
[PASS] 1.1.18 (level 1) Ensure that the controller-manager.conf file ownership is set to root:root
[PASS] 1.1.19 (level 1) Ensure that the Kubernetes PKI directory and file ownership is set to root:root
[WARN] 1.1.20 (level 1) Ensure that the Kubernetes PKI certificate file permissions are set to 644 or more restrictive [current: 755]
[WARN] 1.1.21 (level 1) Ensure that the Kubernetes PKI key file permissions are set to 600 [current: 755]
#### kube_apiserver_audit ####
[WARN] 1.2.1 (level 1) Ensure that the --anonymous-auth argument is set to false (Manual) [current: false]
[WARN] 1.2.2 (level 1) Ensure that the --basic-auth-file argument is not set (Automated) [current: is set]
[PASS] 1.2.3 (level 1) Ensure that the --token-auth-file parameter is not set (Automated)
[PASS] 1.2.4 (level 1) Ensure that the --kubelet-https argument is set to true (Automated)
[PASS] 1.2.5 (level 1) Ensure that the --kubelet-client-certificate and --kubelet-client-key arguments are set as appropriate (Automated)
[PASS] 1.2.5 (level 1) Ensure that the --kubelet-client-certificate and --kubelet-client-key arguments are set as appropriate (Automated)
[WARN] 1.2.6 (level 1) Ensure that the --kubelet-certificate-authority argument is set as appropriate (Automated) [current: not exist]
[PASS] 1.2.7 (level 1) Ensure that the --authorization-mode argument is not set to AlwaysAllow (Automated)
[PASS] 1.2.8 (level 1) Ensure that the --authorization-mode argument includes Node (Automated)
[PASS] 1.2.9 (level 1) Ensure that the --authorization-mode argument includes RBAC (Automated)
[WARN] 1.2.10 (level 1) Ensure that the admission control plugin EventRateLimit is set (Manual) [current: not set]
[PASS] 1.2.11 (level 1) Ensure that the admission control plugin AlwaysAdmit is not set (Automated)
[WARN] 1.2.12 (level 1) Ensure that the admission control plugin AlwaysPullImages is set (Manual) [current: not set]
[IGNO] 1.2.13 (level 1) Ensure that the admission control plugin SecurityContextDeny is set if PodSecurityPolicy is not used (Manual)
[WARN] 1.2.14 (level 1) Ensure that the admission control plugin ServiceAccount is set (Automated) [current: not set]
[WARN] 1.2.15 (level 1) Ensure that the admission control plugin NamespaceLifecycle is set (Automated) [current: not set]
[WARN] 1.2.16 (level 1) Ensure that the admission control plugin PodSecurityPolicy is set (Automated) [current: not set]
[WARN] 1.2.17 (level 1) Ensure that the admission control plugin NodeRestriction is set (Automated) [current: not set]
[WARN] 1.2.18 (level 1) Ensure that the --insecure-bind-address argument is not set (Automated) [current: is set]
[WARN] 1.2.19 (level 1) Ensure that the --insecure-port argument is set to 0 (Automated) [current: not set]
[PASS] 1.2.20 (level 1) Ensure that the --secure-port argument is not set to 0 (Automated)
[WARN] 1.2.21 (level 1) Ensure that the --profiling argument is set to false (Automated) [current: not set]
[WARN] 1.2.22 (level 1) Ensure that the --audit-log-path argument is set (Automated) [current: not set]
[WARN] 1.2.23 (level 1) Ensure that the --audit-log-maxage argument is set to 30 or as appropriate (Automated) [current: not set]
[WARN] 1.2.24 (level 1) Ensure that the --audit-log-maxbackup argument is set to 10 or as appropriate (Automated) [current: not set]
[WARN] 1.2.25 (level 1) Ensure that the --audit-log-maxsize argument is set to 100 or as appropriate (Automated) [current: not set]
[WARN] 1.2.26 (level 1) Ensure that the --request-timeout argument is set as appropriate (Automated) [current: not set]
[WARN] 1.2.27 (level 1) Ensure that the --service-account-lookup argument is set to true (Automated) [current: not set]
[PASS] 1.2.28 (level 1) Ensure that the --service-account-key-file argument is set as appropriate (Automated)
[PASS] 1.2.29 (level 1) Ensure that the --etcd-certfile and --etcd-keyfile arguments are set as appropriate (Automated)
[PASS] 1.2.29 (level 1) Ensure that the --etcd-certfile and --etcd-keyfile arguments are set as appropriate (Automated)
[PASS] 1.2.30 (level 1) Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate (Automated)
[PASS] 1.2.30 (level 1) Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate (Automated)
[PASS] 1.2.31 (level 1) Ensure that the --client-ca-file argument is set as appropriate (Automated)
[PASS] 1.2.32 (level 1) Ensure that the --etcd-cafile argument is set as appropriate (Automated)
[WARN] 1.2.33 (level 1) Ensure that the --encryption-provider-config argument is set as appropriate (Manual [current: not set]
[IGNO] 1.2.34 (level 1) Ensure that encryption providers are appropriately configured (Manual)
[PASS] 1.2.35 (level 1) Ensure that the API Server only makes use of Strong Cryptographic Ciphers (Manual)
#### kube_controller_manager_audit ####
[WARN] 1.3.1 (level 1) Ensure that the --terminated-pod-gc-threshold argument is set as appropriate (Manual [current: not set]
[WARN] 1.3.2 (level 1) Ensure that the --profiling argument is set to false (Automated) [current: not set]
[WARN] 1.3.3 (level 1) Ensure that the --use-service-account-credentials argument is set to true (Automated) [current: not set]
[PASS] 1.3.4 (level 1) Ensure that the --service-account-private-key-file argument is set as appropriate (Automated)
[PASS] 1.3.5 (level 1) Ensure that the --root-ca-file argument is set as appropriate (Automated)
[WARN] 1.3.6 (level 1) Ensure that the RotateKubeletServerCertificate argument is set to true (Automated) [current: feature gates not set]
[PASS] 1.3.7 (level 1) Ensure that the --bind-address argument is set to 127.0.0.1 (Automated)
#### kube_scheduler_audit ####
[WARN] 1.4.1 (level 1) Ensure that the --profiling argument is set to false (Automated) [current: not set]
[PASS] 1.4.2 (level 1) Ensure that the --bind-address argument is set to 127.0.0.1 (Automated)
#### node_configuration_file_permission_audit ####
[PASS] 4.1.1 (level 1) Ensure that the kubelet service file permissions are set to 644 or more restrictive (Automated)
[PASS] 4.1.2 (level 1) Ensure that the kubelet service file ownership is set to root:root (Automated)
[PASS] 4.1.3 (level 1) If proxy kubeconfig file exists ensure permissions are set to 644 or more restrictive (Manual)
[PASS] 4.1.4 (level 1) If proxy kubeconfig file exists ensure ownership is set to root:root (Manual)
[PASS] 4.1.5 (level 1) Ensure that the --kubeconfig kubelet.conf file permissions are set to 644 or more restrictive (Automated)
[PASS] 4.1.6 (level 1) Ensure that the --kubeconfig kubelet.conf file ownership is set to root:root (Manual)
[PASS] 4.1.7 (level 1) Ensure that the certificate authorities file permissions are set to 644 or more restrictive (Manual)
[PASS] 4.1.8 (level 1) Ensure that the client certificate authorities file ownership is set to root:root (Manual)
[PASS] 4.1.9 (level 1) Ensure that the kubelet --config configuration file has permissions set to 644 or more restrictive (Automated)
[PASS] 4.1.10 (level 1) Ensure that the kubelet --config configuration file ownership is set to root:root (Automated)
#### kubelet_audit  ####
[WARN] 4.2.1 (level 1) Ensure that the --anonymous-auth argument is set to false (Automated) [current: not set]
[PASS] 4.2.2 (level 1) Ensure that the --authorization-mode argument is not set to AlwaysAllow (Automated)
[WARN] 4.2.3 (level 1) Ensure that the --client-ca-file argument is set as appropriate (Automated) [current: not exist]
[WARN] 4.2.4 (level 1) Verify that the --read-only-port argument is set to 0 (Manual) [current: not set]
[PASS] 4.2.5 (level 1) Ensure that the --streaming-connection-idle-timeout argument is not set to 0 (Manual)
[WARN] 4.2.6 (level 1) Ensure that the --protect-kernel-defaults argument is set to true (Automated) [current: not set]
[WARN] 4.2.7 (level 1) Ensure that the --make-iptables-util-chains argument is set to true (Automated) [current: not set]
[WARN] 4.2.8 (level 1) Ensure that the --hostname-override argument is not set (Manual) [current: is set]
[WARN] 4.2.9 (level 2) Ensure that the --event-qps argument is set to 0 or a level which ensures appropriate event capture (Manual) [current: not set]
[WARN] 4.2.10 (level 1) Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate (Manual) [current: not exist]
[WARN] 4.2.10 (level 1) Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate (Manual) [current: not exist]
[PASS] 4.2.11 (level 1) Ensure that the --rotate-certificates argument is not set to false (Manual)
[WARN] 4.2.13 (level 1) Ensure that the Kubelet only makes use of Strong Cryptographic Ciphers (Manual) [current: not set]
#### etcd_audit ####
[PASS] 2.1 (level 1) Ensure that the --cert-file and --key-file arguments are set as appropriate (Automated)
[PASS] 2.1 (level 1) Ensure that the --cert-file and --key-file arguments are set as appropriate (Automated)
[PASS] 2.2 (level 1) Ensure that the --client-cert-auth argument is set to true (Automated)
[PASS] 2.3 (level 1) Ensure that the --auto-tls argument is not set to true (Automated)
[PASS] 2.4 (level 1) Ensure that the --peer-cert-file and --peer-key-file arguments are set as appropriate (Automated)
[PASS] 2.4 (level 1) Ensure that the --peer-cert-file and --peer-key-file arguments are set as appropriate (Automated)
[PASS] 2.5 (level 1) Ensure that the --peer-client-cert-auth argument is set to true (Automated)
[PASS] 2.6 (level 1) Ensure that the --peer-auto-tls argument is not set to true (Automated)
[IGNO] 2.7 (level 2) Ensure that a unique Certificate Authority is used for etcd (Manual)
```

*notice:* bash version need `4.2.0` or higher


