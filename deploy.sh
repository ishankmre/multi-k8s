docker build -t ishank62/multi-client:latest -t ishank62/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ishank62/multi-server:latest -t ishank62/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ishank62/multi-worker:latest -t ishank62/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ishank62/multi-client:latest
docker push ishank62/multi-server:latest
docker push ishank62/multi-worker:latest

docker push ishank62/multi-client:$SHA
docker push ishank62/multi-server:$SHA
docker push ishank62/multi-worker:$SHA

kubect apply -f k8s
kubectl set image deployments/client-deployment client=ishank62/multi-client:$SHA
kubectl set image deployments/server-deployment server=ishank62/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ishank62/multi-worker:$SHA