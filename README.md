# [TailScale](https://tailscale.com)  sidecar POC

### Setup using [kind](https://kind.sigs.k8s.io) because its so easy:
  1) Install [TailScale](https://tailscale.com)
  2) Create the cluster with `kind create cluster`
  3) Install [sealed-secrets/kubeseal](https://github.com/bitnami-labs/sealed-secrets) on the cluster with `kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.15.0/controller.yaml`
  4) Get a reusable token from your [Tailscale Admin Console](https://login.tailscale.com/admin/authkeys) and save it to tailscalekey.unsealed (needs to be that name for the deployment)
  5) Create a sealed secret called `tailscalekey` with `kubectl apply -f  <(kubectl create secret generic tailscalekey --dry-run=client --from-file=tailscalekey.unsealed -o yaml | kubeseal -o yaml)` 
  6) Deploy! `kubectl apply -f deployments/tailscale-deployment.yaml`
     
 `What you should have at this point is a deployment with one pod having 2 containers, one being the hashicorp/http-echo container set to respond on port 5678`

  7) Go back to your [Tailscale Admin Console machines list](https://login.tailscale.com/admin/machines) and find the new machine that the tailscale container registered using your key from the sealed secret.
  8) `curl http://👆<IP>:5678`

# If you see "Tailscale FTW!" then you win

Dockerfile and entrypoint script for the tailscale image are included for anyone to modify.

