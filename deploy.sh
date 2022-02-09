docker build 
-t viideguzman/multi-client:latest 
-t viideguzman/multi-client:$GIT_SHA
-f ./client/Dockerfile ./client
docker build 
-t viideguzman/multi-server:latest 
-t viideguzman/multi-server:$GIT_SHA
-f ./server/Dockerfile ./server
docker build 
-t viideguzman/multi-worker:latest  
-t viideguzman/multi-worker:$GIT_SHA 
-f ./worker/Dockerfile ./worker

docker push viideguzman/multi-client:latest 
docker push viideguzman/multi-server:latest 
docker push viideguzman/multi-worker:latest 
docker push viideguzman/multi-client:$GIT_SHA 
docker push viideguzman/multi-server:$GIT_SHA 
docker push viideguzman/multi-worker:$GIT_SHA 

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=viideguzman/multi-server:$GIT_SHA 
kubectl set image deployments/client-deployment client=viideguzman/multi-client:$GIT_SHA 
kubectl set image deployments/worker-deployment worker=viideguzman/multi-worker:$GIT_SHA 