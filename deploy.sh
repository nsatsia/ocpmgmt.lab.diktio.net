cd ztp/gitops-install
helm install -f ../../values.yaml gitops-install .
echo -n "Waiting for OpenShift GitOps to commence installation."
while ! `oc get crds| egrep argo -q`; do
sleep 3
echo -n "."
done
echo
echo -n "Waiting 60 seconds for all CRDs to apply."
for i in {1..60}; do
  echo -n "."
  sleep 1
done
echo
cd ../gitops-config/
helm install -f ../../values.yaml gitops-config . 
cd ../..
echo "Deploy kick-started!"
