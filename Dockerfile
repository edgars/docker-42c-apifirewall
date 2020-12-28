FROM 42crunch/apifirewall:latest
COPY ./cert-2/myapis.docker.local/*.pem /opt/guardian/conf/ssl/
COPY ./cert-2/myapis.docker.local/*.key /opt/guardian/conf/ssl/

#e2dcca73-e1f6-4724-8a4f-c199ce21f0ea

#docker build -t edgars/apifirewall .
#docker run -p 8443:443 edgars/apifirewall



