# Ansible based Quobyte installer 

This playbook installs a Quobyte cluster from scratch. It uses no external resources like installer scripts and thus should be easy to read and understand for someone who is familiar with Ansible. 

To get started you need to configure an inventory (inventory.yaml is an example you can re-use). 
Also you need to adopt vars/ansible-vars to your needs.

After that you can use the numbered playbooks to install and configure a Quoybte cluster.

## Core installation

00_install_quobyte-server.yaml: Adds Quobyte package repositories, installs Quobyte server packages.

01_setup-coreservices.yaml: Sets up registry, api and webconsole services. After this step you are able to login to your cluster with default credentials.

02_create_superuser.yaml: Sets up a Super User for your cluster. It uses username and password stored in vars/ansible-vars. From this point on no unauthenticated access to your cluster is possible.

03_add_metadataservices.yaml: Installs and starts Quobyte Metadata Service. Formats and labels the metadata device that you defined as a variable in vars/ansible-vars.

04_add_dataservices.yaml: Installs and start Quobyte Data Service. Formats and uses all devices within a machine that are not already formatted. After this step you get a fully functional Quobyte cluster.

## Optional install steps

05_optional_tune-cluster.yaml: Sets "sysctl" parameters with  the help of a Qoubyte profile for the "tuned" daemon. You can use it as a conveniency if you do not want to tune your system by yourself.

06_optional_install_defaultclient.yaml: Installs the native Quobyte client on all machines in the "clients" section of your inventory file. It will not only install the binary to execute single mount commands but also the systemd unit file that sets up the client to automatically mount any Quobyte volume on the local machine below a given mount point. You can determine the mount by setting the variable in vars/ansible-vars.  

07_optional_license_cluster.yaml: This adds a given license to the cluster. It needs a file path to the license file set as a variable. The license file is a plain text file containing your license code obtained from the Quoybte support portal ("https://support.quobyte.com").

08_optional_add_s3services.yaml: Activates Quoybte S3-Proxy on all nodes listed in the s3-services section of your inventory. You need a working DNS solution with wildcard entries resolving your configured "s3_endpoint" variable to at least one of your nodes where this proxy is runninng. For development/ evaluation purposes you can use the Quobyte Name Service (see 10_optional_use_qns.yaml)  

09_optional_add_device_tags.yaml: This is an example of how to set device tags. 

10_optional_use_qns.yaml: This example shows you how to consume the Quobyte Name Service (qns). Can be useful to instantly use the Quoybte S3 object storage.


