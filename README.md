# solace-mule-connector-test
Solace MuleSoft Connector Test
------

This repository contains the Solace MuleSoft Connector Test project. It provides a quick way to spin up a Soalce Event Broker. 

Spin up Solace Event Broker
------

   - For ful details about how to use this repo, [read this blog](https://mulethunder.blog/2021/01/11/teaching-how-to-use-the-solace-mulesoft-connector/).  
   - Ensure you have installed Vagrant on your laptop/PC. If you need help, [read this blog](https://mulethunder.blog/2021/01/08/teaching-how-to-use-vagrant-to-simplify-building-local-dev-and-test-environments/). 

   - Download or Git clone this Github repo: 

			git clone https://github.com/mulethunder/solace-mule-connector-test.git

   - In a terminal window, change directory to where you cloned/downloaded the repository (solace-mule-connector-test) – Notice that the Vagrantfile is already in there.

   - Start up your Vagrant Dev VM:

	        vagrant up

   - A new Ubuntu VM will be provisioned and a bootstrap script will install all required utilities (e.g. docker and Solace images).
    
   - You can now **vagrant ssh** into the Virtual Machine.

            vagrant ssh

   - Run Solace Event Broker as a docker container:

            docker run -d -p 8080:8080 -p 55555:55555 -p:8008:8008 -p:1883:1883 -p:8000:8000 -p:5672:5672 -p:9000:9000 -p:2222:2222 –shm-size=2g –env username_admin_globalaccesslevel=admin –env username_admin_password=admin –name=solace solace/solace-pubsub-standard


   - Solace Event Broker is up and running, confirm that is the case:

            docker ps -a
    
        You sill see the running process. Something like this:

        CONTAINER ID   IMAGE                           COMMAND               CREATED      STATUS      PORTS                                                                                                                                                                                              NAMES
213985adbb80   solace/solace-pubsub-standard   "/usr/sbin/boot.sh"   3 days ago   Up 2 days   0.0.0.0:1883->1883/tcp, 0.0.0.0:2222->2222/tcp, 0.0.0.0:5672->5672/tcp, 0.0.0.0:8000->8000/tcp, 0.0.0.0:8008->8008/tcp, 0.0.0.0:8080->8080/tcp, 0.0.0.0:9000->9000/tcp, 0.0.0.0:55555->55555/tcp   solace


Managing the Docker container
------

   - Use the container **kubectl** to apply differnet tasks:

        For example:

        - Stop the container:
            docker container [id] stop
        - Start the contaiuner:
            docker container [id] start

If you need any assistance, feel free to [contact me](https://www.linkedin.com/in/citurria/).