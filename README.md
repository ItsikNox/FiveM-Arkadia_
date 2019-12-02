# FiveM-Arkadia_

French FiveM Server Edited by ikNox#6088

**Changer le mot de passe de connexion/Change the login password :**

* resources\ServerPassword\server.lua ligne 7

**Changer la traduction du mot de passe/Change the password translation :**

* resources\ServerPassword\client.lua ligne 56 & 65

**Discord Bot :**

* "[admin]\FiveM-BanSql-1.0.8\config.lua"

* "[esx]\\[discord]\DiscordBot\config.lua

* "[esx]\\[discord]\esx_discord_bot\config.lua"

**Changer l'annonce de l'ip lors de l'ouverture du serveur/Change the IP announcement when opening the server :**

* "[esx]\\[discord]\DiscordBot\server\Server.lua ligne 66

**DiscordRichPresence :**

* "[esx]\\[discord]\DiscordRichPresence\client.lua" ligne 5, 7, 24, 26, 28, 30, 35, 37, 39, 43, 45, 48, 50 & 52

**FRANCAIS**

**Les glitchs des coffres et des factures négatif sont patchés ainsi que les ressources sécurisées contre les Moddeurs en les kikants.
(bien sûr ils pourront toujours passer à travers certaines choses avec des connaissances)**

**ENGLISH**

**The glitch of the chests and negative invoices are patched as well as the resources secured against Moders by kikants.
(of course they will always be able to go through certain things with knowledge)**

**Pour changer les images des menus/To change menu images :**

* "[esx]\\[ui]\esx_menu_default\html\img\header"

**Si vous avez une erreur avec screenshot-basic aller le retéléchargé/If you have an error with screenshot-basic go re-download it**

**Pour ajouter les images des métiers ou les changers/To add job images or changes :**

"[hud]\esx_customui\html\img" (Nommer l'image avec le nom du job)/(Name the image with the job name)

**Changer le nom du menu de sélection du personnage/Change the name of the character selection menu :**

* "[esx]\\[base]\esx_kashacters\html\ui.html"

**Changer le LoadingScreen (Nom et Image)/Changing the LoadingScreen (Name and Image) :**

* "[hud]\panzar-load\edit_this.html"
* "[hud]\panzar-load\keks.css"

**Changer l'argent de départ/Change the starting money :**

* "[essential]\essentialmode\server\util.lua"

**Changer le message "Synchronisation de votre personnage."/Change the message "Synchronisation de votre personnage." :**


* resources\\[essential]\es_extended\server\functions.lua ligne 110

**Un script de Semi-Whitelist est aussi disponible, pour l'utiliser lancer "esx_douane" ensuite direction/A Semi-Whitelist script is also available, to use it launch "esx_douane" then direction :**

**FRANCAIS
"reboot\server" décommenté la ligne 32 à 37 et modifier l'heure à laquel vous voulez que la whiteliste se lance et à quelle heure vous voulez l'arrêter.**

**ENGLISH
"reboot\server" uncommented line 32 to 37 and change the time at which you want the whitelist to start and at which time you want to stop it.**

**Changer le nom du menu pause/Change the name of the pause menu :**

* resources\[esx]\\[non-esx]\pausemenu-title\server_name.lua ligne 12, 23 & 27

**Changer le nom de la map/Change the name of the map**

* Renommé Arkadia_Map & Arkadia_Map_ / Renamed Arkadia_Map & Arkadia_Map_

**Changer l'image du menu F5/Change the image of the F5 menu**

* resources\[esx]\\[non-esx]\Arkadia_personalmenu\stream\commonmenu.ytd

* ouvrez commonmenu.ytd avec OpenIV et changer l'image/open commonmenu.ytd with OpenIV and change the image

# Key Bindings
```
F2 Quick interaction menu
F5 Interaction menu
F6 Job Menu
F8 Console*
F9 Organisation Menu
F10 Phone
F11 Scoreboard
SHIFT + 1 Teleport to waypoint
HOME Es_admin

L Car trunk

Ctrl Crouch
X Hands Up
Y radargun menu open 246
E radargun freeze 38

Text Commands
/ano Anonymous message
/ooc Message Outside Roleplay
/report Sent a message to the admin
/r ID Respond privately to a /report
/me 3D Text
```

# Jobs List
```
Abatteur = slaughterer
Couturier = tailor
Bûcheron = lumberjack
Ambulance = ambulance
Police = police
Mécano = mecano
Pompiste = pompiste
Vigneron = vigne
Taxi = taxi
Armurerie = ammu
Mixologist = fueler
Journaliste = journaliste
```

# Organisation List
```
Famillies = famillies
Clan Kano =kano
LaZone = lazone
Mercenaire = mercenaire
Podolskaia = podolskaia
Syndicat = syndicat
```

# Admin Commands

**Ajouter un Métier à un joueur/Adding a Business to a Player**
* /setjob ID NomMetier Grade

**Ajouter un Gang à un joueur/Adding an Gang to a Player**
* /setjob2 ID NomMetier Grade

**Bannir un joueur/Banning a player**
* /ban ID Jour(0 = Permanent) Raison

**Bannir un joueur déconnecté/Banning an offline player**
* /banoffline JOUR NomSteam
* /reason Raison

**Unban un joueur/Unban one player**
* /unban NomSteam

**Give un item/Donner un article**
* /giveitem ID NomItem Nombre

**Give une arme/Give a weapon**
* /giveweapon ID NomArme Munition

**Ouvrir le menu es_admin/Open the es_admin menu**
* Touche HOME

**Ouvrir le menu Spectateur/Open the Spectator menu**
* Touche 9 ou /spec.
* Voir sont inventaire Touche G
