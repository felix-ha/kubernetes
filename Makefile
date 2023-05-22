.PHONY: start_minikube
start_minikube:
	minikube start
	minikube addons enable registry
	kubectl get service --namespace kube-system

.PHONY: stop_minikube
stop_minikube:
	minikube stop
	minikube delete

.PHONY: docker_registry_portforward
docker_registry_portforward: ## https://minikube.sigs.k8s.io/docs/handbook/registry/#docker-on-windows
	kubectl port-forward --namespace kube-system service/registry 5001:80

.PHONY: docker_registry_redirection
docker_registry_redirection:
	docker run --rm -it --network=host alpine ash -c "apk add socat && socat TCP-LISTEN:5001,reuseaddr,fork TCP:host.docker.internal:5001"

.PHONY: apply_pod
apply_pod:
	kubectl apply -f k8s/flask-webserver/pod.yaml

.PHONY: apply_deployment
apply_deployment:
	kubectl apply -f k8s/flask-webserver/deployment.yaml --record

.PHONY: run_tunnel
run_tunnel:
	minikube tunnel

.PHONY: apply_deployment_exposed_example
apply_deployment_exposed_example: ##https://minikube.sigs.k8s.io/docs/handbook/accessing/
	kubectl create deployment hello-minikube2 --image=kicbase/echo-server:1.0
	kubectl expose deployment hello-minikube2 --type=LoadBalancer --port=8080
	kubectl get svc
	curl http://127.0.0.1:8080

.PHONY: apply_deployment_exposed_flask
apply_deployment_exposed_flask: 
	kubectl apply -f k8s/flask-webserver/deployment.yaml
	minikube service flask-service
	kubectl get svc
	curl http://127.0.0.1:8081
