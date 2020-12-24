FROM 42crunch/apifirewall:latest
COPY ./cert/*.pem /opt/guardian/conf/ssl/
COPY ./cert/*.key /opt/guardian/conf/ssl/
ENV PROTECTION_TOKEN=e2dcca73-e1f6-4724-8a4f-c199ce21f0ea
ENV SERVER_NAME=localhost
ENV LISTEN_PORT=443
#ENV TARGET_URL=https://lbspring.42crunch-ns.207.244.225.188.xip.io/42crunch-auth0
ENV TARGET_URL=http://localhost:8080/42crunch-auth0
#ENV LISTEN_NO_TLS=1
ENV LISTEN_SSL_CERT=fullchain-cert-with-ca.pem
ENV LISTEN_SSL_KEY=localhost.key
ENV GUARDIAN_INSTANCE_NAME=springboot-sample
ENV LOG_LEVEL=debug
ENV ERROR_LOG_LEVEL=debug

#e2dcca73-e1f6-4724-8a4f-c199ce21f0ea

#docker build -t edgars/apifirewall .
#docker run -p 8443:443 edgars/apifirewall