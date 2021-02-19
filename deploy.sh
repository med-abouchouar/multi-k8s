docker build -t abouchouar/multi-client:latest -t abouchouar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t abouchouar/multi-server:latest -t abouchouar/multi-server:$SHA -f ./server/Dockerfile ./server
docker built -t abouchouar/multi-worker:latest -t abouchouar/multi-worker:$SHA -f ./worker/Dockerfile ./worker

#docker push abouchouar/multi-client:latest 
#docker push abouchouar/multi-server:latest
#docker push abouchouar/multi-worker:latest
 
docker push abouchouar/multi-client:$SHA 
docker push abouchouar/multi-server:$SHA
docker push abouchouar/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=abouchouar/multi-server:$SHA
kubectl set image deployments/client-deployment client=abouchouar/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=abouchouar/multi-worker:$SHA