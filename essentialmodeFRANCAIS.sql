-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  Dim 25 août 2019 à 05:14
-- Version du serveur :  5.7.26
-- Version de PHP :  7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `essentialmode`
--

-- --------------------------------------------------------

--
-- Structure de la table `addon_account`
--

DROP TABLE IF EXISTS `addon_account`;
CREATE TABLE IF NOT EXISTS `addon_account` (
  `name` varchar(60) NOT NULL,
  `label` varchar(255) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `addon_account`
--

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('bank_savings', 'Livret Bleu', 0),
('caution', 'Caution', 0),
('property_black_money', 'Argent Sale Propriété', 0),
('society_aircraftdealer', 'Airliner', 1),
('society_ambulance', 'Ambulance', 1),
('society_ammu', 'ammu', 1),
('society_avocat', 'Avocat', 1),
('society_bahama', 'Bahama Mas', 1),
('society_baladins', 'baladins', 1),
('society_ballas', 'Ballas', 1),
('society_ballas_black', 'ballas black', 1),
('society_banker', 'Banque', 1),
('society_boatdealer', 'Marina', 1),
('society_bratva', 'Bratva', 1),
('society_bratva_black', 'bratva black', 1),
('society_cardealer', 'Concessionnaire', 1),
('society_cartel', 'Cartel', 1),
('society_casino', 'Casino', 1),
('society_dock', 'Marina', 1),
('society_famillies', 'Famillies', 1),
('society_famillies_black', 'famillies black', 1),
('society_fib', 'Fib', 1),
('society_fueler', 'Raffineur', 1),
('society_illegal', 'Illegal', 1),
('society_illegal_black', 'illegal black', 1),
('society_immo', 'Immo', 1),
('society_journaliste', 'journaliste', 1),
('society_kano', 'Kano', 1),
('society_kano_black', 'kano black', 1),
('society_lazone', 'lazone', 1),
('society_lazone_black', 'lazone black', 1),
('society_mafia', 'Mafia', 1),
('society_mecano', 'Mécano', 1),
('society_mercenaire', 'mercenaire', 1),
('society_mercenaire_black', 'mercenaire black', 1),
('society_ms13', 'ms13', 1),
('society_ms13_black', 'ms13 black', 1),
('society_nightclub', 'Nightclub', 1),
('society_pecheur', 'Pecheur', 1),
('society_podolskaia', 'podolskaia', 1),
('society_podolskaia_black', 'podolskaia black', 1),
('society_police', 'Police', 1),
('society_pompiste', 'Pompiste', 1),
('society_realestateagent', 'Agent immobilier', 1),
('society_securoserv', 'SecuroServ', 1),
('society_state', 'State', 1),
('society_syndicat', 'syndicat', 1),
('society_syndicat_black', 'syndicat black', 1),
('society_tabac', 'Tabac', 1),
('society_taxi', 'Taxi', 1),
('society_unicorn', 'Unicorn', 1),
('society_vagos', 'Vagos', 1),
('society_vagos_black', 'vagos black', 1),
('society_vigne', 'Vigneron', 1);

-- --------------------------------------------------------

--
-- Structure de la table `user_inventory`
--

DROP TABLE IF EXISTS `user_inventory`;
CREATE TABLE IF NOT EXISTS `user_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=186292 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `addon_account_data`
--

DROP TABLE IF EXISTS `addon_account_data`;
CREATE TABLE IF NOT EXISTS `addon_account_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_name` varchar(255) DEFAULT NULL,
  `money` double NOT NULL,
  `owner` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1358 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `addon_inventory`
--

DROP TABLE IF EXISTS `addon_inventory`;
CREATE TABLE IF NOT EXISTS `addon_inventory` (
  `name` varchar(60) NOT NULL,
  `label` varchar(255) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `addon_inventory`
--

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('organisation_biker', 'Biker', 1),
('organisation_cartel', 'Cartel', 1),
('organisation_gang', 'Gang', 1),
('organisation_mafia', 'Mafia', 1),
('property', 'Propriété', 0),
('society_aircraftdealer', 'Airliner', 1),
('society_ambulance', 'Ambulance', 1),
('society_ammu', 'Ammu', 1),
('society_avocat', 'Avocat', 1),
('society_bahama', 'Bahama Mas', 1),
('society_bahama_fridge', 'bahama (frigo)', 1),
('society_ballas', 'Ballas', 1),
('society_boatdealer', 'Marina', 1),
('society_bratva', 'Bratva', 1),
('society_cardealer', 'Concesionnaire', 1),
('society_casino', 'Casino', 1),
('society_casino_fridge', 'Casino (Frigo)', 1),
('society_dock', 'Marina', 1),
('society_famillies', 'Famillies', 1),
('society_fib', 'Fib', 1),
('society_fueler', 'Raffineur', 1),
('society_fueler1', 'Gold Luxuary', 1),
('society_illegal', 'Illegal', 1),
('society_immo', 'Immo', 1),
('society_journaliste', 'journaliste', 1),
('society_kano', 'Kano', 1),
('society_lazone', 'lazone', 1),
('society_mecano', 'Mécano', 1),
('society_mercenaire', 'mercenaire', 1),
('society_moto', 'Moto', 1),
('society_moto_fridge', 'Moto (fridge)', 1),
('society_ms13', 'ms13', 1),
('society_nightclub', 'Nightclub', 1),
('society_nightclub_fridge', 'Nightclub (frigo)', 1),
('society_orjob', 'Gold Luxury', 1),
('society_pecheur', 'Pecheur', 1),
('society_podolskaia', 'podolskaia', 1),
('society_police', 'Police', 1),
('society_police1', 'PoliceInv', 1),
('society_pompiste', 'Pompiste', 1),
('society_securoserv', 'SecuroServ', 1),
('society_state', 'State', 1),
('society_syndicat', 'syndicat', 1),
('society_tabac', 'Tabac', 1),
('society_taxi', 'Taxi', 1),
('society_unicorn', 'Unicorn', 1),
('society_unicorn_fridge', 'Unicorn (frigo)', 1),
('society_vagos', 'Vagos', 1),
('society_vigne', 'Vigneron', 1);

--------------------------------------------------------

--
-- Structure de la table `addon_inventory_items`
--

DROP TABLE IF EXISTS `addon_inventory_items`;
CREATE TABLE IF NOT EXISTS `addon_inventory_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inventory_name` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `aircraftdealer_aircrafts`
--

DROP TABLE IF EXISTS `aircraftdealer_aircrafts`;
CREATE TABLE IF NOT EXISTS `aircraftdealer_aircrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `aircrafts`
--

DROP TABLE IF EXISTS `aircrafts`;
CREATE TABLE IF NOT EXISTS `aircrafts` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`model`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `aircrafts`
--

INSERT INTO `aircrafts` (`name`, `model`, `price`, `category`) VALUES
('Alpha Z1', 'alphaz1', 1121000, 'plane'),
('Besra', 'besra', 1000000, 'plane'),
('Cuban 800', 'cuban800', 240000, 'plane'),
('Dodo', 'dodo', 500000, 'plane'),
('Duster', 'duster', 175000, 'plane'),
('Howard NX25', 'howard', 975000, 'plane'),
('Luxor', 'luxor', 1500000, 'plane'),
('Luxor Deluxe ', 'luxor2', 1750000, 'plane'),
('Mallard', 'stunt', 250000, 'plane'),
('Mammatus', 'mammatus', 300000, 'plane'),
('Nimbus', 'nimbus', 900000, 'plane'),
('Rogue', 'rogue', 1000000, 'plane'),
('Sea Breeze', 'seabreeze', 850000, 'plane'),
('Shamal', 'shamal', 1150000, 'plane'),
('Ultra Light', 'microlight', 50000, 'plane'),
('Velum', 'velum2', 450000, 'plane'),
('Vestra', 'vestra', 950000, 'plane'),
('Buzzard', 'buzzard2', 500000, 'heli'),
('Frogger', 'frogger', 800000, 'heli'),
('Havok', 'havok', 250000, 'heli'),
('Maverick', 'maverick', 750000, 'heli'),
('Sea Sparrow', 'seasparrow', 815000, 'heli'),
('SuperVolito', 'supervolito', 1000000, 'heli'),
('SuperVolito Carbon', 'supervolito2', 1250000, 'heli'),
('Swift', 'swift', 1000000, 'heli'),
('Swift Deluxe', 'swift2', 1250000, 'heli'),
('Volatus', 'volatus', 1250000, 'heli');

-- --------------------------------------------------------

--
-- Structure de la table `aircraft_categories`
--

DROP TABLE IF EXISTS `aircraft_categories`;
CREATE TABLE IF NOT EXISTS `aircraft_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `aircraft_categories`
--

INSERT INTO `aircraft_categories` (`name`, `label`) VALUES
('plane', 'Planes'),
('heli', 'Helicopters');

-- --------------------------------------------------------

--
-- Structure de la table `baninfo`
--


DROP TABLE IF EXISTS `baninfo`;
CREATE TABLE IF NOT EXISTS `baninfo` (
  `id` int(11) AUTO_INCREMENT PRIMARY KEY,
  `identifier` varchar(25) COLLATE utf8mb4_bin DEFAULT "no info",
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT "no info",
  `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT "no info",
  `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT "no info",
  `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT "no info",
  `playerip` varchar(25) COLLATE utf8mb4_bin DEFAULT "0.0.0.0",
  `playername` varchar(32) COLLATE utf8mb4_bin DEFAULT "no info"
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `banlist`
--

DROP TABLE IF EXISTS `banlist`;
CREATE TABLE IF NOT EXISTS `banlist` (
  `identifier` varchar(25) COLLATE utf8mb4_bin PRIMARY KEY,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `playerip` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `targetplayername` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `sourceplayername` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `reason` varchar(255) NOT NULL,
  `timeat` varchar(50) NOT NULL,
  `expiration` varchar(50) NOT NULL,
  `permanent` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `banlisthistory`
--

DROP TABLE IF EXISTS `banlisthistory`;
CREATE TABLE IF NOT EXISTS `banlisthistory` (
  `id` int(11) AUTO_INCREMENT PRIMARY KEY,
  `identifier` varchar(25) NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `playerip` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `targetplayername` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `sourceplayername` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `reason` varchar(255) NOT NULL,
  `timeat` int(11) NOT NULL,
  `added` varchar(40) NOT NULL,
  `expiration` int(11) NOT NULL,
  `permanent` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `billing`
--

DROP TABLE IF EXISTS `billing`;
CREATE TABLE IF NOT EXISTS `billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4509 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `boatdealer_boats`
--

DROP TABLE IF EXISTS `boatdealer_boats`;
CREATE TABLE IF NOT EXISTS `boatdealer_boats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `boats`
--

DROP TABLE IF EXISTS `boats`;
CREATE TABLE IF NOT EXISTS `boats` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`model`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `boats`
--

INSERT INTO `boats` (`name`, `model`, `price`, `category`) VALUES
('Seashark', 'seashark', 245000, 'boat'),
('Seashark2', 'seashark2', 255000, 'boat'),
('Yacht Seashark', 'seashark3', 260000, 'boat'),
('Suntrap', 'suntrap', 2210500, 'boat'),
('Dinghy', 'dinghy', 3652500, 'boat'),
('Dinghy2 ', 'dinghy2', 3735500, 'boat'),
('Yacht Dinghy', 'dinghy4', 3841500, 'boat'),
('Tropic', 'tropic', 2260000, 'boat'),
('Yacht Tropic', 'tropic2', 2310000, 'boat'),
('Squalo', 'squalo', 2412000, 'boat'),
('Yacht Toro', 'toro2', 2718000, 'boat'),
('Toro', 'toro', 2815000, 'boat'),
('Jetmax', 'jetmax', 3900000, 'boat'),
('Voilier Marquis', 'marquis', 2375000, 'boat');

-- --------------------------------------------------------

--
-- Structure de la table `boat_categories`
--

DROP TABLE IF EXISTS `boat_categories`;
CREATE TABLE IF NOT EXISTS `boat_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `boat_categories`
--

INSERT INTO `boat_categories` (`name`, `label`) VALUES
('boat', 'Boats');

-- --------------------------------------------------------

--
-- Structure de la table `cardealer_vehicles`
--

DROP TABLE IF EXISTS `cardealer_vehicles`;
CREATE TABLE IF NOT EXISTS `cardealer_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `characters`
--

DROP TABLE IF EXISTS `characters`;
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `dateofbirth` varchar(255) NOT NULL,
  `sex` varchar(1) NOT NULL DEFAULT 'M',
  `height` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1043 DEFAULT CHARSET=latin1;

--
-- Structure de la table `datastore`
--

DROP TABLE IF EXISTS `datastore`;
CREATE TABLE IF NOT EXISTS `datastore` (
  `name` varchar(60) NOT NULL,
  `label` varchar(255) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `datastore`
--

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('property', 'Propriété', 0),
('society_ambulance', 'Ambulance', 1),
('society_ammu', 'Ammu', 1),
('society_avocat', 'Avocat', 1),
('society_baladins', 'baladins', 1),
('society_ballas', 'Ballas', 1),
('society_ballas_weapons', 'ballas weapon', 1),
('society_biker', 'Biker', 1),
('society_bratva', 'Bratva', 1),
('society_bratva_weapons', 'bratva weapon', 1),
('society_cartel', 'Cartel', 1),
('society_casino', 'Casino', 1),
('society_famillies', 'famillies', 1),
('society_famillies_weapons', 'famillies weapon', 1),
('society_fib', 'Fib', 1),
('society_fueler', 'Raffineur', 1),
('society_gang', 'Gang', 1),
('society_illegal', 'Illegal', 1),
('society_illegal_weapons', 'illegal weapon', 1),
('society_immo', 'Immo', 1),
('society_journaliste', 'journaliste', 1),
('society_kano', 'Kano', 1),
('society_kano_weapons', 'kano weapon', 1),
('society_lazone', 'LaZone', 1),
('society_lazone_weapons', 'lazone weapon', 1),
('society_mafia', 'Mafia', 1),
('society_mercenaire', 'mercenaire', 1),
('society_mercenaire_weapons', 'mercenaire Weapon', 1),
('society_ms13', 'ms13 Weapon', 1),
('society_ms13_weapons', 'ms13 weapon', 1),
('society_nightclub', 'Nightclub', 1),
('society_pecheur', 'Pecheur', 1),
('society_podolskaia', 'podolskaia', 1),
('society_podolskaia_weapons', 'podolskaia Weapon', 1),
('society_police', 'Police', 1),
('society_pompiste', 'Pompiste', 1),
('society_securoserv', 'SecuroServ', 1),
('society_state', 'State', 1),
('society_syndicat', 'syndicat', 1),
('society_syndicat_weapons', 'syndicat Weapon', 1),
('society_tabac', 'Tabac', 1),
('society_taxi', 'Taxi', 1),
('society_unicorn', 'Unicorn', 1),
('society_vagos', 'Vagos', 1),
('society_vagos_weapons', 'Vagos Weapon', 1),
('society_vigne', 'Vigneron', 1),
('user_ears', 'Ears', 0),
('user_glasses', 'Glasses', 0),
('user_helmet', 'Helmet', 0),
('user_mask', 'Mask', 0);

-- --------------------------------------------------------

--
-- Structure de la table `datastore_data`
--

DROP TABLE IF EXISTS `datastore_data`;
CREATE TABLE IF NOT EXISTS `datastore_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `data` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1786 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `dock`
--

DROP TABLE IF EXISTS `dock`;
CREATE TABLE IF NOT EXISTS `dock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `dock`
--

INSERT INTO `dock` (`id`, `name`, `model`, `price`, `category`) VALUES
(1, 'Seashark', 'seashark', 245000, 'dock'),
(2, 'Seashark2', 'seashark2', 255000, 'dock'),
(3, 'Yacht Seashark', 'seashark3', 260000, 'dock'),
(4, 'Suntrap', 'suntrap', 2210500, 'dock'),
(5, 'Dinghy', 'dinghy', 3652500, 'dock'),
(6, 'Dinghy2 ', 'dinghy2', 3735500, 'dock'),
(7, 'Yacht Dinghy', 'dinghy4', 3841500, 'dock'),
(8, 'Tropic', 'tropic', 2260000, 'dock'),
(9, 'Yacht Tropic', 'tropic2', 2310000, 'dock'),
(10, 'Squalo', 'squalo', 2412000, 'dock'),
(11, 'Yacht Toro', 'toro2', 2718000, 'dock'),
(12, 'Toro', 'toro', 2815000, 'dock'),
(13, 'Jetmax', 'jetmax', 3900000, 'dock'),
(14, 'Voilier Marquis', 'marquis', 2375000, 'dock');

-- --------------------------------------------------------

--
-- Structure de la table `dock_categories`
--

DROP TABLE IF EXISTS `dock_categories`;
CREATE TABLE IF NOT EXISTS `dock_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `dock_categories`
--

INSERT INTO `dock_categories` (`id`, `name`, `label`) VALUES
(1, 'dock', 'Bateaux');

-- --------------------------------------------------------

--
-- Structure de la table `dock_vehicles`
--

DROP TABLE IF EXISTS `dock_vehicles`;
CREATE TABLE IF NOT EXISTS `dock_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `fine_types`
--

DROP TABLE IF EXISTS `fine_types`;
CREATE TABLE IF NOT EXISTS `fine_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `fine_types`
--

INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
(1, 'Usage abusif du klaxon', 300, 0),
(2, 'Franchir une ligne continue', 300, 0),
(3, 'Circulation à contresens', 1500, 0),
(4, 'Demi-tour non autorisé', 1000, 0),
(5, 'Circulation hors-route', 1200, 0),
(6, 'Non-respect des distances de sécurité', 1100, 0),
(7, 'Arrêt dangereux / interdit', 1000, 0),
(8, 'Stationnement gênant / interdit', 500, 0),
(9, 'Non respect de la priorité à droite', 1000, 0),
(10, 'Non-respect à un véhicule prioritaire', 1500, 0),
(11, 'Non-respect d\'un stop', 1200, 0),
(12, 'Non-respect d\'un feu rouge', 1500, 0),
(13, 'Dépassement dangereux', 3000, 0),
(14, 'Véhicule non en état', 5000, 0),
(15, 'Conduite sans permis', 10000, 0),
(16, 'Délit de fuite', 20000, 0),
(17, 'Excès de vitesse - 5 kmh', 500, 0),
(18, 'Excès de vitesse + 5-15 kmh', 1000, 0),
(19, 'Excès de vitesse + 15-30 kmh', 2000, 0),
(20, 'Excès de vitesse + 30 kmh', 5000, 0),
(21, 'Entrave de la circulation', 1000, 1),
(22, 'Dégradation de la voie publique', 1000, 1),
(23, 'Trouble à l\'ordre publique', 2000, 1),
(24, 'Entrave opération de police', 12000, 1),
(25, 'Insulte envers / entre civils', 4000, 1),
(26, 'Outrage à agent de police', 18000, 1),
(27, 'Menace verbale ou intimidation envers civil', 20000, 1),
(28, 'Menace verbale ou intimidation envers agent de police', 34000, 1),
(29, 'Manifestation illégale', 15000, 1),
(30, 'Tentative de corruption', 40000, 1),
(31, 'Arme blanche sortie en ville', 5000, 2),
(32, 'Arme léthale sortie en ville', 15000, 2),
(33, 'License PPA', 20000, 2),
(34, 'Port d\'arme illégal', 50000, 2),
(35, 'Carjacking', 10000, 2),
(36, 'Vol de véhicule', 20000, 2),
(37, 'Vente de drogue', 30000, 2),
(38, 'Fabrication de drogue', 60000, 2),
(39, 'Possession de drogue < 100', 30000, 2),
(40, 'Prise d\'otage civil', 50000, 2),
(41, 'Prise d\'otage agent de l\'état', 100000, 2),
(42, 'Braquage particulier', 10000, 3),
(43, 'Braquage magasin', 50000, 3),
(44, 'Braquage de banque', 85000, 3),
(45, 'Tir sur civil', 50000, 3),
(46, 'Tir sur agent de l\'état', 80000, 3),
(47, 'Tentative de meurtre sur civil', 40000, 3),
(48, 'Tentative de meurtre sur agent de l\'état', 150000, 3),
(49, 'Meurtre sur civil', 200000, 3),
(50, 'Meurtre sur agent de l\'état', 300000, 3),
(51, 'Meurtre involontaire', 100000, 3),
(53, 'Achat d\'armes illégal\r\n', 200000, 3),
(54, 'Port d\'arme sans PPA', 80000, 2),
(55, 'Escroquerie à l\'entreprise\r\n', 50000, 3),
(56, 'Excès de vitesse + 50kmh + retrait de permis', 10000, 0),
(58, 'Menace de mort envers civils', 50000, 2),
(59, 'Menace de mort envers agent de l\'état', 75000, 2),
(60, 'Possession de drogue > 100', 20000, 2);

-- --------------------------------------------------------

--
-- Structure de la table `items`
--

DROP TABLE IF EXISTS `items`;
CREATE TABLE IF NOT EXISTS `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `limit` int(11) NOT NULL DEFAULT '-1',
  `rare` int(11) NOT NULL DEFAULT '0',
  `can_remove` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `items`
--

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
('acier', 'Acier', -1, 0, 1),
('adrenaline', 'Adrénaline', 15, 0, 1),
('alcool', '🍺 Alcool', 150, 0, 1),
('alcool_cargo', '🍺 Cargaison d\'Alcool', 150, 0, 1),
('alive_chicken', '🍗 Poulet vivant', 150, 0, 1),
('arAmmo', 'Boite Munition Fusil Assaut', 5, 0, 1),
('bag', 'Sac de Sport', 1, 0, 1),
('bandage', 'Bandage', 15, 0, 1),
('beef', '🥩 Morceau de Boeuf', 15, 0, 1),
('beer', '🍺 Bière', -1, 0, 1),
('billet', '🛢️ Bidon d\'Essence', 150, 0, 1),
('blowpipe', 'Chalumeaux', 10, 0, 1),
('blowtorch', 'Chalumeau', 1, 0, 1),
('bolcacahuetes', '🥜 Bol de cacahuètes', 15, 0, 1),
('bolchips', '🥜 Bol de chips', 15, 0, 1),
('bolnoixcajou', '🥜 Bol de noix de cajou', 15, 0, 1),
('bolpistache', '🥜 Bol de pistaches', 15, 0, 1),
('bread', '🥖 Pain', 15, 0, 1),
('lighter', 'Briquet', 15, 0, 1),
('cigarett', 'Cigarette', 15, 0, 1),
('breadsaucisson', '🌭 HotDog', 15, 0, 1),
('c4_bank', 'C4 de 10 kilos', 1, 0, 1),
('cagoule', 'Cagoule', 5, 0, 1),
('carbon', 'Carbone', -1, 0, 1),
('carokit', '🔧 Kit carosserie', 3, 0, 1),
('carotool', '🔧 outils carosserie', 4, 0, 1),
('chocolat', '🍫 Barre de chocolat', 15, 0, 1),
('clip', 'Chargeur', 15, 0, 1),
('clothe', '👔 Vêtement', 150, 0, 1),
('cocacola', 'Canette de Coca-Cola', 15, 0, 1),
('coffee', '☕ Café', 15, 0, 1),
('coke', '💊 Coke', 100, 0, 1),
('coke_pooch', '💊 Pochon de coke', 100, 0, 1),
('COMPONENT_AT_AR_AFGRIP', '[acc] Poignée (Fusils)', 5, 0, 1),
('COMPONENT_AT_AR_CLIP_02', '[acc] Magasin étendu (Fusils)', 5, 0, 1),
('COMPONENT_AT_AR_CLIP_03', '[acc] Magasin très étendu (Fusils)', 5, 0, 1),
('COMPONENT_AT_AR_FLSH', '[acc] Lampe torche (Fusils)', 5, 0, 1),
('COMPONENT_AT_AR_SUPP_02', '[acc] Silencieux (Fusils)', 5, 0, 1),
('COMPONENT_AT_PI_CLIP_02', '[acc] Magasin étendu (Pistolets)', 5, 0, 1),
('COMPONENT_AT_PI_FLSH', '[acc] Lampe torche (Pistolets)', 5, 0, 1),
('COMPONENT_AT_PI_SUPP', '[acc] Silencieux (Pistolets)', 5, 0, 1),
('COMPONENT_AT_SCOPE_MACRO', '[acc] Lunette (Fusils)', 5, 0, 1),
('COMPONENT_KNUCKLE_VARMOD_BALLAS', '[skin] Poing américain - Ballas', 5, 0, 1),
('COMPONENT_KNUCKLE_VARMOD_DIAMOND', '[skin] Poing américain - Diamant', 5, 0, 1),
('COMPONENT_KNUCKLE_VARMOD_DOLLAR', '[skin] Poing américain - Dollar', 5, 0, 1),
('COMPONENT_KNUCKLE_VARMOD_HATE', '[skin] Poing américain - Haine', 5, 0, 1),
('COMPONENT_KNUCKLE_VARMOD_KING', '[skin] Poing américain - King', 5, 0, 1),
('COMPONENT_KNUCKLE_VARMOD_LOVE', '[skin] Poing américain - Amour', 5, 0, 1),
('COMPONENT_KNUCKLE_VARMOD_PIMP', '[skin] Poing américain - Pimp', 5, 0, 1),
('COMPONENT_KNUCKLE_VARMOD_PLAYER', '[skin] Poing américain - Joueur', 5, 0, 1),
('COMPONENT_KNUCKLE_VARMOD_VAGOS', '[skin] Poing américain - Vagos', 5, 0, 1),
('COMPONENT_REVOLVER_VARMOD_BOSS', '[skin] Revolver - Boss', 5, 0, 1),
('COMPONENT_REVOLVER_VARMOD_GOON', '[skin] Revolver - Voyou', 5, 0, 1),
('COMPONENT_SWITCHBLADE_VARMOD_VAR1', '[skin] Couteau à cran d\'arrêt - VIP', 5, 0, 1),
('COMPONENT_SWITCHBLADE_VARMOD_VAR2', '[skin] Couteau à cran d\'arrêt - Bois', 5, 0, 1),
('COMPONENT_VARMOD_LOWRIDER', '[skin] Finition - Lowrider', 5, 0, 1),
('COMPONENT_VARMOD_LUXE', '[skin] Finition - Luxe', 5, 0, 1),
('copper', 'Cuivre', 56, 0, 1),
('croquettes', 'Croquettes', -1, 0, 1),
('cryptedphone', 'Téléphone Crypté', 25, 0, 1),
('cupcake', '🧁 CupCake', 15, 0, 1),
('cutted_wood', '🌳 Bois coupé', 150, 0, 1),
('diamond', '💎 Diamant', 5, 0, 1),
('doliprane', 'Doliprane', 15, 0, 1),
('douille', 'Boite de douille', -1, 0, 1),
('drill', 'Perceuse (Banque)', 1, 0, 1),
('drpepper', 'Dr. Pepper', 5, 0, 1),
('energy', 'Energy Drink', 5, 0, 1),
('essence', '⛽ Essence', 150, 0, 1),
('essence1', '🥃 Whiskey', 150, 0, 1),
('fabric', '🧶 Tissu', 150, 0, 1),
('fish', '🐟 Poisson', 150, 0, 1),
('fishbait', 'Appât à Poisson', 30, 0, 1),
('fishingknife', 'Couteau de pêche', 1, 0, 1),
('fishingrod', 'Canne à pêche', 2, 0, 1),
('fish_traiter', 'Poisson Découpé', 150, 0, 1),
('fixkit', '🔧 Kit réparation', 5, 0, 1),
('fixtool', 'outils réparation', 6, 0, 1),
('flashlight', '🔦 Lampe', 5, 0, 1),
('gazbottle', 'bouteille de gaz', 11, 0, 1),
('gitanes', '🚬 Gitanes', 150, 0, 1),
('gold', 'Or', 21, 0, 1),
('golem', 'Golem', 5, 0, 1),
('grand_cru', '🍾 Grand Cru', 150, 0, 1),
('grapperaisin', '🍇 Grappe de raisin', 150, 0, 1),
('grip', 'Poignée', 15, 0, 1),
('gym_membership', 'Carte d\'Adhésion', 1, 0, 1),
('hamburger', '🍔 Hamburger', 15, 0, 1),
('hamburgerplate', '🍔 Hamburger aux boulettes de viande', 15, 0, 1),
('headbag', 'Cagoule', 5, 0, 1),
('HeavyArmor', 'Gilet par balle Lourd', 3, 0, 1),
('HeavyArmour', 'Gilet Lourd', 1, 0, 1),
('ice', 'Glaçon', 15, 0, 1),
('icetea', 'Ice Tea', 15, 0, 1),
('iron', 'Fer', 42, 0, 1),
('jager', 'Jägermeister', 5, 0, 1),
('jagerbomb', 'Jägerbomb', 5, 0, 1),
('jagercerbere', 'Jäger Cerbère', 3, 0, 1),
('jewels', '💎 Bijoux', -1, 0, 1),
('jusfruit', '🍇 Jus de fruits', 150, 0, 1),
('jus_raisin', '🍇 Jus de Raisin', 150, 0, 1),
('keycard', 'Keycard', -1, 0, 1),
('licenseplate', 'Plaque Immatriculation Custom', 5, 0, 1),
('limonade', 'Limonade', 15, 0, 1),
('lockpick', 'Lockpick', 1, 0, 1),
('lsd', 'Lsd', -1, 0, 1),
('lsd_pooch', 'Pochon de LSD', -1, 0, 1),
('malbora', '🚬 Malboro', 150, 0, 1),
('martini', '🍸 Martini blanc', 5, 0, 1),
('MedArmor', 'Gilet par balle Moyen', 3, 0, 1),
('MedArmour', 'Gilet Moyen', 1, 0, 1),
('medikit', 'Medikit', 15, 0, 1),
('menthe', 'Feuille de menthe', 150, 0, 1),
('meth', 'Meth', 100, 0, 1),
('meth_pooch', 'Pochon de meth', 100, 0, 1),
('metreshooter', 'Mètre de shooter', 15, 0, 1),
('mgAmmo', 'Boite Munition Machine Gun', 5, 0, 1),
('mixapero', 'Mix Apéritif', 15, 0, 1),
('mojito', 'Mojito', 15, 0, 1),
('myrte', 'Myrte', 150, 0, 1),
('myrtealcool', 'Alcool de myrte', 150, 0, 1),
('myrte_cargo', 'Cargaison de Myrte', 150, 0, 1),
('opium', '💉 Ecstasy', 100, 0, 1),
('opium_pooch', '💉 Pochon d\'Ecstasy', 100, 0, 1),
('or1', 'Or', -1, 0, 1),
('or2', 'Lingot', -1, 0, 1),
('or_raffin', 'Or Moulé', -1, 0, 1),
('oxycutter', 'Torche Plasma', -1, 0, 1),
('pacificidcard', 'Pacific ID', -1, 0, 1),
('packaged_chicken', '🍗 Poulet en barquette', 150, 0, 1),
('packaged_plank', '🌳 Paquet de planches', 150, 0, 1),
('pAmmo', 'Boite Munition Pistolet', 5, 0, 1),
('papier', '🛢️ Pétrole', 150, 0, 1),
('petrol', '🥃 Graines', 150, 0, 1),
('petrol_raffin', '🥃 Whiskey Fermenté', 150, 0, 1),
('piluleoubli', '💊 Pilule de l\'oubli', 5, 0, 1),
('poudre', 'Boite de poudre', -1, 0, 1),
('powerade', 'Powerade', 15, 0, 1),
('ppa', 'Licence Permis de Port d\'Armes', 1, 0, 1),
('protein_shake', 'Protein Shake', 15, 0, 1),
('radio', 'radio', 1, 0, 1),
('raisin', '🍇 Raisin', 150, 0, 1),
('rasperry', 'Rasperry', 1, 0, 1),
('redbull', 'RedBull', 150, 0, 1),
('redbull_cargo', 'Cargaison de RedBull', 150, 0, 1),
('rhum', '🥃 Rhum', 5, 0, 1),
('rhumcoca', '🥃 Rhum-coca', 5, 0, 1),
('rhumfruit', '🥃 Rhum-jus de fruits', 5, 0, 1),
('rolex', 'Montre Rolex', -1, 0, 1),
('saucisson', 'Saucisson', 15, 0, 1),
('sgAmmo', 'Boite Munition Fusil à Pompe', 5, 0, 1),
('shark', 'Requin', -1, 0, 1),
('silencieux', 'Silencieux', 15, 0, 1),
('sim', 'Carte SIM', 15, 0, 1),
('slaughtered_chicken', '🍗 Poulet abattu', 150, 0, 1),
('SmallArmor', 'Gilet par balle Léger', 3, 0, 1),
('SmallArmour', 'Gilet Léger', 1, 0, 1),
('soda', 'Soda', 15, 0, 1),
('sportlunch', 'Sportlunch', 15, 0, 1),
('stone', 'Pierre', 124, 0, 1),
('tel', 'Téléphone', 150, 0, 1),
('tabacblond', '🚬 Tabac Blond', 150, 0, 1),
('tabacblondsec', '🚬 Tabac Blond Séché', 150, 0, 1),
('tabacbrun', '🚬 Tabac Brun', 150, 0, 1),
('tabacbrunsec', '🚬 Tabac Brun Séché', 150, 0, 1),
('tenuebraquage', 'Tenue Braquage', -1, 0, 1),
('tenuecasa', 'Tenue Casa de Papel', -1, 0, 1),
('tenueprison', 'Tenue de Prison', -1, 0, 1),
('teqpaf', 'Teq\'paf', 5, 0, 1),
('tequila', '🥃 Tequila', 5, 0, 1),
('TINT_01', '[tint] Vert', 5, 0, 1),
('TINT_02', '[tint] Or', 5, 0, 1),
('TINT_03', '[tint] Rose', 5, 0, 1),
('TINT_04', '[tint] Militaire', 5, 0, 1),
('TINT_05', '[tint] LSPD', 5, 0, 1),
('TINT_06', '[tint] Orange', 5, 0, 1),
('TINT_07', '[tint] Platine', 5, 0, 1),
('turtle', 'Tortue de mer', 3, 0, 1),
('turtlebait', 'Appât à Tortue', 10, 0, 1),
('viande', '🍖 Viande', 25, 0, 1),
('vine', '🍷 Vin', 150, 0, 1),
('vodka', '🥃 Vodka', 5, 0, 1),
('vodkaenergy', '🥃 Vodka-energy', 5, 0, 1),
('vodkafruit', '🥃 Vodka-jus de fruits', 5, 0, 1),
('vodkrb', '🥃 Vodka RedBull', 5, 0, 1),
('washed_stone', 'Pierre Lavée', 124, 0, 1),
('water', '💧 Bouteille d\'Eau', 15, 0, 1),
('weed', '🍁 Cannabis', 100, 0, 1),
('weed_pooch', '🍁 Pochon de Cannabis', 100, 0, 1),
('whisky', '🥃 Whisky', 15, 0, 1),
('whiskycoc', '🥃 Whisky CorsicaCola', 15, 0, 1),
('whiskycoca', '🥃 Whisky-coca', 15, 0, 1),
('wood', '🌳 Bois', 150, 0, 1),
('wool', 'Laine', 150, 0, 1),
('xanax', 'Xanax', -1, 0, 1),
('yusuf', 'Skin de luxe', 15, 0, 1);

-- --------------------------------------------------------

--
-- Structure de la table `jail`
--

DROP TABLE IF EXISTS `jail`;
CREATE TABLE IF NOT EXISTS `jail` (
  `identifier` varchar(100) NOT NULL,
  `isjailed` tinyint(1) DEFAULT NULL,
  `J_Time` datetime NOT NULL,
  `J_Cell` varchar(20) NOT NULL,
  `Jailer` varchar(100) NOT NULL,
  `Jailer_ID` varchar(100) NOT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `whitelisted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `jobs`
--

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('ambulance', 'LSMC', 1),
('ammu', 'Armurier', 1),
('avocat', 'Avocat', 1),
('bahama', 'Bahama Mas', 1),
('ballas', 'Ballas', 0),
('banker', 'Banquier', 1),
('bratva', 'Mafia', 1),
('cardealer', 'Concessionnaire', 1),
('casino', 'Casino', 1),
('famillies', 'Famillies', 1),
('fib', 'FBI', 1),
('fisherman', 'Pêcheur', 1),
('fueler', 'Mixologue', 1),
('garbage', 'Veolia Propreté', 0),
('illegal', 'Illegal', 1),
('journaliste', 'Journaliste', 1),
('kano', 'Clan Kano', 1),
('lazone', 'LaZone', 1),
('lumberjack', 'Bûcheron', 0),
('mecano', 'Mécano', 1),
('mercenaire', 'Mercenaire', 1),
('miner', 'Mineur', 0),
('ms13', 'MS13', 0),
('nightclub', 'NightClub', 1),
('offambulance', 'Pas en Service', 1),
('offpolice', 'Pas en Service', 1),
('pecheur', 'Pêcheur', 1),
('podolskaia', 'Podolskaia', 1),
('police', 'LSPD', 1),
('pompiste', 'Pompiste', 1),
('realestateagent', 'Agent Immobilier', 1),
('reporter', 'Journaliste', 1),
('securoserv', 'SecuroServ', 0),
('slaughterer', 'Abatteur', 0),
('state', 'Gouvernement', 1),
('syndicat', 'Syndicat', 1),
('tabac', 'Tabac', 1),
('tailor', 'Couturier', 0),
('taxi', 'Taxi', 1),
('unemployed', 'Chômeur', 0),
('unemployed2', 'État', 0),
('unicorn', 'Unicorn', 1),
('vagos', 'Vagos', 1),
('vigne', 'Vignerons', 1);

-- --------------------------------------------------------

--
-- Structure de la table `job_grades`
--

DROP TABLE IF EXISTS `job_grades`;
CREATE TABLE IF NOT EXISTS `job_grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(255) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=317 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `job_grades`
--

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(1, 'unemployed', 0, 'unemployed', 'Pole Emploi', 150, '{}', '{}'),
(2, 'lumberjack', 0, 'employee', 'Intérimaire', 350, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":13,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":15,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":2,\"ears_2\":0,\"arms\":11,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":0,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":15,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":12,\"pants_1\":9}', '{}'),
(3, 'fisherman', 0, 'employee', 'Intérimaire', 350, '{}', '{}'),
(4, 'fueler', 0, 'employee', 'Intérimaire', 350, '{}', '{}'),
(5, 'reporter', 0, 'employee', 'Intérimaire', 350, '{}', '{}'),
(6, 'tailor', 0, 'employee', 'Intérimaire', 350, '{\"mask_1\":0,\"arms\":1,\"glasses_1\":0,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":15,\"mask_2\":0,\"makeup_3\":0,\"skin\":29,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":0,\"torso_1\":24,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":0,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":0,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":36,\"tshirt_2\":0,\"beard_3\":0,\"hair_1\":2,\"hair_color_1\":0,\"pants_1\":48,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}', '{\"mask_1\":0,\"arms\":5,\"glasses_1\":5,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":29,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":1,\"torso_1\":52,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":1,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":23,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":42,\"tshirt_2\":4,\"beard_3\":0,\"hair_1\":2,\"hair_color_1\":0,\"pants_1\":36,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}'),
(7, 'miner', 0, 'employee', 'Intérimaire', 350, '{\"tshirt_2\":1,\"ears_1\":8,\"glasses_1\":15,\"torso_2\":0,\"ears_2\":2,\"glasses_2\":3,\"shoes_2\":1,\"pants_1\":75,\"shoes_1\":51,\"bags_1\":0,\"helmet_2\":0,\"pants_2\":7,\"torso_1\":71,\"tshirt_1\":59,\"arms\":2,\"bags_2\":0,\"helmet_1\":0}', '{}'),
(8, 'slaughterer', 0, 'employee', 'Intérimaire', 350, '{\"age_1\":0,\"glasses_2\":0,\"beard_1\":5,\"decals_2\":0,\"beard_4\":0,\"shoes_2\":0,\"tshirt_2\":0,\"lipstick_2\":0,\"hair_2\":0,\"arms\":67,\"pants_1\":36,\"skin\":29,\"eyebrows_2\":0,\"shoes\":10,\"helmet_1\":-1,\"lipstick_1\":0,\"helmet_2\":0,\"hair_color_1\":0,\"glasses\":0,\"makeup_4\":0,\"makeup_1\":0,\"hair_1\":2,\"bproof_1\":0,\"bags_1\":0,\"mask_1\":0,\"lipstick_3\":0,\"chain_1\":0,\"eyebrows_4\":0,\"sex\":0,\"torso_1\":56,\"beard_2\":6,\"shoes_1\":12,\"decals_1\":0,\"face\":19,\"lipstick_4\":0,\"tshirt_1\":15,\"mask_2\":0,\"age_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"glasses_1\":0,\"ears_1\":-1,\"bags_2\":0,\"ears_2\":0,\"torso_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"makeup_3\":0,\"pants_2\":0,\"beard_3\":0,\"hair_color_2\":4}', '{\"age_1\":0,\"glasses_2\":0,\"beard_1\":5,\"decals_2\":0,\"beard_4\":0,\"shoes_2\":0,\"tshirt_2\":0,\"lipstick_2\":0,\"hair_2\":0,\"arms\":72,\"pants_1\":45,\"skin\":29,\"eyebrows_2\":0,\"shoes\":10,\"helmet_1\":-1,\"lipstick_1\":0,\"helmet_2\":0,\"hair_color_1\":0,\"glasses\":0,\"makeup_4\":0,\"makeup_1\":0,\"hair_1\":2,\"bproof_1\":0,\"bags_1\":0,\"mask_1\":0,\"lipstick_3\":0,\"chain_1\":0,\"eyebrows_4\":0,\"sex\":1,\"torso_1\":49,\"beard_2\":6,\"shoes_1\":24,\"decals_1\":0,\"face\":19,\"lipstick_4\":0,\"tshirt_1\":9,\"mask_2\":0,\"age_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"glasses_1\":5,\"ears_1\":-1,\"bags_2\":0,\"ears_2\":0,\"torso_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"makeup_3\":0,\"pants_2\":0,\"beard_3\":0,\"hair_color_2\":4}'),
(9, 'cardealer', 0, 'recruit', 'Recrue', 1, '{}', '{}'),
(10, 'cardealer', 1, 'novice', 'Novice', 1, '{}', '{}'),
(11, 'cardealer', 2, 'experienced', 'Experimente', 1, '{}', '{}'),
(12, 'cardealer', 3, 'boss', 'Patron', 1, '{}', '{}'),
(13, 'ambulance', 0, 'ambulance', 'Médecin', 1, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":8,\"torso_2\":1,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":-1,\"helmet_2\":0,\"arms\":85,\"face\":19,\"decals_1\":58,\"torso_1\":250,\"hair_2\":0,\"skin\":34,\"pants_2\":3}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(14, 'ambulance', 1, 'doctor', 'Médecin-Chef', 1, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":8,\"torso_2\":1,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":-1,\"helmet_2\":0,\"arms\":85,\"face\":19,\"decals_1\":58,\"torso_1\":250,\"hair_2\":0,\"skin\":34,\"pants_2\":3}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(15, 'ambulance', 2, 'chief_doctor', 'Chirurgien', 1, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":8,\"torso_2\":1,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":-1,\"helmet_2\":0,\"arms\":85,\"face\":19,\"decals_1\":58,\"torso_1\":250,\"hair_2\":0,\"skin\":34,\"pants_2\":3}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(16, 'ambulance', 3, 'boss', 'Directeur', 650, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":8,\"torso_2\":1,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":-1,\"helmet_2\":0,\"arms\":85,\"face\":19,\"decals_1\":58,\"torso_1\":250,\"hair_2\":0,\"skin\":34,\"pants_2\":3}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(17, 'mecano', 0, 'recrue', 'Recrue', 1, '{\"tshirt_2\":0,\"ears_1\":-1,\"glasses_1\":0,\"torso_2\":0,\"ears_2\":0,\"glasses_2\":0,\"shoes_2\":12,\"pants_1\":90,\"shoes_1\":12,\"bags_1\":0,\"helmet_2\":0,\"pants_2\":3,\"torso_1\":89,\"tshirt_1\":15,\"arms\":6,\"bags_2\":0,\"helmet_1\":-1}\r\n\r\n\r\n\r\n', '{}'),
(18, 'mecano', 1, 'novice', 'Novice', 1, '{\"tshirt_2\":0,\"ears_1\":-1,\"glasses_1\":0,\"torso_2\":0,\"ears_2\":0,\"glasses_2\":0,\"shoes_2\":12,\"pants_1\":90,\"shoes_1\":12,\"bags_1\":0,\"helmet_2\":0,\"pants_2\":3,\"torso_1\":89,\"tshirt_1\":15,\"arms\":6,\"bags_2\":0,\"helmet_1\":-1}\r\n', '{}'),
(19, 'mecano', 2, 'experimente', 'Experimente', 1, '{\"tshirt_2\":0,\"ears_1\":-1,\"glasses_1\":0,\"torso_2\":0,\"ears_2\":0,\"glasses_2\":0,\"shoes_2\":12,\"pants_1\":90,\"shoes_1\":12,\"bags_1\":0,\"helmet_2\":0,\"pants_2\":8,\"torso_1\":89,\"tshirt_1\":15,\"arms\":6,\"bags_2\":0,\"helmet_1\":-1}\r\n', '{}'),
(20, 'mecano', 3, 'chief', 'Chef d\'équipe', 500, '{\"tshirt_2\":0,\"ears_1\":-1,\"glasses_1\":0,\"torso_2\":0,\"ears_2\":0,\"glasses_2\":0,\"shoes_2\":12,\"pants_1\":90,\"shoes_1\":12,\"bags_1\":0,\"helmet_2\":0,\"pants_2\":1,\"torso_1\":89,\"tshirt_1\":15,\"arms\":6,\"bags_2\":0,\"helmet_1\":-1}', '{}'),
(21, 'mecano', 4, 'boss', 'Patron', 1, '{\"tshirt_2\":0,\"ears_1\":-1,\"glasses_1\":0,\"torso_2\":0,\"ears_2\":0,\"glasses_2\":0,\"shoes_2\":12,\"pants_1\":90,\"shoes_1\":12,\"bags_1\":0,\"helmet_2\":0,\"pants_2\":5,\"torso_1\":89,\"tshirt_1\":15,\"arms\":6,\"bags_2\":0,\"helmet_1\":-1}', '{}'),
(27, 'tabac', 0, 'recrue', 'Tabagiste', 1, '{}', '{}'),
(28, 'tabac', 1, 'gerant', 'Gérant', 1, '{}', '{}'),
(29, 'tabac', 2, 'boss', 'Patron', 1, '{}', '{}'),
(30, 'taxi', 0, 'recrue', 'Recrue', 400, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":32,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":31,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":0,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":27,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(31, 'taxi', 1, 'novice', 'Novice', 450, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":32,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":31,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":0,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":27,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(32, 'taxi', 2, 'experimente', 'Experimente', 500, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":26,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":57,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":4,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":11,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(33, 'taxi', 3, 'uber', 'Uber', 550, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":26,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":57,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":4,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":11,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(34, 'taxi', 4, 'boss', 'Patron', 600, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":29,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":31,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":4,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":1,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":4,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(35, 'unicorn', 0, 'barman', 'Barman', 1, '{}', '{}'),
(36, 'unicorn', 1, 'dancer', 'Danseur', 1, '{}', '{}'),
(37, 'unicorn', 2, 'viceboss', 'Co-gérant', 1, '{}', '{}'),
(38, 'unicorn', 3, 'boss', 'Gérant', 1, '{}', '{}'),
(39, 'vigne', 0, 'recrue', 'Intérimaire', 400, '{\"tshirt_1\":59,\"tshirt_2\":0,\"torso_1\":12,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":1, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(40, 'vigne', 1, 'novice', 'Vigneron', 500, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(41, 'vigne', 2, 'cdisenior', 'Chef de chai', 600, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(42, 'vigne', 3, 'boss', 'Patron', 650, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":15,\"tshirt_2\":0,\"torso_1\":14,\"torso_2\":15,\"shoes_1\":12,\"shoes_2\":0,\"pants_1\":9, \"pants_2\":5, \"arms\":1, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(43, 'realestateagent', 0, 'location', 'Location', 1, '{}', '{}'),
(44, 'realestateagent', 1, 'vendeur', 'Vendeur', 1, '{}', '{}'),
(45, 'realestateagent', 2, 'gestion', 'Gestion', 1, '{}', '{}'),
(46, 'realestateagent', 3, 'boss', 'Patron', 699, '{}', '{}'),
(89, 'banker', 0, 'advisor', 'Conseiller', 400, '{}', '{}'),
(90, 'banker', 1, 'banker', 'Banquier', 450, '{}', '{}'),
(91, 'banker', 2, 'business_banker', 'Banquier d\'affaire', 500, '{}', '{}'),
(92, 'banker', 3, 'trader', 'Trader', 550, '{}', '{}'),
(93, 'banker', 4, 'boss', 'Patron', 600, '{}', '{}'),
(110, 'fueler', 0, 'recrue', 'Intérimaire', 300, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":13,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{}'),
(111, 'fueler', 1, 'novice', 'Chef équipe', 500, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":13,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{}'),
(112, 'fueler', 2, 'cdisenior', 'Adjoint', 1000, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":13,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{}'),
(113, 'fueler', 3, 'boss', 'Patron', 2000, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":13,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{}'),
(114, 'nightclub', 0, 'barman', 'Barman', 1, '{}', '{}'),
(115, 'nightclub', 1, 'dancer', 'Danceur', 1, '{}', '{}'),
(116, 'nightclub', 2, 'viceboss', 'Co-Manager', 1, '{}', '{}'),
(117, 'nightclub', 3, 'boss', 'Patron', 1, '{}', '{}'),
(118, 'bahama', 0, 'barman', 'Barman', 10, '{}', '{}'),
(119, 'bahama', 1, 'dj', 'DJ', 10, '{}', '{}'),
(120, 'bahama', 2, 'secu', 'Sécurité', 10, '{}', '{}'),
(121, 'bahama', 3, 'viceboss', 'Co-gérant', 10, '{}', '{}'),
(122, 'bahama', 4, 'boss', 'Gérant', 10, '{}', '{}'),
(123, 'police', 0, 'recruit', 'Cadet', 150, '{}', '{}'),
(124, 'police', 1, 'officer', 'Officier', 300, '{}', '{}'),
(125, 'police', 2, 'sergeant', 'Sergent', 150, '{}', '{}'),
(126, 'police', 3, 'intendent', 'Sergent-Chef', 150, '{}', '{}'),
(127, 'police', 4, 'lieutenant', 'Lieutenant', 500, '{}', '{}'),
(128, 'police', 5, 'chef', 'Capitaine', 550, '{}', '{}'),
(129, 'police', 6, 'boss', 'Commandant', 600, '{}', '{}'),
(130, 'police', 7, 'bac', 'BAC', 525, '{}', '{}'),
(143, 'garbage', 0, 'employee', 'Intérimaire', 350, '{\"tshirt_1\":59,\"torso_1\":89,\"arms\":31,\"pants_1\":36,\"glasses_1\":19,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":1,\"shoes\":35,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":19,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":5}', '{\"tshirt_1\":36,\"torso_1\":0,\"arms\":68,\"pants_1\":30,\"glasses_1\":15,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":27,\"glasses_2\":0,\"torso_2\":11,\"shoes\":26,\"hair_1\":5,\"skin\":0,\"sex\":1,\"glasses_1\":15,\"pants_2\":2,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":19}'),
(156, 'pecheur', 0, 'recrue', 'Intérimaire', 400, '{\"tshirt_1\":59,\"tshirt_2\":0,\"torso_1\":12,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":1, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(157, 'pecheur', 1, 'novice', 'Pécheur', 450, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(158, 'pecheur', 2, 'cdisenior', 'Chef Pécheur', 500, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(159, 'pecheur', 3, 'boss', 'Patron', 600, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":15,\"tshirt_2\":0,\"torso_1\":14,\"torso_2\":15,\"shoes_1\":12,\"shoes_2\":0,\"pants_1\":9, \"pants_2\":5, \"arms\":1, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(168, 'offpolice', 0, 'recruit', 'Cadet', 425, '{}', '{}'),
(169, 'offpolice', 1, 'officer', 'Officier', 450, '{}', '{}'),
(170, 'offpolice', 2, 'sergeant', 'Sergeant', 475, '{}', '{}'),
(171, 'offpolice', 3, 'intendant', '	Sergent-Chef', 500, '{}', '{}'),
(172, 'offpolice', 4, 'lieutenant', 'Lieutenant', 525, '{}', '{}'),
(173, 'offpolice', 5, 'chef', 'Capitaine', 550, '{}', '{}'),
(174, 'offpolice', 6, 'boss', 'Commandant', 600, '{}', '{}'),
(175, 'offpolice', 7, 'bac', 'BAC', 525, '{}', '{}'),
(176, 'offambulance', 0, 'ambulance', 'Ambulancier', 400, '{}', '{}'),
(177, 'offambulance', 1, 'doctor', 'Médecin', 450, '{}', '{}'),
(178, 'offambulance', 2, 'chief_doctor', 'Médecin-Chef', 500, '{}', '{}'),
(179, 'offambulance', 3, 'boss', 'Patron', 600, '{}', '{}'),
(224, 'fib', 0, 'recruit', 'Recrue', 400, '{\"eyebrows_4\":27,\"beard_1\":18,\"hair_color_2\":0,\"torso_1\":13,\"hair_2\":0,\"glasses_2\":3,\"skin\":1,\"eyebrows_2\":10,\"glasses_1\":5,\"makeup_2\":1,\"mask_2\":0,\"beard_4\":7,\"hair_color_1\":2,\"mask_1\":0,\"beard_2\":10,\"bproof_1\":0,\"shoes_1\":21,\"face\":0,\"bags_1\":0,\"pants_1\":10,\"helmet_1\":8,\"pants_2\":0,\"makeup_4\":1,\"chain_1\":38,\"sex\":0,\"tshirt_1\":15,\"makeup_3\":0,\"tshirt_2\":0,\"shoes\":10,\"bproof_2\":0,\"arms\":11,\"decals_2\":0,\"ears_2\":0,\"helmet_2\":0,\"ears_1\":2,\"lipstick_4\":0,\"glasses\":0,\"torso_2\":0,\"lipstick_1\":0,\"decals_1\":0,\"beard_3\":2,\"makeup_1\":0,\"shoes_2\":0,\"chain_2\":0,\"eyebrows_3\":27,\"bags_2\":0,\"age_2\":2,\"hair_1\":39,\"age_1\":4,\"lipstick_3\":0,\"lipstick_2\":0,\"eyebrows_1\":12}', '{\"eyebrows_4\":27,\"beard_1\":18,\"hair_color_2\":0,\"torso_1\":27,\"hair_2\":0,\"glasses_2\":0,\"skin\":0,\"eyebrows_2\":10,\"glasses_1\":19,\"makeup_2\":1,\"mask_2\":0,\"beard_4\":4,\"hair_color_1\":2,\"mask_1\":0,\"beard_2\":0,\"bproof_1\":0,\"shoes_1\":13,\"face\":6,\"bags_1\":0,\"pants_1\":6,\"helmet_1\":57,\"pants_2\":0,\"makeup_4\":1,\"chain_1\":0,\"sex\":1,\"tshirt_1\":3,\"makeup_3\":0,\"tshirt_2\":0,\"shoes\":10,\"bproof_2\":0,\"arms\":0,\"decals_2\":0,\"ears_2\":0,\"helmet_2\":0,\"ears_1\":-1,\"lipstick_4\":0,\"glasses\":0,\"torso_2\":0,\"lipstick_1\":0,\"decals_1\":1,\"beard_3\":0,\"makeup_1\":0,\"shoes_2\":0,\"chain_2\":0,\"eyebrows_3\":27,\"bags_2\":0,\"age_2\":2,\"hair_1\":73,\"age_1\":4,\"lipstick_3\":0,\"lipstick_2\":0,\"eyebrows_1\":13}'),
(225, 'fib', 1, 'agent', 'Agent', 450, '{\"eyebrows_1\":10,\"beard_1\":0,\"hair_color_2\":0,\"torso_1\":28,\"hair_2\":0,\"glasses_2\":6,\"skin\":0,\"eyebrows_2\":10,\"hair_1\":10,\"makeup_2\":0,\"mask_2\":0,\"beard_4\":0,\"hair_color_1\":3,\"sex\":0,\"beard_2\":0,\"bproof_1\":0,\"mask_1\":0,\"face\":44,\"decals_1\":0,\"bags_1\":0,\"helmet_1\":-1,\"pants_2\":0,\"lipstick_1\":0,\"chain_1\":10,\"decals_2\":0,\"tshirt_1\":10,\"makeup_3\":0,\"tshirt_2\":0,\"shoes\":24,\"bproof_2\":0,\"arms\":1,\"age_2\":0,\"ears_2\":0,\"helmet_2\":0,\"ears_1\":-1,\"lipstick_4\":0,\"pants_1\":10,\"shoes_1\":21,\"beard_3\":0,\"lipstick_2\":0,\"eyebrows_4\":0,\"makeup_1\":0,\"shoes_2\":0,\"chain_2\":2,\"eyebrows_3\":1,\"bags_2\":0,\"glasses\":0,\"torso_2\":0,\"age_1\":0,\"lipstick_3\":0,\"makeup_4\":0,\"glasses_1\":17}', '{\"eyebrows_1\":13,\"beard_1\":18,\"hair_color_2\":0,\"torso_1\":7,\"hair_2\":0,\"glasses_2\":0,\"skin\":0,\"makeup_4\":1,\"hair_1\":73,\"makeup_2\":1,\"mask_2\":0,\"beard_4\":4,\"hair_color_1\":2,\"mask_1\":0,\"torso_2\":0,\"bproof_1\":0,\"decals_1\":1,\"glasses\":0,\"sex\":1,\"bags_1\":0,\"helmet_1\":57,\"pants_2\":0,\"face\":6,\"chain_1\":0,\"beard_2\":0,\"tshirt_1\":39,\"makeup_3\":0,\"tshirt_2\":0,\"shoes\":10,\"bproof_2\":0,\"arms\":7,\"eyebrows_2\":10,\"ears_2\":0,\"helmet_2\":0,\"ears_1\":-1,\"lipstick_4\":0,\"beard_3\":0,\"chain_2\":0,\"pants_1\":6,\"lipstick_2\":0,\"eyebrows_4\":27,\"makeup_1\":0,\"shoes_2\":0,\"decals_2\":0,\"shoes_1\":13,\"bags_2\":0,\"age_2\":2,\"glasses_1\":19,\"age_1\":4,\"lipstick_3\":0,\"lipstick_1\":0,\"eyebrows_3\":27}'),
(226, 'fib', 2, 'specialagent', 'Agent Spécial', 500, '{\"eyebrows_1\":10,\"beard_1\":0,\"hair_color_2\":0,\"torso_1\":28,\"hair_2\":0,\"glasses_2\":6,\"skin\":0,\"eyebrows_2\":10,\"hair_1\":10,\"makeup_2\":0,\"mask_2\":0,\"beard_4\":0,\"hair_color_1\":3,\"sex\":0,\"beard_2\":0,\"bproof_1\":0,\"mask_1\":0,\"face\":44,\"decals_1\":0,\"bags_1\":0,\"helmet_1\":-1,\"pants_2\":0,\"lipstick_1\":0,\"chain_1\":10,\"decals_2\":0,\"tshirt_1\":10,\"makeup_3\":0,\"tshirt_2\":0,\"shoes\":24,\"bproof_2\":0,\"arms\":1,\"age_2\":0,\"ears_2\":0,\"helmet_2\":0,\"ears_1\":-1,\"lipstick_4\":0,\"pants_1\":10,\"shoes_1\":21,\"beard_3\":0,\"lipstick_2\":0,\"eyebrows_4\":0,\"makeup_1\":0,\"shoes_2\":0,\"chain_2\":2,\"eyebrows_3\":1,\"bags_2\":0,\"glasses\":0,\"torso_2\":0,\"age_1\":0,\"lipstick_3\":0,\"makeup_4\":0,\"glasses_1\":17}', '{\"eyebrows_1\":13,\"beard_1\":18,\"hair_color_2\":0,\"torso_1\":7,\"hair_2\":0,\"glasses_2\":0,\"skin\":0,\"makeup_4\":1,\"hair_1\":73,\"makeup_2\":1,\"mask_2\":0,\"beard_4\":4,\"hair_color_1\":2,\"mask_1\":0,\"torso_2\":0,\"bproof_1\":0,\"decals_1\":1,\"glasses\":0,\"sex\":1,\"bags_1\":0,\"helmet_1\":57,\"pants_2\":0,\"face\":6,\"chain_1\":0,\"beard_2\":0,\"tshirt_1\":39,\"makeup_3\":0,\"tshirt_2\":0,\"shoes\":10,\"bproof_2\":0,\"arms\":7,\"eyebrows_2\":10,\"ears_2\":0,\"helmet_2\":0,\"ears_1\":-1,\"lipstick_4\":0,\"beard_3\":0,\"chain_2\":0,\"pants_1\":6,\"lipstick_2\":0,\"eyebrows_4\":27,\"makeup_1\":0,\"shoes_2\":0,\"decals_2\":0,\"shoes_1\":13,\"bags_2\":0,\"age_2\":2,\"glasses_1\":19,\"age_1\":4,\"lipstick_3\":0,\"lipstick_1\":0,\"eyebrows_3\":27}'),
(227, 'fib', 3, 'boss', 'Directeur', 600, '{\"eyebrows_1\":10,\"beard_1\":0,\"hair_color_2\":0,\"torso_1\":4,\"hair_2\":0,\"glasses_2\":6,\"skin\":0,\"eyebrows_2\":10,\"hair_1\":10,\"makeup_2\":0,\"mask_2\":0,\"beard_4\":0,\"hair_color_1\":3,\"sex\":0,\"beard_2\":0,\"bproof_1\":0,\"mask_1\":0,\"face\":44,\"decals_1\":0,\"bags_1\":0,\"helmet_1\":-1,\"pants_2\":0,\"lipstick_1\":0,\"chain_1\":10,\"decals_2\":0,\"tshirt_1\":10,\"makeup_3\":0,\"tshirt_2\":0,\"shoes\":24,\"bproof_2\":0,\"arms\":4,\"age_2\":0,\"ears_2\":0,\"helmet_2\":0,\"ears_1\":-1,\"lipstick_4\":0,\"pants_1\":10,\"shoes_1\":21,\"beard_3\":0,\"lipstick_2\":0,\"eyebrows_4\":0,\"makeup_1\":0,\"shoes_2\":0,\"chain_2\":2,\"eyebrows_3\":1,\"bags_2\":0,\"glasses\":0,\"torso_2\":0,\"age_1\":0,\"lipstick_3\":0,\"makeup_4\":0,\"glasses_1\":17}', '{\"eyebrows_1\":13,\"beard_1\":18,\"hair_color_2\":0,\"torso_1\":7,\"hair_2\":0,\"glasses_2\":0,\"skin\":0,\"makeup_4\":1,\"hair_1\":73,\"makeup_2\":1,\"mask_2\":0,\"beard_4\":4,\"hair_color_1\":2,\"mask_1\":0,\"torso_2\":0,\"bproof_1\":0,\"decals_1\":1,\"glasses\":0,\"sex\":1,\"bags_1\":0,\"helmet_1\":57,\"pants_2\":0,\"face\":6,\"chain_1\":0,\"beard_2\":0,\"tshirt_1\":39,\"makeup_3\":0,\"tshirt_2\":0,\"shoes\":10,\"bproof_2\":0,\"arms\":7,\"eyebrows_2\":10,\"ears_2\":0,\"helmet_2\":0,\"ears_1\":-1,\"lipstick_4\":0,\"beard_3\":0,\"chain_2\":0,\"pants_1\":6,\"lipstick_2\":0,\"eyebrows_4\":27,\"makeup_1\":0,\"shoes_2\":0,\"decals_2\":0,\"shoes_1\":13,\"bags_2\":0,\"age_2\":2,\"glasses_1\":19,\"age_1\":4,\"lipstick_3\":0,\"lipstick_1\":0,\"eyebrows_3\":27}'),
(228, 'pompiste', 0, 'recrue', 'Intérimaire', 300, '{\"tshirt_1\":59,\"tshirt_2\":0,\"torso_1\":12,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":1, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(229, 'pompiste', 1, 'novice', 'Employé', 300, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(230, 'pompiste', 2, 'cdisenior', 'Chef', 400, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(231, 'pompiste', 3, 'boss', 'Patron', 1, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":15,\"tshirt_2\":0,\"torso_1\":14,\"torso_2\":15,\"shoes_1\":12,\"shoes_2\":0,\"pants_1\":9, \"pants_2\":5, \"arms\":1, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(236, 'famillies', 0, 'soldato', 'Soldat', 0, '{}', '{}'),
(237, 'famillies', 1, 'capo', 'Assassin', 0, '{}', '{}'),
(238, 'famillies', 2, 'consigliere', 'Consigliere', 0, '{}', '{}'),
(239, 'famillies', 3, 'righthand', 'Bras Droit', 0, '{}', '{}'),
(240, 'famillies', 4, 'boss', 'Chef', 150, '{\"tshirt_1\":15,\"torso_1\":42,\"shoes\":8,\"pants_1\":24,\"pants_2\":0,\"decals_2\":0,\"hair_color_2\":0,\"face\":19,\"helmet_2\":0,\"hair_2\":0,\"arms\":8,\"torso_2\":0,\"hair_color_1\":5,\"hair_1\":2,\"skin\":34,\"sex\":0,\"glasses_1\":0,\"glasses_2\":1,\"decals_1\":0,\"glasses\":0,\"tshirt_2\":0,\"helmet_1\":-1}', '{}'),
(241, 'kano', 0, 'soldato', 'Soldat', 0, '{}', '{}'),
(242, 'kano', 1, 'capo', 'Assassin', 0, '{}', '{}'),
(243, 'kano', 2, 'consigliere', 'Consigliere', 0, '{}', '{}'),
(244, 'kano', 3, 'righthand', 'Bras Droit', 0, '{}', '{}'),
(245, 'kano', 4, 'boss', 'Chef', 0, '{\"tshirt_1\":15,\"torso_1\":42,\"shoes\":8,\"pants_1\":24,\"pants_2\":0,\"decals_2\":0,\"hair_color_2\":0,\"face\":19,\"helmet_2\":0,\"hair_2\":0,\"arms\":8,\"torso_2\":0,\"hair_color_1\":5,\"hair_1\":2,\"skin\":34,\"sex\":0,\"glasses_1\":0,\"glasses_2\":1,\"decals_1\":0,\"glasses\":0,\"tshirt_2\":0,\"helmet_1\":-1}', '{}'),
(246, 'lazone', 0, 'soldato', 'Soldat', 0, '{}', '{}'),
(247, 'lazone', 1, 'capo', 'Assassin', 0, '{}', '{}'),
(248, 'lazone', 2, 'consigliere', 'Consigliere', 0, '{}', '{}'),
(249, 'lazone', 3, 'righthand', 'Bras Droit', 0, '{}', '{}'),
(250, 'lazone', 4, 'boss', 'Chef', 0, '{\"tshirt_1\":15,\"torso_1\":42,\"shoes\":8,\"pants_1\":24,\"pants_2\":0,\"decals_2\":0,\"hair_color_2\":0,\"face\":19,\"helmet_2\":0,\"hair_2\":0,\"arms\":8,\"torso_2\":0,\"hair_color_1\":5,\"hair_1\":2,\"skin\":34,\"sex\":0,\"glasses_1\":0,\"glasses_2\":1,\"decals_1\":0,\"glasses\":0,\"tshirt_2\":0,\"helmet_1\":-1}', '{}'),
(251, 'bratva', 0, 'soldato', 'Soldat', 0, '{}', '{}'),
(252, 'bratva', 1, 'capo', 'Assassin', 0, '{}', '{}'),
(253, 'bratva', 2, 'consigliere', 'Consigliere', 0, '{}', '{}'),
(254, 'bratva', 3, 'righthand', 'Bras Droit', 0, '{}', '{}'),
(255, 'bratva', 4, 'boss', 'Chef', 0, '{\"tshirt_1\":15,\"torso_1\":42,\"shoes\":8,\"pants_1\":24,\"pants_2\":0,\"decals_2\":0,\"hair_color_2\":0,\"face\":19,\"helmet_2\":0,\"hair_2\":0,\"arms\":8,\"torso_2\":0,\"hair_color_1\":5,\"hair_1\":2,\"skin\":34,\"sex\":0,\"glasses_1\":0,\"glasses_2\":1,\"decals_1\":0,\"glasses\":0,\"tshirt_2\":0,\"helmet_1\":-1}', '{}'),
(256, 'unemployed2', 0, 'rsa', 'Civil', 500, '{}', '{}'),
(258, 'ammu', 0, 'stagiaire', 'Stagiaire', 500, '{}', '{}'),
(259, 'ammu', 1, 'employé', 'Employé', 600, '{}', '{}'),
(260, 'ammu', 2, 'professionnel', 'Professionnel', 699, '{}', '{}'),
(261, 'ammu', 3, 'second', 'Second', 699, '{}', '{}'),
(262, 'ammu', 4, 'boss', 'Gérant(e)', 500, '{\"tshirt_1\":15,\"torso_1\":42,\"shoes\":8,\"pants_1\":24,\"pants_2\":0,\"decals_2\":0,\"hair_color_2\":0,\"face\":19,\"helmet_2\":0,\"hair_2\":0,\"arms\":8,\"torso_2\":0,\"hair_color_1\":5,\"hair_1\":2,\"skin\":34,\"sex\":0,\"glasses_1\":0,\"glasses_2\":1,\"decals_1\":0,\"glasses\":0,\"tshirt_2\":0,\"helmet_1\":-1}', '{}'),
(263, 'state', 0, 'vicepresident', 'FBI Recrue', 950, '{}', '{}'),
(264, 'state', 3, 'president', 'Président(e)', 1500, '{}', '{}'),
(265, 'state', 2, 'gouvernment', 'Garde Rapproché', 1250, '{}', '{}'),
(266, 'state', 1, 'boss', 'FBI', 1000, '{}', '{}'),
(267, 'avocat', 0, 'recruit', 'Avocat(e)', 500, '{\"tshirt_1\":57,\"torso_1\":55,\"arms\":0,\"pants_1\":35,\"glasses\":0,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":5,\"face\":19,\"glasses_2\":1,\"torso_2\":0,\"shoes\":24,\"hair_1\":2,\"skin\":34,\"sex\":0,\"glasses_1\":0,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":8}', '{\"tshirt_1\":34,\"torso_1\":48,\"shoes\":24,\"pants_1\":34,\"torso_2\":0,\"decals_2\":0,\"hair_color_2\":0,\"glasses\":0,\"helmet_2\":0,\"hair_2\":3,\"face\":21,\"decals_1\":0,\"glasses_2\":1,\"hair_1\":11,\"skin\":34,\"sex\":1,\"glasses_1\":5,\"pants_2\":0,\"arms\":14,\"hair_color_1\":10,\"tshirt_2\":0,\"helmet_1\":57}'),
(268, 'avocat', 1, 'boss', 'Patron', 750, '{\"tshirt_1\":58,\"torso_1\":55,\"shoes\":24,\"pants_1\":35,\"pants_2\":0,\"decals_2\":3,\"hair_color_2\":0,\"face\":19,\"helmet_2\":0,\"hair_2\":0,\"arms\":41,\"torso_2\":0,\"hair_color_1\":5,\"hair_1\":2,\"skin\":34,\"sex\":0,\"glasses_1\":0,\"glasses_2\":1,\"decals_1\":8,\"glasses\":0,\"tshirt_2\":0,\"helmet_1\":11}', '{\"tshirt_1\":35,\"torso_1\":48,\"arms\":44,\"pants_1\":34,\"pants_2\":0,\"decals_2\":3,\"hair_color_2\":0,\"face\":21,\"helmet_2\":0,\"hair_2\":3,\"decals_1\":7,\"torso_2\":0,\"hair_color_1\":10,\"hair_1\":11,\"skin\":34,\"sex\":1,\"glasses_1\":5,\"glasses_2\":1,\"shoes\":24,\"glasses\":0,\"tshirt_2\":0,\"helmet_1\":57}'),
(269, 'ballas', 0, 'soldato', 'Soldat', 10, '{}', '{}'),
(270, 'ballas', 1, 'capo', 'Assassin', 13, '{}', '{}'),
(271, 'ballas', 2, 'consigliere', 'Consigliere', 16, '{}', '{}'),
(272, 'ballas', 3, 'righthand', 'Bras Droit', 20, '{}', '{}'),
(273, 'ballas', 3, 'boss', 'Chef', 20, '{}', '{}'),
(274, 'journaliste', 0, 'stagiaire', 'Stagiaire', 150, '{}', '{}'),
(275, 'journaliste', 1, 'reporter', 'Reporter', 200, '{}', '{}'),
(276, 'journaliste', 2, 'investigator', 'Enquêteur', 250, '{}', '{}'),
(277, 'journaliste', 3, 'boss', 'Rédac\' chef', 5, '{}', '{}'),
(278, 'illegal', 0, 'soldato', 'Soldado', 1, '{}', '{}'),
(279, 'illegal', 1, 'capo', 'Assasino', 1, '{}', '{}'),
(280, 'illegal', 2, 'consigliere', 'Capo', 1, '{}', '{}'),
(281, 'illegal', 3, 'righthand', 'Mão direita', 1, '{}', '{}'),
(282, 'illegal', 4, 'boss', 'Chef ', 1, '{\"tshirt_1\":15,\"torso_1\":42,\"shoes\":8,\"pants_1\":24,\"pants_2\":0,\"decals_2\":0,\"hair_color_2\":0,\"face\":19,\"helmet_2\":0,\"hair_2\":0,\"arms\":8,\"torso_2\":0,\"hair_color_1\":5,\"hair_1\":2,\"skin\":34,\"sex\":0,\"glasses_1\":0,\"glasses_2\":1,\"decals_1\":0,\"glasses\":0,\"tshirt_2\":0,\"helmet_1\":-1}', '{}'),
(283, 'securoserv', 0, 'recruit', 'Agent', 1, '{}', '{}'),
(284, 'securoserv', 1, 'lieutenant', 'Bras Droit', 1, '{}', '{}'),
(285, 'securoserv', 2, 'boss', 'Patron', 1, '{}', '{}'),
(286, 'ms13', 0, 'recrue', 'MS-13', 12, '{}', '{}'),
(287, 'ms13', 1, 'novice', 'Gérant', 24, '{}', '{}'),
(288, 'ms13', 2, 'experimente', 'Frère de sang', 36, '{}', '{}'),
(289, 'ms13', 3, 'chief', 'El Patron ', 48, '{}', '{}'),
(290, 'casino', 0, 'guard', 'Securité', 70, '{\"torso_1\":95,\"helmet_2\":2,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":15,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":0,\"age_2\":0,\"glasses_2\":6,\"ears_2\":0,\"arms\":26,\"lipstick_1\":0,\"ears_1\":0,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":58,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":17,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":45,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":1,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":21,\"pants_1\":24}', '{\"torso_1\":124,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":15,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":6,\"ears_2\":0,\"arms\":14,\"lipstick_1\":0,\"ears_1\":0,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":4,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":45,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":2,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":42,\"pants_1\":65}'),
(291, 'casino', 1, 'croupier', 'Croupier', 100, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":11,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":2,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":22,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":11,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":0,\"age_2\":0,\"glasses_2\":11,\"ears_2\":0,\"arms\":75,\"lipstick_1\":0,\"ears_1\":0,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":4,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":3,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":4,\"skin\":0,\"torso_2\":1,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":3,\"pants_1\":24}', '{\"torso_1\":124,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":15,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":6,\"ears_2\":0,\"arms\":14,\"lipstick_1\":0,\"ears_1\":0,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":4,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":45,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":2,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":42,\"pants_1\":65}'),
(292, 'casino', 2, 'boss', 'Manager', 0, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":29,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":31,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":4,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":1,\"lipstick_1\":0,\"ears_1\":0,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":4,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"torso_1\":124,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":15,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":6,\"ears_2\":0,\"arms\":14,\"lipstick_1\":0,\"ears_1\":0,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":4,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":45,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":2,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":42,\"pants_1\":65}'),
(293, 'vagos', 0, 'soldato', 'Soldat', 0, '{}', '{}'),
(294, 'vagos', 1, 'capo', 'Capo', 0, '{}', '{}'),
(295, 'vagos', 2, 'consigliere', 'Consigliere', 0, '{}', '{}'),
(296, 'vagos', 3, 'righthand', 'Bras-Droit', 0, '{}', '{}'),
(297, 'vagos', 0, 'soldato', 'Soldat', 0, '{}', '{}'),
(298, 'vagos', 1, 'capo', 'Capo', 0, '{}', '{}'),
(299, 'vagos', 2, 'consigliere', 'Consigliere', 0, '{}', '{}'),
(300, 'vagos', 3, 'righthand', 'Bras-Droit', 0, '{}', '{}'),
(301, 'vagos', 4, 'boss', 'Chef', 0, '{}', '{}'),
(302, 'mercenaire', 0, 'soldato', 'Soldat', 0, '{}', '{}'),
(303, 'mercenaire', 1, 'capo', 'Capo', 0, '{}', '{}'),
(304, 'mercenaire', 2, 'consigliere', 'Consigliere', 0, '{}', '{}'),
(305, 'mercenaire', 3, 'righthand', 'Bras-Droit', 0, '{}', '{}'),
(306, 'mercenaire', 4, 'boss', 'Chef', 0, '{}', '{}'),
(307, 'syndicat', 0, 'soldato', 'Soldat', 1, '{}', '{}'),
(308, 'syndicat', 1, 'capo', 'Capo', 1, '{}', '{}'),
(309, 'syndicat', 2, 'consigliere', 'Consigliere', 1, '{}', '{}'),
(310, 'syndicat', 3, 'righthand', 'Bras-Droit', 1, '{}', '{}'),
(311, 'syndicat', 4, 'boss', 'Chef', 1, '{}', '{}'),
(312, 'podolskaia', 0, 'soldato', 'Soldat', 1, '{}', '{}'),
(313, 'podolskaia', 1, 'capo', 'Capo', 0, '{}', '{}'),
(314, 'podolskaia', 2, 'consigliere', 'Consigliere', 0, '{}', '{}'),
(315, 'podolskaia', 3, 'righthand', 'Bras-Droit', 0, '{}', '{}'),
(316, 'podolskaia', 4, 'boss', 'Chef', 0, '{}', '{}');

-- --------------------------------------------------------

--
-- Structure de la table `licenses`
--

DROP TABLE IF EXISTS `licenses`;
CREATE TABLE IF NOT EXISTS `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `licenses`
--

INSERT INTO `licenses` (`type`, `label`) VALUES
('aircraft', 'Aircraft License'),
('dmv', 'Code de la route'),
('drive', 'Permis de conduire'),
('drive_bike', 'Permis moto'),
('drive_truck', 'Permis camion'),
('weapon', 'Permis Armes Blanche'),
('weapon2', 'PPA'),
('weapon3', 'Mercenaire');

-- --------------------------------------------------------

--
-- Structure de la table `open_car`
--

DROP TABLE IF EXISTS `open_car`;
CREATE TABLE IF NOT EXISTS `open_car` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `value` varchar(50) DEFAULT NULL,
  `got` varchar(50) DEFAULT NULL,
  `NB` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1914 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `owned_aircrafts`
--

DROP TABLE IF EXISTS `owned_aircrafts`;
CREATE TABLE IF NOT EXISTS `owned_aircrafts` (
  `owner` varchar(30) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'State of the aircraft',
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext,
  PRIMARY KEY (`plate`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `owned_boats`
--

DROP TABLE IF EXISTS `owned_boats`;
CREATE TABLE IF NOT EXISTS `owned_boats` (
  `owner` varchar(30) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'State of the boat',
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext,
  PRIMARY KEY (`plate`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `owned_properties`
--

DROP TABLE IF EXISTS `owned_properties`;
CREATE TABLE IF NOT EXISTS `owned_properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `rented` int(11) NOT NULL,
  `owner` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `owned_vehicles`
--

DROP TABLE IF EXISTS `owned_vehicles`;
CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `owner` varchar(22) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Etat de la voiture',
  `plate` varchar(12) NOT NULL,
  `impound` tinyint(1) DEFAULT 0,
  `vehicle` longtext,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) DEFAULT NULL,
  `stored` tinyint(1) NOT NULL DEFAULT '0',
  `fourrieremecano` tinyint(1) NOT NULL DEFAULT '0',
  `vehiclename` varchar(50) NOT NULL DEFAULT 'voiture',
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- --------------------------------------------------------

--
-- Structure de la table `phone_app_chat`
--

DROP TABLE IF EXISTS `phone_app_chat`;
CREATE TABLE IF NOT EXISTS `phone_app_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=824 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `phone_calls`
--

DROP TABLE IF EXISTS `phone_calls`;
CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(10) NOT NULL COMMENT 'Num tel proprio',
  `num` varchar(10) NOT NULL COMMENT 'Num reférence du contact',
  `incoming` int(11) NOT NULL COMMENT 'Défini si on est à l''origine de l''appels',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9792 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `phone_messages`
--

DROP TABLE IF EXISTS `phone_messages`;
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isRead` int(11) NOT NULL DEFAULT '0',
  `owner` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=50275 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `phone_users_contacts`
--

DROP TABLE IF EXISTS `phone_users_contacts`;
CREATE TABLE IF NOT EXISTS `phone_users_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1435 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `playerstattoos`
--

DROP TABLE IF EXISTS `playerstattoos`;
CREATE TABLE IF NOT EXISTS `playerstattoos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `tattoos` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=988 DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `properties`
--

DROP TABLE IF EXISTS `properties`;
CREATE TABLE IF NOT EXISTS `properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `entering` varchar(255) DEFAULT NULL,
  `exit` varchar(255) DEFAULT NULL,
  `inside` varchar(255) DEFAULT NULL,
  `outside` varchar(255) DEFAULT NULL,
  `ipls` varchar(255) DEFAULT '[]',
  `gateway` varchar(255) DEFAULT NULL,
  `is_single` int(11) DEFAULT NULL,
  `is_room` int(11) DEFAULT NULL,
  `is_gateway` int(11) DEFAULT NULL,
  `room_menu` varchar(255) DEFAULT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=504 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `properties`
--

INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
(36, 'Aqua3Apartment', 'Appartement Aqua 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_08_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.287,\"y\":331.084,\"z\":195.086}', 1300000),
(37, 'IntegrityWay', '4 Integrity Way', '{\"x\":-47.804,\"y\":-585.867,\"z\":36.956}', NULL, NULL, '{\"x\":-54.178,\"y\":-583.762,\"z\":35.798}', '[]', NULL, 0, 0, 1, NULL, 0),
(35, 'Aqua2Apartment', 'Appartement Aqua 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_08_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.658,\"y\":326.563,\"z\":186.313}', 1300000),
(34, 'Aqua1Apartment', 'Appartement Aqua 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_08_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.187,\"y\":328.47,\"z\":210.396}', 1300000),
(33, 'Regal3Apartment', 'Appartement Régal 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_07_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.087,\"y\":331.429,\"z\":195.123}', 1300000),
(32, 'Regal2Apartment', 'Appartement Régal 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_07_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.545,\"y\":326.659,\"z\":186.313}', 1300000),
(31, 'Regal1Apartment', 'Appartement Régal 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_07_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.956,\"y\":328.257,\"z\":210.396}', 1300000),
(30, 'Seductive3Apartment', 'Appartement Séduisant 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_06_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.3,\"y\":331.414,\"z\":195.085}', 1300000),
(29, 'Seductive2Apartment', 'Appartement Séduisant 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_06_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.655,\"y\":326.611,\"z\":186.313}', 1300000),
(27, 'Monochrome3Apartment', 'Appartement Monochrome 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_05_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.094,\"y\":330.976,\"z\":195.085}', 1300000),
(28, 'Seductive1Apartment', 'Appartement Séduisant 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_06_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.263,\"y\":328.104,\"z\":210.396}', 1300000),
(26, 'Monochrome2Apartment', 'Appartement Monochrome 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_05_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.692,\"y\":326.762,\"z\":186.313}', 1300000),
(25, 'Monochrome1Apartment', 'Appartement Monochrome 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_05_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.289,\"y\":328.086,\"z\":210.396}', 1300000),
(24, 'Sharp3Apartment', 'Appartement Persan 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_04_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.503,\"y\":331.318,\"z\":195.085}', 1300000),
(23, 'Sharp2Apartment', 'Appartement Persan 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_04_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.642,\"y\":326.497,\"z\":186.313}', 1300000),
(22, 'Sharp1Apartment', 'Appartement Persan 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_04_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.527,\"y\":327.89,\"z\":210.396}', 1300000),
(21, 'Vibrant3Apartment', 'Appartement Vibrant 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_03_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.525,\"y\":330.851,\"z\":195.085}', 1300000),
(20, 'Vibrant2Apartment', 'Appartement Vibrant 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_03_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.607,\"y\":327.344,\"z\":186.313}', 1300000),
(19, 'Vibrant1Apartment', 'Appartement Vibrant 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_03_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.885,\"y\":327.641,\"z\":210.396}', 1300000),
(18, 'Mody3Apartment', 'Appartement Mode 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_02_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.303,\"y\":330.932,\"z\":195.085}', 1300000),
(17, 'Mody2Apartment', 'Appartement Mode 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_02_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.297,\"y\":327.092,\"z\":186.313}', 1300000),
(16, 'Mody1Apartment', 'Appartement Mode 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_02_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.615,\"y\":327.878,\"z\":210.396}', 1300000),
(15, 'Modern3Apartment', 'Appartement Moderne 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_01_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.386,\"y\":330.782,\"z\":195.08}', 1300000),
(14, 'Modern2Apartment', 'Appartement Moderne 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_01_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.735,\"y\":326.757,\"z\":186.313}', 1300000),
(13, 'Modern1Apartment', 'Appartement Moderne 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_01_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.661,\"y\":327.672,\"z\":210.396}', 1300000),
(12, 'MiltonDrive', 'Milton Drive', '{\"x\":-775.17,\"y\":312.01,\"z\":84.658}', NULL, NULL, '{\"x\":-775.346,\"y\":306.776,\"z\":84.7}', '[]', NULL, 0, 0, 1, NULL, 0),
(11, 'TinselTowersApt12', 'Tinsel Towers, Apt 42', '{\"y\":37.025,\"z\":42.58,\"x\":-618.299}', '{\"y\":58.898,\"z\":97.2,\"x\":-603.301}', '{\"y\":58.941,\"z\":97.2,\"x\":-608.741}', '{\"y\":30.603,\"z\":42.524,\"x\":-620.017}', '[]', NULL, 1, 1, 0, '{\"x\":-622.173,\"y\":54.585,\"z\":96.599}', 1700000),
(10, 'HillcrestAvenue2868', '2868 Hillcrest Avenue', '{\"y\":620.494,\"z\":141.588,\"x\":-752.82}', '{\"y\":618.62,\"z\":143.153,\"x\":-759.317}', '{\"y\":617.629,\"z\":143.153,\"x\":-760.789}', '{\"y\":621.281,\"z\":141.254,\"x\":-750.919}', '[]', NULL, 1, 1, 0, '{\"x\":-762.504,\"y\":618.992,\"z\":135.53}', 1500000),
(9, 'HillcrestAvenue2874', '2874 Hillcrest Avenue', '{\"x\":-853.346,\"y\":696.678,\"z\":147.782}', '{\"y\":690.875,\"z\":151.86,\"x\":-859.961}', '{\"y\":688.361,\"z\":151.857,\"x\":-859.395}', '{\"y\":701.628,\"z\":147.773,\"x\":-855.007}', '[]', NULL, 1, 1, 0, '{\"x\":-858.543,\"y\":697.514,\"z\":144.253}', 1500000),
(8, 'MadWayneThunder', '2113 Mad Wayne Thunder', '{\"y\":454.955,\"z\":96.462,\"x\":-1294.433}', '{\"x\":-1289.917,\"y\":449.541,\"z\":96.902}', '{\"y\":446.322,\"z\":96.899,\"x\":-1289.642}', '{\"y\":455.453,\"z\":96.517,\"x\":-1298.851}', '[]', NULL, 1, 1, 0, '{\"x\":-1287.306,\"y\":455.901,\"z\":89.294}', 1500000),
(7, 'LowEndApartment', 'Appartement de base', '{\"y\":-1078.735,\"z\":28.4031,\"x\":292.528}', '{\"y\":-1007.152,\"z\":-102.002,\"x\":265.845}', '{\"y\":-1002.802,\"z\":-100.008,\"x\":265.307}', '{\"y\":-1078.669,\"z\":28.401,\"x\":296.738}', '[]', NULL, 1, 1, 0, '{\"x\":265.916,\"y\":-999.38,\"z\":-100.008}', 562500),
(6, 'HillcrestAvenue2862', '2862 Hillcrest Avenue', '{\"y\":596.58,\"z\":142.641,\"x\":-686.554}', '{\"y\":591.988,\"z\":144.392,\"x\":-681.728}', '{\"y\":590.608,\"z\":144.392,\"x\":-680.124}', '{\"y\":599.019,\"z\":142.059,\"x\":-689.492}', '[]', NULL, 1, 1, 0, '{\"x\":-680.46,\"y\":588.6,\"z\":136.769}', 1500000),
(5, 'WildOatsDrive', '3655 Wild Oats Drive', '{\"y\":502.696,\"z\":136.421,\"x\":-176.003}', '{\"y\":497.817,\"z\":136.653,\"x\":-174.349}', '{\"y\":495.069,\"z\":136.666,\"x\":-173.331}', '{\"y\":506.412,\"z\":135.0664,\"x\":-177.927}', '[]', NULL, 1, 1, 0, '{\"x\":-174.725,\"y\":493.095,\"z\":129.043}', 1500000),
(4, 'NorthConkerAvenue2044', '2044 North Conker Avenue', '{\"y\":440.8,\"z\":146.702,\"x\":346.964}', '{\"y\":437.456,\"z\":148.394,\"x\":341.683}', '{\"y\":435.626,\"z\":148.394,\"x\":339.595}', '{\"x\":350.535,\"y\":443.329,\"z\":145.764}', '[]', NULL, 1, 1, 0, '{\"x\":337.726,\"y\":436.985,\"z\":140.77}', 1500000),
(3, 'RichardMajesticApt2', 'Richard Majestic, Apt 2', '{\"y\":-379.165,\"z\":37.961,\"x\":-936.363}', '{\"y\":-365.476,\"z\":113.274,\"x\":-913.097}', '{\"y\":-367.637,\"z\":113.274,\"x\":-918.022}', '{\"y\":-382.023,\"z\":37.961,\"x\":-943.626}', '[]', NULL, 1, 1, 0, '{\"x\":-927.554,\"y\":-377.744,\"z\":112.674}', 1700000),
(2, 'NorthConkerAvenue2045', '2045 North Conker Avenue', '{\"x\":372.796,\"y\":428.327,\"z\":144.685}', '{\"x\":373.548,\"y\":422.982,\"z\":144.907},', '{\"y\":420.075,\"z\":145.904,\"x\":372.161}', '{\"x\":372.454,\"y\":432.886,\"z\":143.443}', '[]', NULL, 1, 1, 0, '{\"x\":377.349,\"y\":429.422,\"z\":137.3}', 1500000),
(1, 'WhispymoundDrive', '2677 Whispymound Drive', '{\"y\":564.89,\"z\":182.959,\"x\":119.384}', '{\"x\":117.347,\"y\":559.506,\"z\":183.304}', '{\"y\":557.032,\"z\":183.301,\"x\":118.037}', '{\"y\":567.798,\"z\":182.131,\"x\":119.249}', '[]', NULL, 1, 1, 0, '{\"x\":118.748,\"y\":566.573,\"z\":175.697}', 1500000),
(38, 'IntegrityWay28', '4 Integrity Way - Apt 28', NULL, '{\"x\":-31.409,\"y\":-594.927,\"z\":79.03}', '{\"x\":-26.098,\"y\":-596.909,\"z\":79.03}', NULL, '[]', 'IntegrityWay', 0, 1, 0, '{\"x\":-11.923,\"y\":-597.083,\"z\":78.43}', 1700000),
(39, 'IntegrityWay30', '4 Integrity Way - Apt 30', NULL, '{\"x\":-17.702,\"y\":-588.524,\"z\":89.114}', '{\"x\":-16.21,\"y\":-582.569,\"z\":89.114}', NULL, '[]', 'IntegrityWay', 0, 1, 0, '{\"x\":-26.327,\"y\":-588.384,\"z\":89.123}', 1700000),
(40, 'DellPerroHeights', 'Dell Perro Heights', '{\"x\":-1447.06,\"y\":-538.28,\"z\":33.74}', NULL, NULL, '{\"x\":-1440.022,\"y\":-548.696,\"z\":33.74}', '[]', NULL, 0, 0, 1, NULL, 0),
(41, 'DellPerroHeightst4', 'Dell Perro Heights - Apt 28', NULL, '{\"x\":-1452.125,\"y\":-540.591,\"z\":73.044}', '{\"x\":-1455.435,\"y\":-535.79,\"z\":73.044}', NULL, '[]', 'DellPerroHeights', 0, 1, 0, '{\"x\":-1467.058,\"y\":-527.571,\"z\":72.443}', 1700000),
(42, 'DellPerroHeightst7', 'Dell Perro Heights - Apt 30', NULL, '{\"x\":-1451.562,\"y\":-523.535,\"z\":55.928}', '{\"x\":-1456.02,\"y\":-519.209,\"z\":55.929}', NULL, '[]', 'DellPerroHeights', 0, 1, 0, '{\"x\":-1457.026,\"y\":-530.219,\"z\":55.937}', 1700000),
(69, 'MBWExecutive Contrast', 'MBW Executive Contrast', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_02a\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(68, 'MBWExecutiveCool', 'MBW Executive Cool', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_02c\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(67, 'MBWExecutiveRich', 'MBW Executive Rich', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_02b\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(66, 'MBWOldSpiceVintage', 'MBW Old Spice Vintage', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_01c\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(65, 'MBWOldSpiceClassical', 'MBW Old Spice Classical', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_01b\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(63, 'MazeBankWest', 'Maze Bank West', '{\"x\":-1379.58,\"y\":-499.63,\"z\":32.22}', NULL, NULL, '{\"x\":-1378.95,\"y\":-502.82,\"z\":32.22}', '[]', NULL, 0, 0, 1, NULL, 0),
(64, 'MBWOldSpiceWarm', 'MBW Old Spice Warm', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_01a\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(62, 'LBPowerBrokerPolished', 'LB Power Broker Polished', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_03c\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(61, 'LBPowerBrokerConservative', 'LB Power Broker Conservative', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_03b\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(60, 'LBPowerBrokerIce', 'LB Power Broker Ice', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_03a\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(59, 'LBExecutiveContrast', 'LB Executive Contrast', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_02a\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(58, 'LBExecutiveCool', 'LB Executive Cool', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_02c\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(57, 'LBExecutiveRich', 'LB Executive Rich', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_02b\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(56, 'LBOldSpiceVintage', 'LB Old Spice Vintage', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_01c\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(55, 'LBOldSpiceClassical', 'LB Old Spice Classical', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_01b\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(54, 'LBOldSpiceWarm', 'LB Old Spice Warm', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_01a\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(53, 'LomBank', 'Lom Bank', '{\"x\":-1581.36,\"y\":-558.23,\"z\":34.07}', NULL, NULL, '{\"x\":-1583.60,\"y\":-555.12,\"z\":34.07}', '[]', NULL, 0, 0, 1, NULL, 0),
(52, 'PowerBrokerPolished', 'Power Broker Polished', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_03c\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(51, 'PowerBrokerConservative', 'Power Broker Conservative', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_03b\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(50, 'PowerBrokerIce', 'Power Broker Ice', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_03a\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(49, 'ExecutiveContrast', 'Executive Contrast', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_02a\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(48, 'ExecutiveCool', 'Executive Cool', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_02c\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(47, 'ExecutiveRich', 'Executive Rich', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_02b\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(46, 'OldSpiceVintage', 'Old Spice Vintage', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_01c\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(45, 'OldSpiceClassical', 'Old Spice Classical', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_01b\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(43, 'MazeBankBuilding', 'Maze Bank Building', '{\"x\":-79.18,\"y\":-795.92,\"z\":43.35}', NULL, NULL, '{\"x\":-72.50,\"y\":-786.92,\"z\":43.40}', '[]', NULL, 0, 0, 1, NULL, 0),
(44, 'OldSpiceWarm', 'Old Spice Warm', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_01a\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(70, 'MBWPowerBrokerIce', 'MBW Power Broker Ice', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_03a\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(71, 'MBWPowerBrokerConvservative', 'MBW Power Broker Convservative', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_03b\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(72, 'MBWPowerBrokerPolished', 'MBW Power Broker Polished', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_03c\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(496, 'Bay City AvenueMotel1', 'Bay City Avenue', '{\"x\":-1308.9658203125,\"y\":-931.15521240234,\"z\":15.36}', '{\"x\":151.37,\"y\":-1007.54,\"z\":-99.97}', '{\"x\":151.37,\"y\":-1007.54,\"z\":-99.97}', '{\"x\":-1308.9658203125,\"y\":-931.15521240234,\"z\":16.357076644897}', '[\"hei_hw1_blimp_interior_v_motel_mp_milo_\"]', NULL, 1, 0, NULL, '{\"x\":152.36,\"y\":-1000.68,\"z\":-100.0}', 43750),
(497, 'Bay City AvenueMotel2', 'Bay City Avenue', '{\"x\":-1310.7575683594,\"y\":-931.86700439453,\"z\":15.36}', '{\"x\":151.37,\"y\":-1007.54,\"z\":-99.97}', '{\"x\":151.37,\"y\":-1007.54,\"z\":-99.97}', '{\"x\":-1310.7575683594,\"y\":-931.86700439453,\"z\":16.357303619385}', '[\"hei_hw1_blimp_interior_v_motel_mp_milo_\"]', NULL, 1, 0, NULL, '{\"x\":152.36,\"y\":-1000.68,\"z\":-100.0}', 43750),
(498, 'Bay City AvenueMotel3', 'Bay City Avenue', '{\"x\":-1317.9606933594,\"y\":-934.37451171875,\"z\":15.36}', '{\"x\":151.37,\"y\":-1007.54,\"z\":-99.97}', '{\"x\":151.37,\"y\":-1007.54,\"z\":-99.97}', '{\"x\":-1317.9606933594,\"y\":-934.37451171875,\"z\":16.358287811279}', '[\"hei_hw1_blimp_interior_v_motel_mp_milo_\"]', NULL, 1, 0, NULL, '{\"x\":152.36,\"y\":-1000.68,\"z\":-100.0}', 43750),
(499, 'Bay City AvenueMotel4', 'Bay City Avenue', '{\"x\":-1319.7747802734,\"y\":-935.06658935547,\"z\":15.36}', '{\"x\":151.37,\"y\":-1007.54,\"z\":-99.97}', '{\"x\":151.37,\"y\":-1007.54,\"z\":-99.97}', '{\"x\":-1319.7747802734,\"y\":-935.06658935547,\"z\":16.35852432251}', '[\"hei_hw1_blimp_interior_v_motel_mp_milo_\"]', NULL, 1, 0, NULL, '{\"x\":152.36,\"y\":-1000.68,\"z\":-100.0}', 43750),
(500, 'Bay City AvenueMotel5', 'Bay City Avenue', '{\"x\":-1329.3909912109,\"y\":-938.58111572266,\"z\":15.36}', '{\"x\":151.37,\"y\":-1007.54,\"z\":-99.97}', '{\"x\":151.37,\"y\":-1007.54,\"z\":-99.97}', '{\"x\":-1329.3909912109,\"y\":-938.58111572266,\"z\":15.357588768005}', '[\"hei_hw1_blimp_interior_v_motel_mp_milo_\"]', NULL, 1, 0, NULL, '{\"x\":152.36,\"y\":-1000.68,\"z\":-100.0}', 43750),
(501, 'Bay City AvenueMotel6', 'Bay City Avenue', '{\"x\":-1331.1315917969,\"y\":-939.28826904297,\"z\":15.36}', '{\"x\":151.37,\"y\":-1007.54,\"z\":-99.97}', '{\"x\":151.37,\"y\":-1007.54,\"z\":-99.97}', '{\"x\":-1331.1315917969,\"y\":-939.28826904297,\"z\":15.357841491699}', '[\"hei_hw1_blimp_interior_v_motel_mp_milo_\"]', NULL, 1, 0, NULL, '{\"x\":152.36,\"y\":-1000.68,\"z\":-100.0}', 43750),
(502, 'Vespucci BoulevardMotel7', 'Vespucci Boulevard', '{\"x\":-1339.1380615234,\"y\":-941.53643798828,\"z\":15.36}', '{\"x\":151.37,\"y\":-1007.54,\"z\":-99.97}', '{\"x\":151.37,\"y\":-1007.54,\"z\":-99.97}', '{\"x\":-1339.1380615234,\"y\":-941.53643798828,\"z\":15.357811927795}', '[\"hei_hw1_blimp_interior_v_motel_mp_milo_\"]', NULL, 1, 0, NULL, '{\"x\":152.36,\"y\":-1000.68,\"z\":-100.0}', 43750),
(503, 'Vespucci BoulevardMotel8', 'Vespucci Boulevard', '{\"x\":-1338.0535888672,\"y\":-941.72857666016,\"z\":15.36}', '{\"x\":151.37,\"y\":-1007.54,\"z\":-99.97}', '{\"x\":151.37,\"y\":-1007.54,\"z\":-99.97}', '{\"x\":-1338.0535888672,\"y\":-941.72857666016,\"z\":15.358644485474}', '[\"hei_hw1_blimp_interior_v_motel_mp_milo_\"]', NULL, 1, 0, NULL, '{\"x\":152.36,\"y\":-1000.68,\"z\":-100.0}', 43750);

-- --------------------------------------------------------

--
-- Structure de la table `quincaillerie`
--

DROP TABLE IF EXISTS `quincaillerie`;
CREATE TABLE IF NOT EXISTS `quincaillerie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `quincaillerie`
--

INSERT INTO `quincaillerie` (`id`, `name`, `item`, `price`) VALUES
(23, 'LSQuincaillerie', 'tenuebraquage', 1500),
(24, 'LSQuincaillerie', 'tenuecasa', 1500),
(25, 'LSQuincaillerie', 'clip', 750),
(32, 'LSQuincaillerie', 'headbag', 2500),
(34, 'LSQuincaillerie', 'COMPONENT_KNUCKLE_VARMOD_PLAYER', 11500),
(35, 'LSQuincaillerie', 'COMPONENT_KNUCKLE_VARMOD_LOVE', 12000),
(36, 'LSQuincaillerie', 'COMPONENT_KNUCKLE_VARMOD_DOLLAR', 12500),
(37, 'LSQuincaillerie', 'COMPONENT_KNUCKLE_VARMOD_VAGOS', 13000),
(38, 'LSQuincaillerie', 'COMPONENT_KNUCKLE_VARMOD_HATE', 13500),
(39, 'LSQuincaillerie', 'COMPONENT_KNUCKLE_VARMOD_DIAMOND', 14000),
(40, 'LSQuincaillerie', 'COMPONENT_KNUCKLE_VARMOD_PIMP', 14500),
(41, 'LSQuincaillerie', 'COMPONENT_KNUCKLE_VARMOD_KING', 15000),
(42, 'LSQuincaillerie', 'COMPONENT_KNUCKLE_VARMOD_BALLAS', 15500),
(43, 'LSQuincaillerie', 'COMPONENT_SWITCHBLADE_VARMOD_VAR1', 14500),
(44, 'LSQuincaillerie', 'COMPONENT_SWITCHBLADE_VARMOD_VAR2', 15000),
(45, 'LSQuincaillerie', 'COMPONENT_REVOLVER_VARMOD_BOSS', 14500),
(46, 'LSQuincaillerie', 'COMPONENT_REVOLVER_VARMOD_GOON', 15500),
(47, 'LSQuincaillerie', 'COMPONENT_VARMOD_LOWRIDER', 25000),
(48, 'LSQuincaillerie', 'COMPONENT_VARMOD_LUXE', 50000),
(49, 'LSQuincaillerie', 'COMPONENT_AT_PI_SUPP', 15000),
(50, 'LSQuincaillerie', 'COMPONENT_AT_AR_SUPP_02', 25000),
(51, 'LSQuincaillerie', 'COMPONENT_AT_PI_FLSH', 10000),
(52, 'LSQuincaillerie', 'COMPONENT_AT_AR_FLSH', 15000),
(53, 'LSQuincaillerie', 'COMPONENT_AT_AR_AFGRIP', 30000),
(54, 'LSQuincaillerie', 'COMPONENT_AT_SCOPE_MACRO', 35000),
(55, 'LSQuincaillerie', 'COMPONENT_AT_PI_CLIP_02', 30000),
(56, 'LSQuincaillerie', 'COMPONENT_AT_AR_CLIP_02', 40000),
(57, 'LSQuincaillerie', 'COMPONENT_AT_AR_CLIP_03', 60000),
(58, 'LSQuincaillerie', 'TINT_01', 5500),
(59, 'LSQuincaillerie', 'TINT_02', 5500),
(60, 'LSQuincaillerie', 'TINT_03', 5500),
(61, 'LSQuincaillerie', 'TINT_04', 5500),
(62, 'LSQuincaillerie', 'TINT_06', 5500),
(63, 'LSQuincaillerie', 'TINT_07', 5500);

-- --------------------------------------------------------

--
-- Structure de la table `rented_aircrafts`
--

DROP TABLE IF EXISTS `rented_aircrafts`;
CREATE TABLE IF NOT EXISTS `rented_aircrafts` (
  `vehicle` varchar(60) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `base_price` int(11) NOT NULL,
  `rent_price` int(11) NOT NULL,
  `owner` varchar(30) NOT NULL,
  PRIMARY KEY (`plate`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `rented_boats`
--

DROP TABLE IF EXISTS `rented_boats`;
CREATE TABLE IF NOT EXISTS `rented_boats` (
  `vehicle` varchar(60) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `base_price` int(11) NOT NULL,
  `rent_price` int(11) NOT NULL,
  `owner` varchar(30) NOT NULL,
  PRIMARY KEY (`plate`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `rented_vehicles`
--

DROP TABLE IF EXISTS `rented_vehicles`;
CREATE TABLE IF NOT EXISTS `rented_vehicles` (
  `vehicle` varchar(60) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `base_price` int(11) NOT NULL,
  `rent_price` int(11) NOT NULL,
  `owner` varchar(30) NOT NULL,
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `shops`
--

DROP TABLE IF EXISTS `shops`;
CREATE TABLE IF NOT EXISTS `shops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `store` varchar(100) NOT NULL,
  `item` varchar(100) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `shops`
--

INSERT INTO `shops` (`id`, `store`, `item`, `price`) VALUES
(1, 'TwentyFourSeven', 'bread', 5),
(2, 'TwentyFourSeven', 'water', 8),
(3, 'RobsLiquor', 'bread', 5),
(4, 'RobsLiquor', 'water', 8),
(5, 'LTDgasoline', 'bread', 5),
(6, 'LTDgasoline', 'water', 8),
(7, 'LTDgasoline', 'croquettes', 75),
(8, 'TwentyFourSeven', 'chocolat', 15),
(9, 'TwentyFourSeven', 'beef', 50),
(10, 'TwentyFourSeven', 'hamburger', 40),
(11, 'TwentyFourSeven', 'cupcake', 15),
(13, 'TwentyFourSeven', 'cocacola', 35),
(14, 'TwentyFourSeven', 'breadsaucisson', 25),
(15, 'TwentyFourSeven', 'hamburgerplate', 30),
(16, 'TwentyFourSeven', 'soda', 25),
(17, 'RobsLiquor', 'chocolat', 15),
(18, 'RobsLiquor', 'beef', 50),
(19, 'RobsLiquor', 'hamburger', 50),
(20, 'RobsLiquor', 'cupcake', 15),
(21, 'RobsLiquor', 'cocacola', 35),
(22, 'RobsLiquor', 'breadsaucisson', 25),
(23, 'RobsLiquor', 'hamburgerplate', 40),
(24, 'RobsLiquor', 'soda', 25),
(25, 'LTDgasoline', 'chocolat', 15),
(26, 'LTDgasoline', 'beef', 50),
(27, 'LTDgasoline', 'hamburger', 50),
(28, 'LTDgasoline', 'cupcake', 15),
(29, 'LTDgasoline', 'cocacola', 35),
(30, 'LTDgasoline', 'breadsaucisson', 25),
(31, 'LTDgasoline', 'hamburgerplate', 40),
(32, 'LTDgasoline', 'soda', 25),
(48, 'LTDgasoline', 'croquettes', 100),
(49, 'LTDgasoline', 'croquettes', 100),
(50, 'LTDgasoline', 'croquettes', 100);

-- --------------------------------------------------------

--
-- Structure de la table `society_moneywash`
--

DROP TABLE IF EXISTS `society_moneywash`;
CREATE TABLE IF NOT EXISTS `society_moneywash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `society` varchar(60) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `trunk_inventory`
--

DROP TABLE IF EXISTS `trunk_inventory`;
CREATE TABLE IF NOT EXISTS `trunk_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(8) NOT NULL,
  `data` text NOT NULL,
  `owned` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plate` (`plate`)
) ENGINE=InnoDB AUTO_INCREMENT=1920 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `twitter_accounts`
--

DROP TABLE IF EXISTS `twitter_accounts`;
CREATE TABLE IF NOT EXISTS `twitter_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `twitter_likes`
--

DROP TABLE IF EXISTS `twitter_likes`;
CREATE TABLE IF NOT EXISTS `twitter_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_twitter_likes_twitter_accounts` (`authorId`),
  KEY `FK_twitter_likes_twitter_tweets` (`tweetId`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `twitter_tweets`
--

DROP TABLE IF EXISTS `twitter_tweets`;
CREATE TABLE IF NOT EXISTS `twitter_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `likes` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_twitter_tweets_twitter_accounts` (`authorId`)
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_bin DEFAULT '',
  `skin` longtext COLLATE utf8mb4_bin,
  `job` varchar(255) COLLATE utf8mb4_bin DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT '0',
  `job2` varchar(255) COLLATE utf8mb4_bin DEFAULT 'unemployed2',
  `job2_grade` int(11) DEFAULT '0',
  `org` varchar(255) COLLATE utf8mb4_bin DEFAULT 'freecity',
  `org_gradeorg` int(11) DEFAULT '0',
  `loadout` longtext COLLATE utf8mb4_bin,
  `position` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `permission_level` int(11) DEFAULT NULL,
  `group` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `firstname` varchar(50) COLLATE utf8mb4_bin DEFAULT '',
  `lastname` varchar(50) COLLATE utf8mb4_bin DEFAULT '',
  `dateofbirth` varchar(25) COLLATE utf8mb4_bin DEFAULT '',
  `sex` varchar(10) COLLATE utf8mb4_bin DEFAULT '',
  `height` varchar(5) COLLATE utf8mb4_bin DEFAULT '',
  `status` longtext COLLATE utf8mb4_bin,
  `isDead` bit(1) DEFAULT b'0',
  `last_property` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `animal` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `vote` varchar(254) COLLATE utf8mb4_bin DEFAULT NULL,
  `jail` int(11) NOT NULL DEFAULT '0',
  `phone_number` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL,
  `is_dead` tinyint(1) DEFAULT '0',
  `skills` longtext COLLATE utf8mb4_bin,
  `money` int(11) DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `user_accounts`
--

DROP TABLE IF EXISTS `user_accounts`;
CREATE TABLE IF NOT EXISTS `user_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `money` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `user_lastcharacter`
--

DROP TABLE IF EXISTS `user_lastcharacter`;
CREATE TABLE IF NOT EXISTS `user_lastcharacter` (
  `steamid` varchar(255) NOT NULL,
  `charid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `user_licenses`
--

DROP TABLE IF EXISTS `user_licenses`;
CREATE TABLE IF NOT EXISTS `user_licenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(60) NOT NULL,
  `owner` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=911 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `vehicles`
--

INSERT INTO `vehicles` (`name`, `model`, `price`, `category`) VALUES
('BMW 440i', '440i', 325000, 'import'),
('450crf', '450crf', 115000, 'import'),
('McLaren 720s', '720s', 750000, 'import'),
('Porsche 911tbs', '911turboS', 700000, 'import'),
('Mercedes A45 AMG', 'a45', 300000, 'import'),
('Adder', 'adder', 533333, 'super'),
('Akuma', 'AKUMA', 20000, 'motorcycles'),
('Alpha', 'alpha', 80000, 'sports'),
('Asea', 'asea', 26666, 'sedans'),
('Audi RS6', 'AUDIRS6TK', 350000, 'import'),
('Autarch', 'autarch', 386666, 'super'),
('Baller Sport', 'baller3', 104000, 'suvs'),
('Banshee', 'banshee', 120000, 'sports'),
('Banshee 900R', 'banshee2', 200000, 'super'),
('Bati 801', 'bati', 53333, 'motorcycles'),
('Bati 801RR', 'bati2', 60000, 'motorcycles'),
('Bestia GTS', 'bestiagts', 130000, 'sports'),
('BF400', 'bf400', 50000, 'motorcycles'),
('Bifta', 'bifta', 48000, 'offroad'),
('Blade', 'blade', 20000, 'muscle'),
('Blazer', 'blazer', 48000, 'offroad'),
('Blazer Sport', 'blazer4', 40000, 'offroad'),
('BMX (velo)', 'bmx', 200, 'motorcycles'),
('1969 Ford Mustang Boss 302', 'BOSS302', 200000, 'import'),
('Brawler', 'brawler', 100000, 'offroad'),
('Brioso R/A', 'brioso', 20000, 'compacts'),
('Btype', 'btype', 60000, 'sportsclassics'),
('Btype Hotroad', 'btype2', 124000, 'sportsclassics'),
('Btype Luxe', 'btype3', 87500, 'sportsclassics'),
('Buccaneer', 'buccaneer', 50000, 'muscle'),
('Buccaneer Rider', 'buccaneer2', 70000, 'muscle'),
('Buffalo S', 'buffalo2', 52000, 'sports'),
('Bullet', 'bullet', 280000, 'super'),
('Burrito', 'burrito3', 48000, 'vans'),
('Mercedes C63', 'c63', 300000, 'import'),
('Camper', 'camper', 80000, 'vans'),
('Carbonizzare', 'carbonizzare', 145000, 'sports'),
('Carbon RS', 'carbonrs', 44000, 'motorcycles'),
('Casco', 'casco', 80000, 'sportsclassics'),
('Cheetah', 'cheetah', 333333, 'super'),
('Chino', 'chino', 48000, 'muscle'),
('Chino Luxe', 'chino2', 70000, 'muscle'),
('Cliffhanger', 'cliffhanger', 100000, 'motorcycles'),
('Mercedes CLS63', 'cls2015', 440000, 'import'),
('Cognoscenti Cabrio', 'cogcabrio', 52000, 'coupes'),
('Cognoscenti', 'cognoscenti', 20000, 'sedans'),
('Comet', 'comet2', 130000, 'sports'),
('Comet Safari', 'comet4', 166666, 'sports'),
('Comet 5', 'comet5', 200000, 'sports'),
('Coquette', 'coquette', 130000, 'sports'),
('Coquette Classic', 'coquette2', 100000, 'sportsclassics'),
('Coquette BlackFin', 'coquette3', 136666, 'muscle'),
('Daemon', 'daemon', 64000, 'motorcycles'),
('Daemon High', 'daemon2', 60000, 'motorcycles'),
('Defiler', 'defiler', 64000, 'motorcycles'),
('JEEP TrackHawk', 'demonhawk', 400000, 'import'),
('Dominator', 'dominator', 52000, 'muscle'),
('Dominator GTX', 'dominator3', 120000, 'muscle'),
('Dubsta', 'dubsta', 120000, 'suvs'),
('Dubsta Luxuary', 'dubsta2', 100000, 'suvs'),
('Bubsta 6x6', 'dubsta3', 180000, 'offroad'),
('Dukes', 'dukes', 60000, 'muscle'),
('Dune Buggy', 'dune', 86000, 'offroad'),
('Elegy', 'elegy', 120000, 'sports'),
('Elegy Sport', 'elegy2', 144000, 'sports'),
('Emperor', 'emperor', 5000, 'sedans'),
('Enduro', 'enduro', 48000, 'motorcycles'),
('Entity XXR', 'entity2', 483333, 'sports'),
('Esskey', 'esskey', 30000, 'motorcycles'),
('Faction Rider', 'faction2', 70000, 'muscle'),
('Faction XL', 'faction3', 85000, 'muscle'),
('Faggio', 'faggio', 2000, 'motorcycles'),
('Vespa', 'faggio2', 2200, 'motorcycles'),
('Felon', 'felon', 73333, 'coupes'),
('Felon GT', 'felon2', 60000, 'coupes'),
('Feltzer', 'feltzer2', 110000, 'sports'),
('Stirling GT', 'feltzer3', 100000, 'sportsclassics'),
('Fixter (velo)', 'fixter', 5000, 'motorcycles'),
('Fugitive', 'fugitive', 50000, 'sedans'),
('Gauntlet', 'gauntlet', 120000, 'muscle'),
('Gang Burrito', 'gburrito', 0, 'vans'),
('Burrito', 'gburrito2', 80000, 'vans'),
('Glendale', 'glendale', 64000, 'sedans'),
('Suzuki GSX-R', 'gsxr', 165000, 'import'),
('GT 500', 'gt500', 220000, 'sportsclassics'),
('Guardian', 'guardian', 120000, 'offroad'),
('Hakuchou', 'hakuchou', 83333, 'motorcycles'),
('Hermes', 'hermes', 140000, 'muscle'),
('Hexer', 'hexer', 48000, 'motorcycles'),
('Hotknife', 'hotknife', 100000, 'muscle'),
('Huntley S', 'huntley', 80000, 'suvs'),
('Hustler', 'hustler', 70000, 'muscle'),
('Issi', 'issi2', 15000, 'compacts'),
('Itali GTB', 'italigtb', 400000, 'super'),
('Itali GTB Custom', 'italigtb2', 416000, 'super'),
('Itali GTO', 'italigto', 650000, 'sports'),
('Jackal', 'jackal', 70000, 'coupes'),
('Jester', 'jester', 140000, 'sports'),
('Journey', 'journey', 13000, 'vans'),
('Kamacho', 'kamacho', 200000, 'offroad'),
('Khamelion', 'khamelion', 100000, 'sports'),
('Kuruma', 'kuruma', 60000, 'sports'),
('BMW M4F82', 'm4f82', 400000, 'import'),
('BMW M5E60', 'm5e60', 475000, 'import'),
('Mamba', 'mamba', 140000, 'sports'),
('Manana', 'manana', 80000, 'sportsclassics'),
('Manchez', 'manchez', 15000, 'motorcycles'),
('Massacro', 'massacro', 160000, 'sports'),
('Mesa', 'mesa', 64000, 'suvs'),
('Mesa Trail', 'mesa3', 80000, 'suvs'),
('Monroe', 'monroe', 80000, 'sportsclassics'),
('Pfister Neon', 'neon', 233333, 'sports'),
('Nero', 'nero', 500000, 'super'),
('Nero Custom', 'nero2', 533333, 'super'),
('Kawasaki Ninja H2R', 'nh2r', 225000, 'import'),
('Nightblade', 'nightblade', 60000, 'motorcycles'),
('Nightshade', 'nightshade', 120000, 'muscle'),
('9F', 'ninef', 100000, 'sports'),
('9F Cabrio', 'ninef2', 120000, 'sports'),
('Oracle XS', 'oracle2', 60000, 'coupes'),
('Osiris', 'osiris', 440000, 'super'),
('Porsche Panamera Turbo', 'panamera17turbo', 750000, 'import'),
('Panto', 'panto', 10000, 'compacts'),
('Paradise', 'paradise', 80000, 'vans'),
('Patriot', 'patriot', 100000, 'suvs'),
('Phoenix', 'phoenix', 70000, 'muscle'),
('Picador', 'picador', 20000, 'muscle'),
('Pigalle', 'pigalle', 220000, 'sportsclassics'),
('Prairie', 'prairie', 23333, 'compacts'),
('Premier', 'premier', 14000, 'sedans'),
('Primo Custom', 'primo2', 60000, 'sedans'),
('X80 Proto', 'prototipo', 800000, 'super'),
('Coil Raiden', 'raiden', 166666, 'sports'),
('Rapid GT3', 'rapidgt3', 80050, 'sportsclassics'),
('Reaper', 'reaper', 500000, 'super'),
('Rebel', 'rebel2', 70000, 'offroad'),
('Retinue', 'retinue', 120000, 'sportsclassics'),
('Rocoto', 'rocoto', 102000, 'suvs'),
('Ruffian', 'ruffian', 48000, 'motorcycles'),
('Rumpo Trail', 'rumpo3', 48000, 'vans'),
('Mercedes S63 AMG', 's63amg', 300000, 'import'),
('Sabre Turbo', 'sabregt', 70000, 'muscle'),
('Sabre GT', 'sabregt2', 85000, 'muscle'),
('Sanctus', 'sanctus', 60000, 'motorcycles'),
('Sandking', 'sandking', 120000, 'offroad'),
('Savestra', 'savestra', 60000, 'sportsclassics'),
('Schafter V12', 'schafter3', 80000, 'sports'),
('Scorcher (velo)', 'scorcher', 6400, 'motorcycles'),
('Sentinel', 'sentinel', 53333, 'coupes'),
('Sentinel XS', 'sentinel2', 60000, 'coupes'),
('Sentinel3', 'sentinel3', 120000, 'sports'),
('Seven 70', 'seven70', 110000, 'sports'),
('Sovereign', 'sovereign', 80000, 'motorcycles'),
('Stinger', 'stinger', 120000, 'sportsclassics'),
('Stinger GT', 'stingergt', 160000, 'sportsclassics'),
('Streiter', 'streiter', 136000, 'sports'),
('Sultan', 'sultan', 60000, 'sports'),
('Sultan RS', 'sultanrs', 190000, 'super'),
('Surano', 'surano', 220000, 'sports'),
('Surfer', 'surfer', 64000, 'vans'),
('T20', 't20', 483333, 'super'),
('Tailgater', 'tailgater', 48000, 'sedans'),
('Tampa', 'tampa', 48000, 'muscle'),
('Tempesta', 'tempesta', 506666, 'super'),
('Pegassi Toros', 'toros', 233333, 'suvs'),
('Tri bike (velo)', 'tribike3', 5400, 'motorcycles'),
('Turismo R', 'turismor', 500000, 'super'),
('Vacca', 'vacca', 160000, 'super'),
('Vader', 'vader', 48000, 'motorcycles'),
('Vigero', 'vigero', 50000, 'muscle'),
('Virgo', 'virgo', 20000, 'muscle'),
('Viseris', 'viseris', 120000, 'sportsclassics'),
('Visione', 'visione', 453333, 'super'),
('Voltic', 'voltic', 190000, 'super'),
('Voodoo', 'voodoo', 64000, 'muscle'),
('2014 S-Class W222 WALD Black Bison', 'w222wald', 600000, 'import'),
('Warrener', 'warrener', 64000, 'sedans'),
('Windsor', 'windsor', 300000, 'coupes'),
('Windsor Drop', 'windsor2', 340000, 'coupes'),
('Woflsbane', 'wolfsbane', 64000, 'motorcycles'),
('BMW X6M', 'x6m', 320000, 'import'),
('Ocelot XA-21', 'xa21', 466666, 'super'),
('XLS', 'xls', 80000, 'suvs'),
('Yosemite', 'yosemite', 60000, 'muscle'),
('Z190', 'z190', 85000, 'sportsclassics'),
('Zentorno', 'zentorno', 466666, 'super'),
('Zion', 'zion', 60000, 'coupes'),
('Zion Cabrio', 'zion2', 66666, 'coupes'),
('Zombie', 'zombiea', 64000, 'motorcycles'),
('Zombie Luxuary', 'zombieb', 48000, 'motorcycles'),
('Z-Type', 'ztype', 200000, 'sportsclassics');

-- --------------------------------------------------------

--
-- Structure de la table `vehicles_for_sale`
--

DROP TABLE IF EXISTS `vehicles_for_sale`;
CREATE TABLE IF NOT EXISTS `vehicles_for_sale` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seller` varchar(50) NOT NULL,
  `vehicleProps` longtext NOT NULL,
  `price` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `vehicle_categories`
--

DROP TABLE IF EXISTS `vehicle_categories`;
CREATE TABLE IF NOT EXISTS `vehicle_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `vehicle_categories`
--

INSERT INTO `vehicle_categories` (`name`, `label`) VALUES
('compacts', 'Compacts'),
('coupes', 'Coupés'),
('import', 'Voiture Imports'),
('motorcycles', 'Motos'),
('muscle', 'Muscle'),
('nissan', 'Nissan'),
('offroad', 'Off Road'),
('sedans', 'Sedans'),
('sports', 'Sports'),
('sportsclassics', 'Sports Classics'),
('super', 'Super'),
('suvs', 'SUVs'),
('vans', 'Vans');

-- --------------------------------------------------------

--
-- Structure de la table `weashops`
--

DROP TABLE IF EXISTS `weashops`;
CREATE TABLE IF NOT EXISTS `weashops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `weashops`
--

INSERT INTO `weashops` (`id`, `name`, `item`, `price`) VALUES
(7, 'BlackWeashop', 'WEAPON_COMBATPISTOL', 40000),
(8, 'BlackWeashop', 'WEAPON_STUNGUN', 5000),
(9, 'BlackWeashop', 'WEAPON_SAWNOFFSHOTGUN', 175000),
(10, 'BlackWeashop', 'WEAPON_MICROSMG', 110000),
(11, 'BlackWeashop', 'WEAPON_HEAVYSHOTGUN', 155000),
(12, 'BlackWeashop', 'WEAPON_COMPACTRIFLE', 180000),
(13, 'BlackWeashop', 'WEAPON_ASSAULTRIFLE', 250000),
(14, 'BlackWeashop', 'WEAPON_SPECIALCARBINE', 200000),
(15, 'BlackWeashop', 'WEAPON_SMG', 150000),
(16, 'BlackWeashop', 'WEAPON_MG', 500000),
(17, 'BlackWeashop', 'WEAPON_COMBATPDW', 150000),
(18, 'BlackWeashop', 'WEAPON_MARKSMANRIFLE', 750000),
(19, 'BlackWeashop', 'WEAPON_GUSENBERG', 100000),
(24, 'GunShop', 'WEAPON_BAT', 2500),
(25, 'GunShop', 'WEAPON_KNUCKLE', 1500),
(26, 'GunShop', 'WEAPON_GOLFCLUB', 2000),
(173, 'GunShop', 'WEAPON_FLASHLIGHT', 1000),
(176, 'GunShop', 'WEAPON_HATCHET', 3500),
(180, 'GunShop', 'WEAPON_CROWBAR', 1500),
(181, 'GunShop', 'WEAPON_HAMMER', 1500),
(182, 'GunShop', 'WEAPON_KNIFE', 1500),
(196, 'GunShop', 'WEAPON_MACHETE', 2500),
(216, 'GunShop', 'WEAPON_PISTOL', 30000);

-- --------------------------------------------------------

--
-- Structure de la table `whitelist`
--

DROP TABLE IF EXISTS `whitelist`;
CREATE TABLE IF NOT EXISTS `whitelist` (
  `identifier` varchar(75) NOT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `twitter_likes`
--
ALTER TABLE `twitter_likes`
  ADD CONSTRAINT `FK_twitter_likes_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`),
  ADD CONSTRAINT `FK_twitter_likes_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `twitter_tweets` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `twitter_tweets`
--
ALTER TABLE `twitter_tweets`
  ADD CONSTRAINT `FK_twitter_tweets_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
