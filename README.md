# docker-42c-apifirewall - POC/Demo

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


