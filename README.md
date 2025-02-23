# web_server_redis

#### Project requirements

- minikube
- - Ingress extension ( if cluster will not re reinstalled using create.sh script )
- helm tool

### Installation

```shell
git clone https://github.com/StasMiasnikov/web_server_redis.git
```

```shell
cd web_server_redis/src
```

#### Run orchestrator script (This command will delete existing minikube cluster before installing)

```shell
chmod +x create.sh
```

```shell
./create.sh
```

Script will do following:

- Create minikube cluster with needed addon for ingress
- Will build all needed images
- Will load the images to local minikube cluster
- Deploy the content using helm chart
- Script will finish with local IP address and example command to execute request :

```shell
To test the deployment run =>
wget -O - --no-check-certificate  https://IP/api/v1/music-albums?key=25
Run some load =>
watch -n 0.1 wget -O - --no-check-certificate  https://IP/api/v1/music-albums?key=100
```
