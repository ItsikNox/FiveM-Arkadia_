Drill machine made for bank robberies. This is just an item.
Credits goes to github @ johanwulf for using his line of code.

DalarnaRP.se

1. Upload it to resources/[esx] folder.
2. Add esx_borrmaskin to server.cfg
3. Create "drill" in items table.

```
INSERT INTO `items` (`name`, `label`, `limit`) VALUES  
    ('drill', 'Borrmaskin', 1)
;
```

If you want it added to ESX Shops. Execute this SQL.

```
INSERT INTO `shops` (name, item, price) VALUES
	('TwentyFourSeven','drill',1000),
	('RobsLiquor','drill',1000),
	('LTDgasoline','drill',1000)
;

```
