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

## Step 1: Focusing on API Firewall
In this demo we will focus on the **API Firewall** (Guardian). The first thing we have to do is to go in the 42Crunch platform, and configure the [API Firewall to some specific(s) API(s)](https://42crunch.com/micro-api-firewall-protection), when we do that, we can get a token in order to connect the on-premises Micro API Firewall to the 42Crunch platform running on cloud. You have to the 42Crunch Console's left main menu in the option **Protect**, a Popup will show up, and you will have to select the API from an existing collection that you want to protect. Here a basic demonstration if you have a collection ready to be protected by the API Firewall *(keep in mind that just APIs with a score of more than 70 can be protected by the API Firewall).*

  

![Parte 1](https://github.com/edgars/docker-42c-apifirewall/blob/main/images/configure-scan.gif?raw=true)

  

![enter image description here](https://github.com/edgars/docker-42c-apifirewall/blob/main/images/configure-scan_part2.gif?raw=true)

  

As you noticed, you configuration had generated a token, we will must use this later.

  

## Step 2: The Dockerfile

We will extend the 42Crunch's default image in order to pass the certificate files as you can see in the following code listing:

```
FROM 42crunch/apifirewall:latest
COPY ./cert-2/myapis.docker.local/*.pem /opt/guardian/conf/ssl/
COPY ./cert-2/myapis.docker.local/*.key /opt/guardian/conf/ssl/
```
When we run the Docker image, we will have to pass the `env.list` file that contains the whole informations and environment variables that we have to pass:

    #env.list file
    #Variables used in that Docker machine
    PROTECTION_TOKEN= #### THAT COMES FROM 42Cruch Platform from the previous step 
    SERVER_NAME=myapis.docker.local
    LISTEN_PORT=443
    #TARGET_URL=https://lbspring.42crunch-ns.207.244.225.188.xip.io/42crunch-auth0
    TARGET_URL=http://207.244.225.188:32095/42crunch-auth0
    #ENV LISTEN_NO_TLS=1
    LISTEN_SSL_CERT=fullchain-cert-with-ca.pem
    LISTEN_SSL_KEY=myapis.docker.local.key
    GUARDIAN_INSTANCE_NAME=springboot-sample
    LOG_LEVEL=debug
    ERROR_LOG_LEVEL=debug

You can use the following command line in order to execute our Docker Image: 


The API Firewall will protect a simple SpringBoot service that is deployed into a Kubernetes/Rancher environment with auto-signed certificates, hosted here: https://lbspring.42crunch-ns.207.244.225.188.xip.io/42crunch-auth0 . If for some reason, you want to tweak this Docker Image as well here is the repository link: https://hub.docker.com/repository/docker/edgars/spring-auth0 


----------


*`Tip: awk '{printf("% 4d %s\n", NR, $0)}' Dockerfile (for printing line numbers)`*

## Step 3: Running the Firewall 

Let's execute the API Firewall running first the 

![enter image description here](https://github.com/edgars/docker-42c-apifirewall/blob/main/images/firewall_running.png?raw=true)


Invoking API Firewall and getting an error in that layer:

![enter image description here](https://github.com/edgars/docker-42c-apifirewall/blob/main/images/firewall_curl.png?raw=true)

  

Tracing the request in 42Crunch Dashboard:

![enter image description here](https://github.com/edgars/docker-42c-apifirewall/blob/main/images/Firewall_running_dashboard.png?raw=true)

  


### Important Docker Commands

    docker exec -it <Container_ID> sh


# Step by Step Demo

## Step 1 - Cloning the git repo

Into a VM (vagrant box, or anyone), clone the git repo using the following command:

    git clone https://github.com/edgars/docker-42c-apifirewall.git

    cd docker-42c-apifirewall


## Step 2 - Building the Docker Image

Inside the folder docker-42c-apifirewall, please execute the following command:

    $ /docker-42c-apifirewall# docker build . -t edgars/apifirewall

The output would be something like this:

    Sending build context to Docker daemon  19.08MB
    Step 1/3 : FROM 42crunch/apifirewall:latest
    latest: Pulling from 42crunch/apifirewall
    cbdbe7a5bc2a: Pull complete
    2f3423c94931: Pull complete
    19c0fc490a22: Pull complete
    253507af6fbe: Pull complete
    5aa7a09f5063: Pull complete
    3098faed39e2: Pull complete
    3a076437d664: Pull complete
    98c34d8089f9: Pull complete
    Digest: sha256:ad317d32edb71a7fd5220aa3b9be55a2b7e1feffd19c86d85c5461f5843acc99
    Status: Downloaded newer image for 42crunch/apifirewall:latest
     ---> d801c28de7a3
    Step 2/3 : COPY ./cert-2/myapis.docker.local/*.pem /opt/guardian/conf/ssl/
     ---> b28078088550
    Step 3/3 : COPY ./cert-2/myapis.docker.local/*.key /opt/guardian/conf/ssl/
     ---> 14623b8b46c5
    Successfully built 14623b8b46c5

## Step 3 - Running the API Firewall (Guardian)
Now, we will run the API Firewall, this repo, contains my keys, if you want to change it in order to use yours, please, change the file env.list please.

    $ docker run --env-file env.list -p 8443:443 edgars/apifirewall

The output would be something like this:

    root@ubuntu-bionic:/home/vagrant/docker-42c-apifirewall# docker run --env-file env.list -p 8443:443 edgars/apifirewall
    squire 0.28.10-release:v0.28.10 : 8470b28cb222203a3121ec7bfdad63a90e3c9956-N :Tue Jan  5 23:41:42 2021 root@4d85136cc398
    2021/01/05 23:41:42 Connecting platform
    Dialling platform at 'protection.42crunch.com:8001'...
    2021/01/05 23:41:43 Connected to 'protection.42crunch.com:8001'
    2021/01/05 23:41:43 Starting routines (protection)
    2021/01/05 23:41:43 Registered with remote platform
    2021/01/05 23:41:44 New configuration received
    2021/01/05 23:41:44 Writing new configuration...
    2021/01/05 23:41:44 New configuration persisted
    2021/01/05 23:41:44 Starting/Reloading API Firewall...
    2021/01/05 23:41:44 API Firewall started/reloaded

## Step 4 - Testing the API Firewall (Guardian) 

Please, execute the following curl invocation:

    curl -i -k https://myapis.docker.local/xls

The result will be something like this: 

    HTTP/1.1 200 OK
    Date: Wed, 06 Jan 2021 00:09:13 GMT
    X-Content-Type-Options: nosniff
    X-XSS-Protection: 1; mode=block
    Cache-Control: no-cache, no-store, max-age=0, must-revalidate
    Pragma: no-cache
    Expires: 0
    X-Frame-Options: DENY
    Content-Type: text/plain;charset=UTF-8
    Content-Length: 23
    
    Hello XLS  - plain text

This request was intercepted and handled by the API Firewall, as this resource exists in the API contract, and also the response pattern allows this response, even in a plan text. However, if you try send a request to a path that does not exists or a http method that is not supported, or any validation or policy is not respected, the API Firewall shimes and let your API safe and secure. 

Check this example:

    curl -i -k https://myapis.docker.local/notexistingpath

The result will be something like: 

    HTTP/1.1 404 Not Found
    Date: Wed, 06 Jan 2021 00:13:58 GMT
    Content-Type: application/problem+json
    Content-Length: 104
    
    {"status":404,"title":"path mapping","detail":"Not Found","uuid":"2bfdd66b-0151-4349-bd28-b45e6232f7a3"}

That will be result, even if you API is not handling properly the resources and methods that are not mapped. 

| UUID | Same UUID in the 42Crunch Console |
|:--------:| :--------:|
| 2bfdd66b-0151-4349-bd28-b45e6232f7a3 | ![enter image description here](https://github.com/edgars/docker-42c-apifirewall/blob/main/images/demo-firewall_ok.png?raw=true) |

> Happy Demo/POC

Please, any issue, please open it here in this GitHub repo. Thanks.
