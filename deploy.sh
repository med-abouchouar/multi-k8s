docker build -t abouchouar/multi-client:$SHA -f ./client/Dockerfile ./client
docker built -t abouchouar/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t abouchouar/multi-server:$SHA -f ./server/Dockerfile ./server


# -t abouchouar/multi-client:latest 
# -t abouchouar/multi-server:latest 
# -t abouchouar/multi-worker:latest 

# docker push abouchouar/multi-client:latest 
# docker push abouchouar/multi-server:latest
# docker push abouchouar/multi-worker:latest

docker push abouchouar/multi-worker:$SHA
docker push abouchouar/multi-client:$SHA 
docker push abouchouar/multi-server:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=abouchouar/multi-server:$SHA
kubectl set image deployments/client-deployment client=abouchouar/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker