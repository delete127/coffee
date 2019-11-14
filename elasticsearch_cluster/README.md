# elasticsearch_Cluster
This repo controls the Ansible Role for ElasticSearch cluster installation.

# How to run (here assume you have host/inventory is ready based on Node-defination standard)

```
ansible-playbook site.yml
```
# Supported OS  

```
Redhat 7
Ubuntu 14/16/18
Amazon Linux
```

# Dependencies
pyhton  
Java 1.8 or greater 

# Variables/Default for elasticsearch
change below information and uncomment it based on your requirement in var/main.yml file:

```
elasticsearch_version: "6.5.1"
cluster_name: es-cluster

#es_jvm_dump: /var/lib/elasticsearch/heap
#data_path: /var/lib/elasticsearch
#log_path: /var/log/elasticsearch

#esIP: "0.0.0.0"
```

# Node defination:
Define your type of nodes in host/inventory file based on below format. Can increase the node counts as much you want. 

```
[es:children]
esm
esd
esc
[esm]
x.x.x.x ansible_ssh_user=ubuntu
x.x.x.x ansible_ssh_user=ubuntu
x.x.x.x ansible_ssh_user=ubuntu
[esd]
x.x.x.x ansible_ssh_user=ubuntu
x.x.x.x ansible_ssh_user=ubuntu
```
Client node configuration is Optional, if required add below info in host/inventory file:
```
[esc]
x.x.x.x ansible_ssh_user=ubuntu
```
Where,  
es: is cluster group name  
esm: is master node information  
esd: is data node information  
esc: is client node information  

# Example Playbook

```
- hosts: es
  roles:
     - { role: elasticsearch_cluster }
```

# License

BSD
