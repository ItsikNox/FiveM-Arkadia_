SET @job_name = 'bahama';
SET @society_name = 'society_bahama';
SET @job_Name_Caps = 'bahama';



INSERT INTO `addon_account` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1),
  ('society_bahama_fridge', 'bahama (frigo)', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
  (@job_name, @job_Name_Caps, 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  (@job_name, 0, 'barman', 'Barman', 300, '{}', '{}'),
  (@job_name, 1, 'dj', 'DJ', 300, '{}', '{}'),
  (@job_name, 2, 'secu', 'Sécurité', 300, '{}', '{}'),
  (@job_name, 3, 'viceboss', 'Co-gérant', 500, '{}', '{}'),
  (@job_name, 4, 'boss', 'Gérant', 600, '{}', '{}')
;

INSERT INTO `items` (`name`, `label`, `limit`) VALUES  
    ('jager', 'Jägermeister', 5),
    ('coffee', 'Café', 5),
    ('vodka', 'Vodka', 5),
    ('rhum', 'Rhum', 5),
    ('whisky', 'Whisky', 5),
    ('tequila', 'Tequila', 5),
    ('martini', 'Martini blanc', 5),
    ('soda', 'Soda', 5),
    ('jusfruit', 'Jus de fruits', 5),
    ('icetea', 'Ice Tea', 5),
    ('energy', 'Energy Drink', 5),
    ('drpepper', 'Dr. Pepper', 5),
    ('limonade', 'Limonade', 5),
    ('bolcacahuetes', 'Bol de cacahuètes', 5),
    ('bolnoixcajou', 'Bol de noix de cajou', 5),
    ('bolpistache', 'Bol de pistaches', 5),
    ('bolchips', 'Bol de chips', 5),
    ('saucisson', 'Saucisson', 5),
    ('grapperaisin', 'Grappe de raisin', 5),
    ('jagerbomb', 'Jägerbomb', 5),
    ('golem', 'Golem', 5),
    ('whiskycoca', 'Whisky-coca', 5),
    ('vodkaenergy', 'Vodka-energy', 5),
    ('vodkafruit', 'Vodka-jus de fruits', 5),
    ('rhumfruit', 'Rhum-jus de fruits', 5),
    ('teqpaf', "Teq'paf", 5),
    ('rhumcoca', 'Rhum-coca', 5),
    ('mojito', 'Mojito', 5),
    ('ice', 'Glaçon', 5),
    ('mixapero', 'Mix Apéritif', 3),
    ('metreshooter', 'Mètre de shooter', 3),
    ('jagercerbere', 'Jäger Cerbère', 3),
    ('menthe', 'Feuille de menthe', 10)
;
