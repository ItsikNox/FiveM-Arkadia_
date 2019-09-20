INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_tabac','Tabac',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_tabac','Tabac',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_tabac', 'Tabac', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('tabac', 'Tabac', 1);

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('tabac',0,'recrue','Tabagiste',400,'{}','{}'),
  ('tabac',1,'gerant','Gérant',650,'{}','{}'),
  ('tabac',2,'boss','Patron',800,'{}','{}');

INSERT INTO `items` (name, label) VALUES
  ('tabacblond', 'Tabac Blond'),
  ('tabacbrun', 'Tabac Brun'),
  ('tabacblondsec', 'Tabac Blond Séché'),
  ('tabacbrunsec', 'Tabac Brun Séché'),
  ('malbora', 'Malbora'),
  ('gitanes', 'Gitanes');
