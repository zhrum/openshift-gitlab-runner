#!/bin/bash

nb=$(id -u)

cat /etc/passwd | sed -e "s/999/$nb/g" > /tmp/passwd
cat /tmp/passwd > /etc/passwd
rm /tmp/passwd

gitlab-ci-multi-runner register --config /home/gr/config.toml -n \
 -u  "${CI_SERVER_URL}" -r "${CI_RUNNER_TOKEN}" --name "${RUNNER_NAME}" --executor "kubernetes" --kubernetes-namespace "$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace)" 


mkdir -p /home/gr/.gitlab-runner/
cp /home/gr/config.toml  /home/gr/.gitlab-runner/



exec $@ run --user=gitlab-runner --working-directory=/home/gr

