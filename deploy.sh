docker build -t alekseysoroka/multi-client:latest -t alekseysoroka/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alekseysoroka/multi-server:latest -t alekseysoroka/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alekseysoroka/multi-worker:latest -t alekseysoroka/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alekseysoroka/multi-client:latest
docker push alekseysoroka/multi-server:latest
docker push alekseysoroka/multi-worker:latest

docker push alekseysoroka/multi-client:$SHA
docker push alekseysoroka/multi-server:$SHA
docker push alekseysoroka/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alekseysoroka/multi-server:$SHA
kubectl set image deployments/client-deployment client=alekseysoroka/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alekseysoroka/multi-worker:$SHA