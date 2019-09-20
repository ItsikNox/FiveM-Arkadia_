INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_state','State',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_state','State',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_state', 'State', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('state', 'State', 1);

--
-- Déchargement des données de la table `jobs_grades`
--

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('state', 0, 'vicepresident', 'Intérimaire', 950, '{}', '{}'),
('state', 3, 'president', 'Président', 1500, '{}', '{}'),
('state', 2, 'gouvernment', 'Vise-Président', 1250, '{}', '{}'),
('state', 1, 'boss', 'Garde du Corps', 1000, '{}', '{}');