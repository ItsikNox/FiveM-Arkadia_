CREATE TABLE IF NOT EXISTS `dopeplants` (
  `owner` varchar(50) NOT NULL,
  `plant` longtext NOT NULL,
  `plantid` bigint(20) NOT NULL
);


INSERT INTO `items` (`name`,`label`,`limit`,`rare`,`can_remove`) VALUES
	('highgradefemaleseed', '(HG) Graine femelle', -1, 0 ,1),
	('lowgradefemaleseed', '(LG) Graine femelle', -1, 0 ,1),
	('highgrademaleseed', '(HG) Graine mâle', -1, 0 ,1),
	('lowgrademaleseed', '(LG) Graine mâle', -1, 0 ,1),
	('highgradefert', 'Engrais de qualité supérieur', -1, 0 ,1),
	('lowgradefert', 'Engrais de qualité inférieure', -1, 0 ,1),
	('purifiedwater', 'Eau purifiée', -1, 0 ,1),
	('wateringcan', 'Arrosoir', -1, 0 ,1),
	('plantpot', 'Pot à plantes', -1, 0 ,1),
	('trimmedweed', 'Weed Taillée', -1, 0 ,1),
	('dopebag', 'sachets à fermeture éclair', -1, 0 ,1),
	('bagofdope', 'Sac de drogue', -1, 0 ,1),
	('drugscales', 'Balances', -1, 0 ,1);
