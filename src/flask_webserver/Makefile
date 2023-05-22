.PHONY: webagend
webagend: 
	python -m flask run --host=0.0.0.0 --port=5000 

.PHONY: docker_build
docker_build:
	docker build --tag flask-webserver .
	docker tag flask-webserver:latest flask-webserver:v0.0.1

.PHONY: docker_run
docker_run:
	docker run --publish 5000:5000 flask-webserver:v0.0.1

.PHONY: docker_build_minikube_registry
docker_build_minikube_registry:
	docker build --tag flask-webserver .
	docker tag flask-webserver:latest localhost:5001/flask-webserver:v0.0.1
	docker push localhost:5001/flask-webserver:v0.0.1
	curl http://localhost:5001/v2/_catalog
	curl http://127.0.0.1:5001/v2/flask-webserver/tags/list
	
.PHONY: curl_get
curl_get:
	curl -i http://127.0.0.1:5001
