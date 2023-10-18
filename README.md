Imaportant Links

https://collabnix.github.io/kubetools/#cluster-management


# force delete kubernates

kubectl patch crd/applications.argoproj.io --type json --patch='[ { "op": "remove", "path": "/metadata/finalizers" } ]'
