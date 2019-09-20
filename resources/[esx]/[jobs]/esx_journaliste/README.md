# ESX_JOURNALISTE

FXServer ESX REPORTER JOB

###### REQUIREMENTS

- Player management (billing and boss actions)

	- esx_society => https://github.com/ESX-Org/esx_society
	- esx_billing => https://github.com/ESX-Org/esx_billing

###### INSTALLATION

1.	CD in your resources/[esx] folder

2.	Import esx_journaliste.sql in your database

3.	Add this in your server.cfg :

> start esx_journaliste

If you want player management you have to set Config.EnablePlayerManagement to true in config.lua You can config VaultManagement with true/false (don't forget to comment the area in the same file)

###### FEATURES

- Reporter job
- Boss, Investigator, Reporter and Trainee grades
- Cloakroom, Vault, Vehicles, BossActions
- Cloakroom : Different outfits limited to the equivalent or higher grade
- Spawning car without dust
- Billing menu
