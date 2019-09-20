
# FiveM-BanSql

An SQL ban that does not overload the database.
It precharges the database in a table when opening the server or adding / removing a ban.

# Installation
1. Download the .Zip from this repository.
2. Extract it with your favorite program.
3. Copy the project to your ressource folder.
4. Don't forget to import the .sql file to your database.
5. Add "start FiveM-BanSql" in your `server.cfg`

# Commands
___
1. **sqlban id days reason** (	Allows ban a connected player	)
 - "id" is the player's number in the list
 - "days" must be a number to say how many days it will be ban. (0 days mean permanent)
 - "reason" Ability to register why he is banished. Attention if there is no reason the player will see: "You are banned for: unknown reason"
 - example /sqlban 3 1 Troll (Will give ban player # 3 for 1 days with Troll reason)
___

2. **sqlbanoffline permid days reason** (	   Allows ban a offline player	  )
 - "permid" get from command sqlsearch
 - "days" must be a number to say how many days it will be ban. (0 days mean permanent)
 - "reason" Ability to register why he is banished. Attention if there is no reason the player will see: "You are banned for: unknown reason"
 - example /sqlbanoffline 1 1 cheating (Will ban first player in database 1 day for cheating)
2.1 ***sqlsearch (name)
 - "name" is the player's steam name
 - example /sqlsearch name (Will show you permid and name of found players)
___

3. **sqlunban "Steam Name"**
 - Deban the player matching the written name.
 - Example sqlunban Alex Garcio (Will remove from the ban list the player)
___

4. **sqlbanreload ** (reload the BanList and the BanListHistory)
  - Can be used if you edit directly in your database.
___

5. **sqlbanhistory option** (Allows you to view the ban history of a player offline or online)
- "option"
- (Name of a player) To display all the banns of a player
- 1 To display only the first ban
- 2 To display only the second ban
- 3 ect ......
- 4 ect ......
- Example /sqlbanhistory Alex Garcio (Go to display all the list of player's bans)
___

6. **bansql** (Will show in game commands)
- Example /bansql


# Required resource
- Async


# Created by
- Alex Garcio https://github.com/RedAlex
- Alain Proviste https://github.com/EagleOnee


___
# FiveM-BanSql

Un ban SQL qui ne surcharge pas la base de donnée.
Il précharge la base de données dans une table lors de l'ouverture du serveur ou à l'ajout/retrait d'un ban.

# Installation
1. Téléchargez le .Zip
2. Extractez-le avec votre programme favori.
3. Copiez le projet dans votre dossier ressource.
4. N'oubliez pas d'importer le .sql a votre base de données.
5. Ajoutez "start FiveM-BanSql" dans votre `server.cfg`


# Commandes
___
1. **sqlban id jours raison** (  Permet de ban un joueur connecté 	)
 -  "id" correspond au chiffre du joueur dans la liste
 -  "jours" doit être un chiffre pour dire combien de jours il va etre ban. (0 jours veux dire permanent)
 -  "raison" Possibilité d'inscrire pourquoi il est bani. Attention si il n'y a pas de raison le joueur va voir : "Vous etes banni pour : Raison Inconnue"
 -  exemple /sqlban 3 1 Troll (Va donner bannir le joueur #3 pour 1 jours avec la raison Troll)
___

2. **sqlbanoffline permid jours raison (	   Vous permet de ban un jours hors ligne	)
 -  "permid" correspond au chiffre du joueur dans la liste
 -  "jours" doit être un chiffre pour dire combien de jours il va etre ban. (0 jours veux dire permanent)
 -  "raison" Possibilité d'inscrire pourquoi il est bani. Attention si il n'y a pas de raison le joueur va voir : "Vous etes banni pour : Raison Inconnue"
 - example /sqlbanoffline 1 1 Triche (Va bannir le premier joueur de la base de donnée 1 jours pour Triche)
2.1 ***sqlreason (nom)
 -  "nom" correspond au nom steam du joueur
 - example /sqlreason reason (Va donner bannir le joueur que vous avez entré plus tot pour la raison entrer ici)
___

3. **sqlunban "Nom Steam"**
 - Déban le joueur correcpondant au nom écrit.
 - Exemple /sqlunban Alex Garcio (Va enlever de la liste de ban le joueur)
___

4. **sqlbanreload** (   Recharge la BanList et la BanListHistory   )
  - Peut etre utilisé si vous modifiez directement dans votre base de données.
___

5. **sqlbanhistory option ** (	 Permet d'afficher l'historique de ban d'un joueur hors ligne ou en ligne	)
-   "option" 
-		(Nom Steam) Pour afficher tout les bans d'un joueur
-		1 Pour afficher seulement le premier ban
-		2 Pour afficher seulement le deuxième ban
-		3 ect......
-		4 ect......
-   Exemple /sqlbanhistory Alex Garcio (Va afficher toute la liste des bans du joueur)
___

6. **bansql** (Affiche les commandes en jeu)
- Example /bansql


# Ressource requis
- Async


# Créer par
- Alex Garcio https://github.com/RedAlex
- Alain Proviste https://github.com/EagleOnee
