USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
  ('society_ammunation','Ammunation',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_ammunation','Ammunation',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('society_ammunation','Ammunation',1)
;

INSERT INTO `jobs` (name, label) VALUES
  ('ammunation','Ammunation')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('ammunation',0,'stagiaire','Stagiaire',12,'{}','{}'),
  ('ammunation',1,'employé','Employé',36,'{}','{}'),
  ('ammunation',2,'professionnel','Professionnel',48,'{}','{}'),
  ('ammunation',3,'second','Second',48,'{}','{}'),
  ('ammunation',4,'boss','Patron',0,'{}','{}')
;

INSERT INTO `items` (`name`, `label`) VALUES
	('carbon', 'Carbone'),
	('acier', 'Acier'),
	('poudre', 'Boite de poudre'),
	('douille', 'Boite de douille')
;
