# esx_duty

[REQUIREMENTS]
  
* ESX Jobs Support
  * esx_policejob => https://github.com/ESX-Org/esx_policejob
  * esx_ambulancejob => https://github.com/ESX-Org/esx_ambulancejob
  * pNotify => https://github.com/Nick78111/pNotify
  
[INSTALLATION]

1) CD in your resources/[esx] folder

2) Import ``jobs.sql`` in your database

3) Add this in your server.cfg :
``start esx_duty``

lua