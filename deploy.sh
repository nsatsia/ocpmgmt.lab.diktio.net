SLEEP=3
cd ztp/gitops-install
helm install -f ../../values.yaml gitops-install .
echo -n "Waiting for OpenShift GitOps to install"
while ! `oc get crds| egrep argo -q`; do
sleep $SLEEP
echo -n "."
done
echo
cd ../gitops-config/
helm install -f ../../values.yaml gitops-config . 
cd ../..
echo "Deploy kick-started!"
