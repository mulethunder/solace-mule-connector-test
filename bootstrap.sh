#######################################################################
# Testing Solace MuleSoft connector
# This script was created by Carlos Rodriguez Iturria (https://www.linkedin.com/in/citurria/)
#######################################################################

    # echo "##########################################################################"
    # echo "###################### Updating packages ##############################"

    sudo apt-get update

    echo "##########################################################################"    
    echo "###################### Installing Git ##############################"

    sudo apt-get install git -y
   
    echo "##########################################################################"
    # echo "############### Installing NodeJS on an Ubuntu Machine ###############"

    # sudo curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

    # sudo apt-get install nodejs -y

    echo "##########################################################################"
    echo "############# Installing and configuring Docker for Dev #######################"

    # Following these instructions: https://docs.docker.com/engine/install/ubuntu/

    sudo apt-get remove docker docker-engine docker.io containerd runc
    
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh

    sudo usermod -aG docker vagrant

    # echo "##########################################################################"
    # echo "############### Downloading and Running Solace PubSub+ Broker Docker image ########################"

    # Reference:" https://solace.com/products/event-broker/software/getting-started/"

    # docker run -d -p 8080:8080 -p 55555:55555 -p:8008:8008 -p:1883:1883 -p:8000:8000 -p:5672:5672 -p:9000:9000 \
    # -p:2222:2222 --shm-size=2g --env username_admin_globalaccesslevel=admin --env username_admin_password=admin \
    # --name=solace solace/solace-pubsub-standard
