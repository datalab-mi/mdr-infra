_Dépot boite à outils pour déployer un environement de dev avec openstack_

Architecture :

TODO: Créer un bastion pour le projet.


## Présentation
 Makefile : Contient les commandes et variables du projet.<br />
 |_ tools.<br />
 |_ heat-templates.<br />
  |_ config-script.<br />
    |_ back_postconf.sh **Configure le serveur et installe docker**
    |_ launch.sh **Lance le code applicatif**

## Prérequis
 - Dans un tenant OpenStack, créer un projet.
 - Créer un volume persistant.
 - Télécharger à la racine le fichier openrc.sh du projet.
 - Ajouter à ce fichier les exports :
 ```export BASTION_INFRA_IP="ip_bastion"
 export OS_HTTP_PROXY="http://username:passwd@ip_proxy:port"
 export OS_HTTPS_PROXY="http://username:passwd@ip_proxy:port"
 export OS_NO_PROXY="..."
 export DNS_SERVERNAME="ip1,ip2,..."
 export DATA_VOLUME_ID="id"
 ```
 - Sourcer le fichier: `source openrc.sh`
 - Créer une paire de clefs pour la connexion ssh : `make keypair-create`

## Commandes utiles
 - Construire le fichier de paramètre heat : `make heat-params`
 - Déployment : `make deploy`
 - Monitorer le déploiement : `make stack-event-list`
 - Destruction : `make delete`
 - Connexion ssh : `make ssh`
