# Ansible based Quobyte installer 

This collection of playbooks installs a Quobyte cluster from scratch. 

## Installing Quobyte

### Step one: Adjust Inventory and Variables 

You can use ``` inventory.yaml ``` as an example and adjust it to your needs. Within this file you will 
line out how your Quobyte cluster will look like.
You can decide which nodes will run data services, metadata services and so on.
The second part to consider is the variables file ``` vars/ansible-vars ```. 
You can decide here which devices will hold your metadata, the credentials for a Quobyte superuser account
you and so on.
With only these two files in place you can start the installation.


### Step two: Install the Storage Cluster

All your playbooks can be executed using the following command:

```
$ ansible-playbook -i inventory.yaml <playbookName>
```

You can choose to install these playbooks step by step or all at once. For example 

```
$ ansible-playbook -i inventory.yaml 00_install_quobyte_server.yaml 01_setup_coreservices.yaml 02_create_superuser.yaml 03_add_metadataservices.yaml 04_add_dataservices.yaml 05_optional_tune-cluster.yaml
```

would result in a Quobyte setup that is ready to use and has already ensured some system tuning parameters.

The same way you can for example add a license, create volumes etc.

## Lifecycle management

All playbooks are designed to be idempotent. You can run them more than once and can expect the same results.

### Adding Dataservices

Should your installation require more dataservices you can use the following procedure:

1) Add nodes to the inventory
2) Run two playbooks:

```
$ ansible-playbook -i inventory.yaml 00_install_quobyte_server.yaml 04_add_dataservices.yaml  
```

This will only result in changes on the newly added dataservices, they will be part of the cluster afterwards with all empty devices added as datadevices.

### Adding more Storage Devices

If more disks are inserted into a server (either virtual or physical) you can re-run also the "add_dataservices" playbook:
```
$ ansible-playbook -i inventory.yaml 04_add_dataservices.yaml  
```

All empty devices are then also part of the cluster.

### Uninstall

There is one playbook you can use to get rid of a Quobyte installation:

```
$ ansible-playbook -i inventory.yaml helper/0x_wipe_cluster.yaml  
```

This playbook erases all data on all Quobyte devices, stops services and removes binaries.
You can use it for example if you want to start from scratch with a new installation.



