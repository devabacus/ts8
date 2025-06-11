

SERVICE_SECRET
REGISTRY_USER = dbe81550-wise-chickadee
REGISTRY_PASSWORD
REDIS_PASSWORD
KUBE_CONFIG
DB_PASSWORD
REGISTRY_EMAIL

# serverpod
docker compose up -d
serverpod create-migration --experimental-features=all
serverpod generate --experimental-features=all
dart bin/main.dart --apply-migrations

docker compose down -v

#kubernaties
1. Установить дополнение cert-manager
# Секрет для Docker Registry
kubectl apply -f k8s_1/

kubectl create secret docker-registry timeweb-registry-secret --docker-server=dbe81550-wise-chickadee.registry.twcstorage.ru --docker-username=ВАШ_ПОЛЬЗОВАТЕЛЬ --docker-password=ВАШ_ПАРОЛЬ --docker-email=frolprank@gmail.com
kubectl create secret generic serverpod-secrets-ts8 --from-literal=database-password='пароль' --from-literal=redis-password='пароль' --from-literal=service-secret='пароль'


kubectl apply -f k8s/

[Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes('пароль'))

# Проверим поды
kubectl get pods
kubectl get pods -w

# Проверим сервисы
kubectl get svc
kubectl get svc ts8-server-service -o yaml 

# логи приложения
kubectl logs -f -l app=ts8-server

#kubectl logs serverpod-migration-job-ts3-6llg9

# Тестируем endpoint для получения списка TestData
Invoke-WebRequest -Uri "https://api5.my-points.ru/" -Method POST -ContentType "application/json" -Body '{"endpoint":"testData","method":"listTestDatas","params":{}}'

# Проверка доступности напрямую
Invoke-WebRequest -Uri "https://api5.my-points.ru/" -Method GET

# Проверим детали Ingress:
bashkubectl describe ingress sync2-server-ingress

docker login dbe81550-wise-chickadee.registry.twcstorage.ru
docker build -t dbe81550-wise-chickadee.registry.twcstorage.ru/ts8-server:latest -f Dockerfile.prod .
docker push dbe81550-wise-chickadee.registry.twcstorage.ru/ts8-server:latest

kubectl apply -f k8s/

kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/job.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml
kubectl apply -f k8s/secret.yaml


#delete project
kubectl delete -f k8s/

kubectl delete service ts8-server-service
kubectl delete ingress ts8-server-ingress
kubectl delete configmap serverpod-config-ts8
kubectl delete job serverpod-migration-job-ts8
kubectl delete secret serverpod-secrets-ts8
kubectl delete deployment ts8-server-deployment

#restart deployment
kubectl rollout restart deployment ts8-server-deployment


