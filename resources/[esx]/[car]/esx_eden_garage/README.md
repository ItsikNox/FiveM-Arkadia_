# esx_eden_garage

esx_eden_garage update no duplicate

Garage privé basé sur ESX

Requirement : 
fxserver-esx_vehicleshop

Le garage prends en compte uniquement les véhicules achetés dans le concessionaire et aussi les véhicules qui sont dehors ou non.
Lors d'un reboot tous les véhicules passe en rentré.

1) Il faut appliquer le SQL
2) Mettre la resource dans votre server.cfg
3) Modifier la config pour ajouter garage ou modifier

BUG CONNU :

- Certains véhicules sont impossible à rentrer
- En cherchant bien il est possible de dupliquer les véhicules

Nous travaillons dessus. 

Fonctionnement :
Entrez dans le cercle vert a pied pour sortir un vehicule, entre dans le cercle rouge avec votre vehicule pour le rentrer si le vehicule est endomagé un menu vous annonce le montant de la facture vous pouvez la payer pour rentrer le vehicule ou aller voir un mécano

