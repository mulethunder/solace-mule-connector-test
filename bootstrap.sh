#######################################################################
# Testing Solace MuleSoft connector
# This script was created by Carlos Rodriguez Iturria (https://www.linkedin.com/in/citurria/)
#######################################################################
#################### Reading and validating passed parameters and mandatory files:

# Checking if Private key exists:
#cp -r /vagrant/ssh /home/vagrant/ssh
#chmod 400 /home/vagrant/ssh/*

#if [ ! -f /home/vagrant/ssh/id_rsa_pri.pem ]; then
#    echo "Private key doesn't exist. Make sure /home/vagrant/ssh/id_rsa_pri.pem exists!"
#    exit 1
#fi

if [ "$#" -ne 6 ]; then

    echo "**************************************** Error: "
    echo " Illegal number of parameters."
    echo " Order: [TENANCY_OCID USER_OCID PUB_KEY_FINGERPRINT OKE_OCID REGION_SHORTNAME INSTALL_KUBECTL_BOOLEAN]"
    echo " Example: ./bootstrap.sh TENANCY_OCID USER_OCID PUB_KEY_FINGERPRINT OKE_OCID us-ashburn-1 true"
    echo "****************************************"
    exit 1
    
fi

TENANCY_OCID=$1
USER_OCID=$2
PUB_KEY_FINGERPRINT=$3
OKE_OCID=$4
REGION_SHORTNAME=$5
INSTALL_KUBECTL_BOOLEAN=$6


    # echo "##########################################################################"
    # echo "###################### Updating packages ##############################"

    # sudo apt-get update

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

    echo "##########################################################################"
    echo "############### Downloading and Running Solace PubSub+ Broker Docker image ########################"

    # Reference:" https://solace.com/products/event-broker/software/getting-started/"

    docker run -d -p 8080:8080 -p 55555:55555 -p:8008:8008 -p:1883:1883 -p:8000:8000 -p:5672:5672 -p:9000:9000 \
    -p:2222:2222 --shm-size=2g --env username_admin_globalaccesslevel=admin --env username_admin_password=admin \
    --name=solace solace/solace-pubsub-standard


    echo "##########################################################################"
    echo "############### Installing Kubectl for target OKE cluster ########################"


    if [ "$INSTALL_KUBECTL_BOOLEAN" = false ]; then
        echo "No need to install kubectl. Finishing bootstrap successfully!!!"
        exit 0
    fi    

    echo " ################## Configuring .oci/config:"
    #    Interactive way: bash oci setup config

    mkdir -p /home/vagrant/.oci && cp /vagrant/oci/config_template /home/vagrant/.oci/config

    sed -i "s/@USER_OCID@/${USER_OCID}/g" /home/vagrant/.oci/config
    sed -i "s/@PUB_KEY_FINGERPRINT@/${PUB_KEY_FINGERPRINT}/g" /home/vagrant/.oci/config
    sed -i "s/@TENANCY_OCID@/${TENANCY_OCID}/g" /home/vagrant/.oci/config
    sed -i "s/@REGION_SHORTNAME@/${REGION_SHORTNAME}/g" /home/vagrant/.oci/config

    # Since root is running this bootstrap, let's make sure it also has the main .oci/config file:
    mkdir -p /root/.oci && cp /home/vagrant/.oci/config /root/.oci/config

    echo " ################## Installing Go:"
    
    wget https://dl.google.com/go/go1.11.5.linux-amd64.tar.gz
    tar -C /usr/local -xzf go1.11.5.linux-amd64.tar.gz    
    echo "export PATH=$PATH:/usr/local/go/bin" >> /home/vagrant/.profile    
    /usr/local/go/bin/go version

    echo " ################## Downloading oke-go utility from CSenese github repo:"
    git clone https://github.com/cameronsenese/oke-go.git
    cd oke-go
    
    # Pulling dependencies:
    /usr/local/go/bin/go get -u github.com/oracle/oci-go-sdk
    /usr/local/go/bin/go get -u github.com/Jeffail/gabs
    /usr/local/go/bin/go get -u gopkg.in/alecthomas/kingpin.v2

    # Compiling utility oke-go code:
    /usr/local/go/bin/go build oke-go.go

    echo " ################## Downloading kube config file for a particular oke cluster tenancy:"

    # Downloading kube config from a particular OKE cluster:
    ./oke-go createOkeKubeconfig --clusterId=$OKE_OCID

    if [ ! -f /home/vagrant/oke-go/.oke-go/kubeconfig ]; then
        echo "Error while retrieving kube config. Verify and try again!"
        exit 1
    fi

    mkdir -p /home/vagrant/.kube && cp /home/vagrant/oke-go/.oke-go/kubeconfig /home/vagrant/.kube/config

    echo " ################## Installing kubectl now that we've got the kube config file:"
    sudo apt-get update && sudo apt-get install -y apt-transport-https

    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

    echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

    sudo apt-get update

    sudo apt-get install kubectl

    # Since root is running this bootstrap, let's make sure it also has the main .kube/config file:
    mkdir -p /root/.kube && cp /home/vagrant/.kube/config /root/.kube/config


    echo " ################## Testing kubectl:"
    kubectl get nodes