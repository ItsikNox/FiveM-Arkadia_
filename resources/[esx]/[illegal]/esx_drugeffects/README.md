# esx_drugeffects
Modifided version of esx_optionalneeds from @indilo53

[REQUIREMENTS]

* esx_status https://github.com/FXServer-ESX/fxserver-esx_status

* esx_drugs https://github.com/ESX-Org/esx_drugs <- Original

* Remove lines esx_drugs_cl.lua and esx_drugs_sv.lua That gives weed efect 

[INSTALLATION]

1) CD in your resources/[esx] folder
2) Clone the repository
```
git clone https://github.com/Ferreira312/esx_drugeffects/ esx_drugeffects
```
3) Import esx_drugeffects.sql in your database

4) Add this in your server.cfg :
```
start esx_drugeffects
```

[FEATURES]

Adds the option to use drugs that adds effects ex. speed, damage reduction, health recharge.

This was made so you could buy or sell and have some reason to do it.

* Weed -> Run Faster
* Opium -> Swim faster
* Meth -> Heal 20%
* Coke -> Heal 30% + Armour

In the future will be added more benneficts
