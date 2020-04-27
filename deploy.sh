docker build -t dezarr/multi-client:latest -t dezarr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dezarr/multi-server:latest -t dezarr/multi-server:$SHA -f ./server/Dockerfile ./server
dooker build -t dezarr/multi-worker:latest -t dezarr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dezarr/multi-client:latest
docker push dezarr/multi-server:latest
docker push dezarr/multi-worker:latest

docker push dezarr/multi-client:$SHA
docker push dezarr/multi-server:$SHA
docker push dezarr/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dezarr/multi-server:$SHA
kubectl set image deployments/client-deployment client=dezarr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dezarr/multi-worker:$SHA