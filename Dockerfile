FROM gitlab/gitlab-runner

ENV CI_SERVER_URL=
ENV CI_RUNNER_TOKEN=
ENV RUNNER_NAME=
ENV HOME=/home/gr


RUN usermod -g 0 gitlab-runner &&\
    mkdir /home/gr &&\
    usermod -d /home/gr gitlab-runner &&\
    touch /home/gr/config.toml &&\
    chmod -R g+rwX /home/gr/ &&\
    chown -R gitlab-runner /home/gr 

RUN chmod g+w /etc/passwd


ADD entrypoint.sh /home/gr/entrypoint.sh
RUN chmod +x /home/gr/entrypoint.sh

USER 9999

ENTRYPOINT ["/home/gr/entrypoint.sh"]
CMD ["/usr/bin/gitlab-runner"]

