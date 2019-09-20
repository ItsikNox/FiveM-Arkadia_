SET @job_name = 'Bahama';
SET @society_name = 'society_bahama';
SET @job_Name_Caps = 'Bahama';



INSERT INTO `addon_account` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1),
  ('society_bahama_fridge', 'Bahama (fridge)', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
  (@job_name, @job_Name_Caps, 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  (@job_name, 0, 'barman', 'Bartender', 300, '{}', '{}'),
  (@job_name, 1, 'dancer', 'Dancer', 300, '{}', '{}'),
  (@job_name, 2, 'viceboss', 'Co-Manager', 500, '{}', '{}'),
  (@job_name, 3, 'boss', 'Manager', 600, '{}', '{}')
;

INSERT INTO `items` (`name`, `label`, `limit`) VALUES  
    ('jager', 'Jägermeister', 5),
    ('vodka', 'Vodka', 5),
    ('rhum', 'Rhum', 5),
    ('whisky', 'Whisky', 5),
    ('tequila', 'Tequila', 5),
    ('martini', 'White Martini', 5),
    ('soda', 'Soda', 5),
    ('jusfruit', 'Fruit juice', 5),
    ('icetea', 'Ice Tea', 5),
    ('energy', 'Energy Drink', 5),
    ('drpepper', 'Dr. Pepper', 5),
    ('limonade', 'Lemonade', 5),
    ('bolcacahuetes', 'Bowl of peanuts', 5),
    ('bolnoixcajou', 'Bowl of cashew nuts', 5),
    ('bolpistache', 'Bowl of pistachios', 5),
    ('bolchips', 'Bowl of crisps', 5),
    ('saucisson', 'Sausage', 5),
    ('grapperaisin', 'Bunch of grapes', 5),
    ('jagerbomb', 'Jägerbomb', 5),
    ('golem', 'Golem', 5),
    ('whiskycoca', 'Whisky-coke', 5),
    ('vodkaenergy', 'Vodka-energy', 5),
    ('vodkafruit', 'Vodka-fruit juice', 5),
    ('rhumfruit', 'Rhum-fruit juice', 5),
    ('teqpaf', "Teq'paf", 5),
    ('rhumcoca', 'Rhum-coke', 5),
    ('mojito', 'Mojito', 5),
    ('ice', 'Ice', 5),
    ('mixapero', 'Aperitif Mix', 3),
    ('metreshooter', 'Shooter meter', 3),
    ('jagercerbere', 'Jäger Cerberus', 3),
    ('menthe', 'Mint leaf', 10)
;
