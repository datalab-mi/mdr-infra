_Dépot boite à outils pour déployer un environement de dev avec openstack_

Architecture :

TODO: Créer un bastion pour le projet.


## Présentation
 Makefile : Contient les commandes et variables du projet.<br />
 |_ tools.<br />
 |_ heat-templates.<br />
  &nbsp;|_ config-script.<br />
    &nbsp;&nbsp;|_ back_postconf.sh **Configure le serveur et installe docker**.<br />
    &nbsp;&nbsp;|_ launch.sh **Lance le code applicatif**.<br />

## Prérequis
 - Dans un tenant OpenStack, créez un projet.
 - Créez un volume persistant.
 - Téléchargez à la racine le fichier openrc.sh du projet.
 - Ajoutez à ce fichier les exports :
 ```export BASTION_INFRA_IP="ip_bastion"
 export DATA_VOLUME_ID="id"
 ```
 - Sourcez le fichier: `source openrc.sh`
 - Générez une paire de clefs pour la connexion ssh : `make keypair-create`

## Commandes utiles
 - Construire le fichier de paramètre heat : `make heat-params`
 - Déployment : `make deploy`
 - Monitorer le déploiement : `make stack-event-list`
 - Destruction : `make delete`
 - Connexion ssh : `make ssh`
