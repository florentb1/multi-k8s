docker build -t florentb1/multi-client:latest -t florentb1/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t florentb1/multi-server:latest -t florentb1/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t florentb1/multi-worker:latest -t florentb1/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push florentb1/multi-client:latest
docker push florentb1/multi-server:latest
docker push florentb1/multi-worker:latest

docker push florentb1/multi-client:latest:$SHA
docker push florentb1/multi-server:latest:$SHA
docker push florentb1/multi-worker:latest:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=florentb1/multi-server:$SHA
kubectl set image deployments/client-deployment client=florentb1/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=florentb1/multi-worker:$SHA