#!/bin/bash

#     Purpose: Enable Kubevirt
#        Date: 2024-07-05
#      Status: Absolutely a Work in Progress | I anticipate adding more content
# Assumptions:
#        Todo:
#  References:
#       Notes: 


kubectl get events -A --sort-by=.lastTimestamp

install_kubervirt() {
# Create vms namespace for future use
kubectl create namespace vms

# Retrive the current RELEASE version
export KUBEVIRT_RELEASE=$(curl -s https://storage.googleapis.com/kubevirt-prow/release/kubevirt/kubevirt/stable.txt)

# Deploy the KubeVirt operator
kubectl apply -f https://github.com/kubevirt/kubevirt/releases/download/${KUBEVIRT_RELEASE}/kubevirt-operator.yaml

# Create the KubeVirt CR (instance deployment request) which triggers the actual installation
kubectl apply -f https://github.com/kubevirt/kubevirt/releases/download/${KUBEVIRT_RELEASE}/kubevirt-cr.yaml

# wait until all KubeVirt components are up
kubectl -n kubevirt wait kubevirt/kubevirt --for condition=Available

kubectl get kubevirt.kubevirt.io/kubevirt --namespace kubevirt --output=jsonpath="{.status.phase}"
while sleep 2; do echo; ( kubectl get all -n kubevirt  | grep Deploying; ) || break; done
}

install_virtctl() {
VERSION=$(kubectl get kubevirt.kubevirt.io/kubevirt -n kubevirt -o=jsonpath="{.status.observedKubeVirtVersion}")
ARCH=$(uname -s | tr A-Z a-z)-$(uname -m | sed 's/x86_64/amd64/') || windows-amd64.exe
echo ${ARCH}
curl -L -o virtctl https://github.com/kubevirt/kubevirt/releases/download/${VERSION}/virtctl-${VERSION}-${ARCH}
sudo install -m 0755 virtctl /usr/local/bin
virtctl version
}

install_cdi() {
export TAG=$(curl -s -w %{redirect_url} https://github.com/kubevirt/containerized-data-importer/releases/latest)
export VERSION=$(echo ${TAG##*/})
kubectl apply -f https://github.com/kubevirt/containerized-data-importer/releases/download/$VERSION/cdi-operator.yaml
kubectl apply -f https://github.com/kubevirt/containerized-data-importer/releases/download/$VERSION/cdi-cr.yaml
}

exit 0
