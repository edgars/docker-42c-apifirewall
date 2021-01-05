## Introduction

In this demonstration I will show how to protect basic Microsevices using ***Micro-APIFirewall***. In our case, we have a basic **SpringBoot** app that is fully audited, scanned and protected by [42Crunch platform](https://42crunch.com).

  

![Example that we will demonstrante](https://github.com/edgars/docker-42c-apifirewall/raw/main/images/demo.png)

  

# Getting Started

We will use the 42Crunch API Firewall official image hosted at DockerHub, here is the image location: https://hub.docker.com/r/42crunch/apifirewall , please refer to that default image base in order to complete this POC/Demo.

  

# What to Protect ?

  

If you had arrived to that question, you must be able to understand 2 points about API Protection:

  

You will have initially 2 points that will be covered here:

1. Security Auditing (Score)

2. Conformance Scaning (Level)

  

The number one bullet is related to how secure is you API to go live, it means: `How is your protection level on the whole internet?`

  

![enter image description here](https://github.com/edgars/docker-42c-apifirewall/raw/main/images/security_audit.png)

  

The **Audit Score** above is ok in order to be pushed to production. Don't forget, that those Security verifications can be done during the API designing phase, yet using your [preferred IDE](https://42crunch.com/resources-free-tools/) *(Intelij, VSCode, Eclipse etc)*, or even using your ***[CI/CD pipeline tool](https://42crunch.com/resources-free-tools/)***, such as Bitbucket, Jenkins, Azure, Bamboo and others.

  

Companies from anywhere in the world can introduce security best-practices in their entire APIs and Microservices development life-cycle, in many different architectures.

![enter image description here](https://github.com/edgars/docker-42c-apifirewall/raw/main/images/flow-with-42crunch.png)

## Focusing on API Firewall

  

In this demo we will focus on the **API Firewall** (Guardian). The first thing we have to do is to go in the 42Crunch platform, and configure the [API Firewall to some specific(s) API(s)](https://42crunch.com/micro-api-firewall-protection), when we do that, we can get a token in order to connect the on-premises Micro API Firewall to the 42Crunch platform running on cloud. You have to the 42Crunch Console's left main menu in the option **Protect**, a Popup will show up, and you will have to select the API from an existing collection that you want to protect. Here a basic demonstration if you have a collection ready to be protected by the API Firewall *(keep in mind that just APIs with a score of more than 70 can be protected by the API Firewall).*

  

![Parte 1](https://github.com/edgars/docker-42c-apifirewall/blob/main/images/configure-scan.gif?raw=true)

  

![enter image description here](https://github.com/edgars/docker-42c-apifirewall/blob/main/images/configure-scan_part2.gif?raw=true)

  

As you noticed, you configuration had generated a token, we will must use this later.

  

## The Dockerfile

As we have many environment variables to pass to the docker image, it is must easier to extend the standard 42Crunch image, and add your whole configurations, as I did in the following code listing:

```

1 FROM 42crunch/apifirewall:latest

2 COPY ./cert/*.pem /opt/guardian/conf/ssl/

3 COPY ./cert/*.key /opt/guardian/conf/ssl/

4 ENV PROTECTION_TOKEN=384f00d7-f547-42cb-8871-3630a843b13f

5 ENV SERVER_NAME=localhost

6 ENV LISTEN_PORT=443

7 ENV TARGET_URL=https://localhost:8080/42crunch-auth0

8 #ENV LISTEN_NO_TLS=1

9 ENV LISTEN_SSL_CERT=fullchain-cert-with-ca.pem

10 ENV LISTEN_SSL_KEY=localhost.key

11 ENV GUARDIAN_INSTANCE_NAME=springboot-sample

12 ENV LOG_LEVEL=debug

13 ENV ERROR_LOG_LEVEL=debug

```

The API Firewall will protect a simple SpringBoot service .

  

*`Tip: awk '{printf("% 4d %s\n", NR, $0)}' Dockerfile (for printing line numbers)`*

  

API Firewall running:

![enter image description here](https://github.com/edgars/docker-42c-apifirewall/blob/main/images/firewall_running.png?raw=true)

  

Invoking API Firewall and getting an error in that layer:

![enter image description here](https://github.com/edgars/docker-42c-apifirewall/blob/main/images/firewall_curl.png?raw=true)

  

Tracing the request in 42Crunch Dashboard:

![enter image description here](https://github.com/edgars/docker-42c-apifirewall/blob/main/images/Firewall_running_dashboard.png?raw=true)

  


### Important Docker Commands

  

    docker exec -it <Container_ID> sh
