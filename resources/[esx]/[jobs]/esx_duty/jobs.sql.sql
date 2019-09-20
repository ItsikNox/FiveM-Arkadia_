INSERT INTO `jobs` (name, label) VALUES
  ('offpolice','Pas en Service'),
  ('offambulance','Pas en Service')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('offpolice',0,'recruit','Cadet',400,'{}','{}'),
  ('offpolice',1,'officer','Officier',500,'{}','{}'),
  ('offpolice',2,'sergeant','Sergeant',600,'{}','{}'),
  ('offpolice',3,'intendant','	Sergent-Chef',700,'{}','{}'),
  ('offpolice',4,'lieutenant','Lieutenant',800,'{}','{}'),
  ('offpolice',5,'chef','Capitaine',900,'{}','{}'),
  ('offpolice',6,'boss','Commandant',1000,'{}','{}'),
  ('offpolice',7,'bac','BAC',900,'{}','{}'),
  ('offambulance',0,'ambulance','Ambulancier',200,'{}','{}'),
  ('offambulance',1,'doctor','Médecin',400,'{}','{}'),
  ('offambulance',2,'chief_doctor','Médecin-Chef',600,'{}','{}'),
  ('offambulance',3,'boss','Patron',800,'{}','{}')
;