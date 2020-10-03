



`kubectl get pod test-5f6778868d-jlbd2 -o jsonpath="{.spec.tolerations[?(@.key=='node.kubernetes.io/unreachable')]}" | jq .
kubectl get pods -o jsonpath="{.items[0].metadata.name}"`