#!/bin/bash

#     Purpose:  Install Trivy from Aquasecurity
#        Date:  2024-07-23
#      Status:  WIP | Still trying to figure this out
# Assumptions:
#        Todo:
#  References: https://aquasecurity.github.io/trivy-operator/v0.22.0/getting-started/installation/helm/
#              https://github.com/aquasecurity/trivy-operator
#              https://aquasecurity.github.io/trivy-operator/latest/getting-started/installation/kubectl/

########################### ###########################
mkdir ~/eksa/$CLUSTER_NAME/latest/trivy; cd $_
#git clone --depth 1 --branch v0.22.0 https://github.com/aquasecurity/trivy-operator.git
#cd trivy-operator

helm repo add aqua https://aquasecurity.github.io/helm-charts/
helm repo update

   helm install trivy-operator aqua/trivy-operator \
     --namespace trivy-system \
     --create-namespace \
     --version 0.24.0

#Inspect created VulnerabilityReports by:
    kubectl get vulnerabilityreports --all-namespaces -o wide

#Inspect created ConfigAuditReports by:
    kubectl get configauditreports --all-namespaces -o wide

#Inspect the work log of trivy-operator by:
    kubectl logs -n trivy-system deployment/trivy-operator

kubectl config set-context --current --namespace=trivy-system
kubectl get all 


helm list -n trivy-system

kubectl config set-context --current --namespace=default

exit 0

helm install trivy-operator aqua/trivy-operator \
  --namespace trivy-system \
  --create-namespace \
  --version 0.21.4




helm repo add aquasecurity https://aquasecurity.github.io/helm-charts/
helm repo update
helm search repo trivy
helm install my-trivy aquasecurity/trivy
helm install my-release .

cd -
kubectl config set-context --current --namespace=default
exit 0

helm uninstall trivy-operator -n trivy-system
kubectl delete ns trivy-system
