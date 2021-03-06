#!/bin/bash

declare -A cis_items

cis_items=(
    [1.1.1]="(level 1) Ensure that the API server pod specification file permissions are set to 644 or more restrictive"
    [1.1.2]="(level 1) Ensure that the API server pod specification file ownership is set to root:root"
    [1.1.3]="(level 1) Ensure that the controller manager pod specification file permissions are set to 644 or more restrictive"
    [1.1.4]="(level 1) Ensure that the controller manager pod specification file ownership is set to root:root"
    [1.1.5]="(level 1) Ensure that the scheduler pod specification file permissions are set to 644 or more restrictive"
    [1.1.6]="(level 1) Ensure that the scheduler pod specification file ownership is set to root:root"
    [1.1.7]="(level 1) Ensure that the etcd pod specification file permissions are set to 644 or more restrictive"
    [1.1.8]="(level 1) Ensure that the etcd pod specification file ownership is set to root:root"
    [1.1.9]="(level 1) Ensure that the Container Network Interface file permissions are set to 644 or more restrictive"
    [1.1.10]="(level 1) Ensure that the Container Network Interface file ownership is set to root:root"
    [1.1.11]="(level 1) Ensure that the etcd data directory permissions are set to 700 or more restrictive"
    [1.1.12]="(level 1) Ensure that the etcd data directory ownership is set to etcd:etcd"
    [1.1.13]="(level 1) Ensure that the admin.conf file permissions are set to 644 or more restrictive "
    [1.1.14]="(level 1) Ensure that the admin.conf file ownership is set to root:root "
    [1.1.15]="(level 1) Ensure that the scheduler.conf file permissions are set to 644 or more restrictive"
    [1.1.16]="(level 1) Ensure that the scheduler.conf file ownership is set to root:root"
    [1.1.17]="(level 1) Ensure that the controller-manager.conf file permissions are set to 644 or more restrictive"
    [1.1.18]="(level 1) Ensure that the controller-manager.conf file ownership is set to root:root"
    [1.1.19]="(level 1) Ensure that the Kubernetes PKI directory and file ownership is set to root:root"
    [1.1.20]="(level 1) Ensure that the Kubernetes PKI certificate file permissions are set to 644 or more restrictive"
    [1.1.21]="(level 1) Ensure that the Kubernetes PKI key file permissions are set to 600"
    [1.2.1]="(level 1) Ensure that the --anonymous-auth argument is set to false (Manual) "
    [1.2.2]="(level 1) Ensure that the --basic-auth-file argument is not set (Automated)"
    [1.2.3]="(level 1) Ensure that the --token-auth-file parameter is not set (Automated)"
    [1.2.4]="(level 1) Ensure that the --kubelet-https argument is set to true (Automated)"
    [1.2.5]="(level 1) Ensure that the --kubelet-client-certificate and --kubelet-client-key arguments are set as appropriate (Automated) "
    [1.2.6]="(level 1) Ensure that the --kubelet-certificate-authority argument is set as appropriate (Automated) "
    [1.2.7]="(level 1) Ensure that the --authorization-mode argument is not set to AlwaysAllow (Automated)"
    [1.2.8]="(level 1) Ensure that the --authorization-mode argument includes Node (Automated)"
    [1.2.9]="(level 1) Ensure that the --authorization-mode argument includes RBAC (Automated)"
    [1.2.10]="(level 1) Ensure that the admission control plugin EventRateLimit is set (Manual) "
    [1.2.11]="(level 1) Ensure that the admission control plugin AlwaysAdmit is not set (Automated)"
    [1.2.12]="(level 1) Ensure that the admission control plugin AlwaysPullImages is set (Manual)"
    [1.2.13]="(level 1) Ensure that the admission control plugin SecurityContextDeny is set if PodSecurityPolicy is not used (Manual)"
    [1.2.14]="(level 1) Ensure that the admission control plugin ServiceAccount is set (Automated)"
    [1.2.15]="(level 1) Ensure that the admission control plugin NamespaceLifecycle is set (Automated)"
    [1.2.16]="(level 1) Ensure that the admission control plugin PodSecurityPolicy is set (Automated)"
    [1.2.17]="(level 1) Ensure that the admission control plugin NodeRestriction is set (Automated) "
    [1.2.18]="(level 1) Ensure that the --insecure-bind-address argument is not set (Automated)"
    [1.2.19]="(level 1) Ensure that the --insecure-port argument is set to 0 (Automated)"
    [1.2.20]="(level 1) Ensure that the --secure-port argument is not set to 0 (Automated)"
    [1.2.21]="(level 1) Ensure that the --profiling argument is set to false (Automated)"
    [1.2.22]="(level 1) Ensure that the --audit-log-path argument is set (Automated)"
    [1.2.23]="(level 1) Ensure that the --audit-log-maxage argument is set to 30 or as appropriate (Automated)"
    [1.2.24]="(level 1) Ensure that the --audit-log-maxbackup argument is set to 10 or as appropriate (Automated)"
    [1.2.25]="(level 1) Ensure that the --audit-log-maxsize argument is set to 100 or as appropriate (Automated)"
    [1.2.26]="(level 1) Ensure that the --request-timeout argument is set as appropriate (Automated) "
    [1.2.27]="(level 1) Ensure that the --service-account-lookup argument is set to true (Automated)"
    [1.2.28]="(level 1) Ensure that the --service-account-key-file argument is set as appropriate (Automated)"
    [1.2.29]="(level 1) Ensure that the --etcd-certfile and --etcd-keyfile arguments are set as appropriate (Automated)"
    [1.2.30]="(level 1) Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate (Automated)"
    [1.2.31]="(level 1) Ensure that the --client-ca-file argument is set as appropriate (Automated)"
    [1.2.32]="(level 1) Ensure that the --etcd-cafile argument is set as appropriate (Automated)"
    [1.2.33]="(level 1) Ensure that the --encryption-provider-config argument is set as appropriate (Manual"
    [1.2.34]="(level 1) Ensure that encryption providers are appropriately configured (Manual)"
    [1.2.35]="(level 1) Ensure that the API Server only makes use of Strong Cryptographic Ciphers (Manual)"
    [1.3.1]="(level 1) Ensure that the --terminated-pod-gc-threshold argument is set as appropriate (Manual"
    [1.3.2]="(level 1) Ensure that the --profiling argument is set to false (Automated)"
    [1.3.3]="(level 1) Ensure that the --use-service-account-credentials argument is set to true (Automated)"
    [1.3.4]="(level 1) Ensure that the --service-account-private-key-file argument is set as appropriate (Automated)"
    [1.3.5]="(level 1) Ensure that the --root-ca-file argument is set as appropriate (Automated)"
    [1.3.6]="(level 1) Ensure that the RotateKubeletServerCertificate argument is set to true (Automated)"
    [1.3.7]="(level 1) Ensure that the --bind-address argument is set to 127.0.0.1 (Automated)"
    [1.4.1]="(level 1) Ensure that the --profiling argument is set to false (Automated)"
    [1.4.2]="(level 1) Ensure that the --bind-address argument is set to 127.0.0.1 (Automated)"
    [2.1]="(level 1) Ensure that the --cert-file and --key-file arguments are set as appropriate (Automated)"
    [2.2]="(level 1) Ensure that the --client-cert-auth argument is set to true (Automated)"
    [2.3]="(level 1) Ensure that the --auto-tls argument is not set to true (Automated)"
    [2.4]="(level 1) Ensure that the --peer-cert-file and --peer-key-file arguments are set as appropriate (Automated)"
    [2.5]="(level 1) Ensure that the --peer-client-cert-auth argument is set to true (Automated)"
    [2.6]="(level 1) Ensure that the --peer-auto-tls argument is not set to true (Automated)"
    [2.7]="(level 2) Ensure that a unique Certificate Authority is used for etcd (Manual)"
    [3.1.1]="(level 1) Client certificate authentication should not be used for users (Manual)"
    [3.2.1]="(level 1) Ensure that a minimal audit policy is created (Manual)"
    [3.2.2]="(level 2) Ensure that the audit policy covers key security concerns (Manual)"
    [4.1.1]="(level 1) Ensure that the kubelet service file permissions are set to 644 or more restrictive (Automated)"
    [4.1.2]="(level 1) Ensure that the kubelet service file ownership is set to root:root (Automated)"
    [4.1.3]="(level 1) If proxy kubeconfig file exists ensure permissions are set to 644 or more restrictive (Manual)"
    [4.1.4]="(level 1) If proxy kubeconfig file exists ensure ownership is set to root:root (Manual)"
    [4.1.5]="(level 1) Ensure that the --kubeconfig kubelet.conf file permissions are set to 644 or more restrictive (Automated)"
    [4.1.6]="(level 1) Ensure that the --kubeconfig kubelet.conf file ownership is set to root:root (Manual)"
    [4.1.7]="(level 1) Ensure that the certificate authorities file permissions are set to 644 or more restrictive (Manual) "
    [4.1.8]="(level 1) Ensure that the client certificate authorities file ownership is set to root:root (Manual)"
    [4.1.9]="(level 1) Ensure that the kubelet --config configuration file has permissions set to 644 or more restrictive (Automated)"
    [4.1.10]="(level 1) Ensure that the kubelet --config configuration file ownership is set to root:root (Automated) "
    [4.2.1]="(level 1) Ensure that the --anonymous-auth argument is set to false (Automated)"
    [4.2.2]="(level 1) Ensure that the --authorization-mode argument is not set to AlwaysAllow (Automated)"
    [4.2.3]="(level 1) Ensure that the --client-ca-file argument is set as appropriate (Automated)"
    [4.2.4]="(level 1) Verify that the --read-only-port argument is set to 0 (Manual) "
    [4.2.5]="(level 1) Ensure that the --streaming-connection-idle-timeout argument is not set to 0 (Manual)"
    [4.2.6]="(level 1) Ensure that the --protect-kernel-defaults argument is set to true (Automated)"
    [4.2.7]="(level 1) Ensure that the --make-iptables-util-chains argument is set to true (Automated)"
    [4.2.8]="(level 1) Ensure that the --hostname-override argument is not set (Manual)"
    [4.2.9]="(level 2) Ensure that the --event-qps argument is set to 0 or a level which ensures appropriate event capture (Manual)"
    [4.2.10]="(level 1) Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate (Manual)"
    [4.2.11]="(level 1) Ensure that the --rotate-certificates argument is not set to false (Manual)"
    [4.2.12]="(level 1) Verify that the RotateKubeletServerCertificate argument is set to true"
    [4.2.13]="(level 1) Ensure that the Kubelet only makes use of Strong Cryptographic Ciphers (Manual)"
    [5.1.1]="(level 1) Ensure that the cluster-admin role is only used where required (Manual)"
    [5.1.2]="(level 1) Minimize access to secrets (Manual)"
    [5.1.3]="(level 1) Minimize wildcard use in Roles and ClusterRoles (Manual)"
    [5.1.4]="(level 1) Minimize access to create pods (Manual)"
    [5.1.5]="(level 1) Ensure that default service accounts are not actively used. (Manual)"
    [5.1.6]="(level 1) Ensure that Service Account Tokens are only mounted where necessary (Manual)"
    [5.2.1]="(level 1) Minimize the admission of privileged containers (Manual)"
    [5.2.2]="(level 1) Minimize the admission of containers wishing to share the host process ID namespace (Manual)"
    [5.2.3]="(level 1) Minimize the admission of containers wishing to share the host IPC namespace (Manual)"
    [5.2.4]="(level 1) Minimize the admission of containers wishing to share the host network namespace (Manual)"
    [5.2.5]="(level 1) Minimize the admission of containers with allowPrivilegeEscalation (Manual)"
    [5.2.6]="(level 1) Minimize the admission of root containers (Manual)"
    [5.2.7]="(level 1) Minimize the admission of containers with the NET_RAW capability (Manual)"
    [5.2.8]="(level 1) Minimize the admission of containers with added capabilities (Manual)"
    [5.2.9]="(level 2) Minimize the admission of containers with capabilities assigned (Manual)"
    [5.3.1]="(level 1) Ensure that the CNI in use supports Network Policies (Manual)"
    [5.3.2]="(level 2) Ensure that all Namespaces have Network Policies defined (Manual)"
    [5.4.1]="(level 2) Prefer using secrets as files over secrets as environment variables (Manual)"
    [5.4.2]="(level 2) Consider external secret storage (Manual)"
    [5.5.1]="(level 2) Configure Image Provenance using ImagePolicyWebhook admission controller (Manual)"
    [5.7.1]="(level 1) Create administrative boundaries between resources using namespaces (Manual)"
    [5.7.2]="(level 2) Ensure that the seccomp profile is set to docker/default in your pod definitions (Manual)"
    [5.7.3]="(level 2) Apply Security Context to Your Pods and Containers (Manual)"
    [5.7.4]="(level 2) The default namespace should not be used (Manual)"
)
