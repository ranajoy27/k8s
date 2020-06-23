docker build -t ranajoy27/multi-client:$SHA -t ranajoy27/multi-client:latest -f ./client/Dockerfile ./client
docker build -t ranajoy27/multi-server:$SHA -t ranajoy27/multi-server:latest -f ./server/Dockerfile ./server
docker build -t ranajoy27/multi-worker:$SHA -t ranajoy27/multi-worker:latest -f ./worker/Dockerfile ./worker
docker push ranajoy27/multi-client:latest
docker push ranajoy27/multi-server:latest
docker push ranajoy27/multi-worker:latest
docker push ranajoy27/multi-client:$sha
docker push ranajoy27/multi-server:$sha
docker push ranajoy27/multi-worker:$sha
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ranajoy27/multi-server:$SHA
kubectl set image deployments/client-deployment client=ranajoy27/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ranajoy27/multi-worker:$SHA