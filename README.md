# Imaportant Links

https://collabnix.github.io/kubetools/#cluster-management


##### force delete kubernates

kubectl patch crd/applications.argoproj.io --type json --patch='[ { "op": "remove", "path": "/metadata/finalizers" } ]'

kubectl patch ing commpayout -p '{"metadata":{"finalizers":null}}' -n cpapi-demo

kubectl patch pvc {PVC_NAME} -p '{"metadata":{"finalizers":null}}'
