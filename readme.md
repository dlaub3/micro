# Traefik Jenkins Deploy 

[Traefik](https://docs.traefik.io/) is an excellent server for microservices. It's easy to configure multiple backends. Best of all it has automatic Let's Encrypt support.

[Jenkins](https://jenkins.io/) is an open source automation sever. It's great for configuring CI/CD pipelines. 

This project can be expanded with other microservices running behind traefik. At this time I only have a basic Jenkins configuration. 

## Installation
* Clone the project and `cd` into the folder
* Run `chmod 600 acme.json`
* Run `cp env.example .env` and add your desired hostname and protocol. For local testing you will want to set the protocol to http and add redirects in your `/etc/hosts` file. 
* Add your email to the `traefik.toml` file for Let's Encrypt. Search for: `email = ""`. 
* run `docker-compose up` and watch the output for the Jenkins administrator password. If you don't get it when the containers boot-up you can run `docker-compose exec --user=root jenkins bash` and copy the password from the server: `/var/jenkins_home/secrets/initialAdminPassword`. 

## Customize Jenkins
You will likely need to customize Jenkins by adding plugins to plugins.txt or configuring server dependences in jenkins.Dockerfile. The current setup supports deploying Hugo to AWS. 

## Automation 
- `refresh-images.sh` use for automating updates with a Cron job
- `removecert.sh` use for removing certs
- `jenkins/update-plugins.sh` use for generating a list of installed plugins 

## MISC
- `log/` may grow quite large overtime. Consider setting up log rotation for the files
    in this directory.
- `sudo docker volume inspect $(basename "$PWD")_jenkins` docker volume location
- `sudo docker-compose exec --user root jenkins ls -al /var/jenkins_home/` run
    arbitrary commands as root. This is useful for solving errors with file
    permissions.
    - `chown -R jenkins:jenkins /var/jenkins_home/workspace`
    - `chown -R jenkins:jenkins /var/jenkins_home/jobs`

## Troubleshooting 
- Jenkins fails to start: comment out this line `USER jenkins` in `jenkins.Dockerfile`. Then run `sudo sh refresh-images.sh`. After the images start uncomment that line and restart the images. This should solve any errors with file permissions.

### Links
* https://github.com/containous/traefik
* https://github.com/jenkinsci/docker
