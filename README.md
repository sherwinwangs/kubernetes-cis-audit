## Kubernetes cis audit script

This script is written to audit kubernetes security refer to CIS `CIS_Kubernetes_Benchmark_v1.6.0.pdf`

- Usage

  ```bash
  sh main.sh [master|node|etcd|all]
  
  # master used to audit master components
  # node used to audit node components
  # etcd used to audit etcd service
  # all used to audit all componentsa
  ```

  

- Code directory

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

  

*notice:* bash version need `4.2.0` or higher


