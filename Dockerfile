FROM 42crunch/apifirewall:latest
COPY ./cert/*.pem /opt/guardian/conf/ssl/
COPY ./cert/*.key /opt/guardian/conf/ssl/
ENV PROTECTION_TOKEN=384f00d7-f547-42cb-8871-3630a843b13f
ENV SERVER_NAME=localhost
ENV LISTEN_PORT=443
ENV TARGET_URL=https://lbspring.42crunch-ns.207.244.225.188.xip.io/42crunch-auth0
#ENV LISTEN_NO_TLS=1
ENV LISTEN_SSL_CERT=fullchain-cert-with-ca.pem
ENV LISTEN_SSL_KEY=localhost.key
ENV GUARDIAN_INSTANCE_NAME=springboot-sample
ENV LOG_LEVEL=debug
ENV ERROR_LOG_LEVEL=debug