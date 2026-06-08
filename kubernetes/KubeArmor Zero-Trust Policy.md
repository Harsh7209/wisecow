## KubeArmor Zero-Trust Policy

A KubeArmor policy was applied to the Wisecow workload to enforce a zero-trust security model. The policy blocks execution of shell binaries such as `/usr/bin/bash` and restricts access to sensitive files.

To validate the policy, an attempt was made to execute a shell inside a running Wisecow pod using:

`kubectl exec -it <pod-name> -n wisecow -- bash`

KubeArmor intercepted the request and blocked execution of `/usr/bin/bash`. The command failed with `permission denied`, and KubeArmor generated a runtime security event showing `Action: Block` and `Result: Permission denied`.

The attached screenshot folder in the root directory demonstrates successful policy enforcement and runtime visibility.
