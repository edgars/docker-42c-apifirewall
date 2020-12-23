# docker-42c-apifirewall - POC/Demo

**WIP**
**WIP**
In this demonstration I will show how to protect basic Microsevices using Micro-APIFirewall. In our case, we have a basic SpringBoot app that is fully audited, scanned and protected by 42Crunch platform.

![Example that we will demonstrante](https://github.com/edgars/docker-42c-apifirewall/raw/main/images/demo.png)

# Getting Started
We will use the 42Crunch API Firewall official image hosted at DockerHub, here is the image location: https://hub.docker.com/r/42crunch/apifirewall , please refer to that default image base in order to complete this POC/Demo. 

# What to Protect ? 

If you had arrived to that question, you must be able to understand 2 points about API Protection: 

What about your APIs: 
 1. Security Auditing (Score)
 2. Conformance Scaning (Level)

The number one bullet is related to how secure is you API to go live, it means: How is your protection level on the whole internet? 

![enter image description here](https://github.com/edgars/docker-42c-apifirewall/raw/main/images/security_audit.png)

The Audit Score above is ok in order to be pushed to production. Don't forget, that those Security verifications can be done during the API designing phase, yet using your preferred IDE, or even using your CI/CD pipeline tool, such as Bitbucket, Jenskins, Azure, Bamboo and others. 

Companies from anywhere in the world can introduce security best-practices in their entire APIs and Microservices development life-cycle, in many different architectures. 
![enter image description here](https://github.com/edgars/docker-42c-apifirewall/raw/main/images/flow-with-42crunch.png)
## Focusing on API Firewall

The first thing we have to do is to go in the 42Crunch platform, and configure the API Firewall to some specific(s) API(s), when we do that, we can get a token in order to connect the on-premises Micro API Firewall to the 42Crunch platform running on cloud.  You have to the 42Crunch Console's left main menu in the option **Protect**, a Popup will show up, and you will have to select the API from an existing collection that you want to protect.  Here a basic demonstration if you have a collection ready to be protected by the API Firewall *(keep in mind that just APIs with a score of more than 70 can be protected by the API Firewall).* 

![Parte 1](https://github.com/edgars/docker-42c-apifirewall/blob/main/images/configure-scan.gif?raw=true)

![enter image description here](https://github.com/edgars/docker-42c-apifirewall/blob/main/images/configure-scan_part2.gif?raw=true)

As you noticed, you configuration had generated a token, we will must use this later. 

