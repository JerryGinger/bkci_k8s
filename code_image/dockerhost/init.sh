  
#!/bin/bash

mkdir -p /data/devops
cd /data/devops

echo "start to download the docker_init.sh..." > logs/docker.log
#sleep 1000

curl -k -s -H "X-DEVOPS-BUILD-TYPE: DOCKER" -H "X-DEVOPS-PROJECT-ID: ${devops_project_id}" -H "X-DEVOPS-AGENT-ID: ${devops_agent_id}" -H "X-DEVOPS-AGENT-SECRET-KEY: ${devops_agent_secret_key}" -o  docker_init.sh "${devops_gateway}/ms/dispatch/api/build/scripts?scriptName=docker_init.sh"
echo "download docker_init.sh success, start it..." >> logs/docker.log
#cp -r /data/bkdevops/apps/jdk/1.8.0_161_landun/jre /usr/local/jre
#export PATH="/usr/local/jre/bin:${PATH}"
cat docker_init.sh >> logs/docker.log

ln -s /data/devops/apps/jdk /usr/local/jre #记得在宿主机上挂载/data/docker/bkci/public/ci/docker/apps/jdk
sh docker_init.sh $@