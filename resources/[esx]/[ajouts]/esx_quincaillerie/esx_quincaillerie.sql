USE `essentialmode`;

CREATE TABLE `quincaillerie` (
  
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  
  PRIMARY KEY (`id`)
);

INSERT INTO `quincaillerie` (name, item, price) VALUES
	('LSQuincaillerie','COMPONENT_KNUCKLE_VARMOD_PLAYER', 11500),
	('LSQuincaillerie','COMPONENT_KNUCKLE_VARMOD_LOVE', 12000),
	('LSQuincaillerie','COMPONENT_KNUCKLE_VARMOD_DOLLAR', 12500),
	('LSQuincaillerie','COMPONENT_KNUCKLE_VARMOD_VAGOS', 13000),
	('LSQuincaillerie','COMPONENT_KNUCKLE_VARMOD_HATE', 13500),
	('LSQuincaillerie','COMPONENT_KNUCKLE_VARMOD_DIAMOND', 14000),
	('LSQuincaillerie','COMPONENT_KNUCKLE_VARMOD_PIMP', 14500),
	('LSQuincaillerie','COMPONENT_KNUCKLE_VARMOD_KING', 15000),
	('LSQuincaillerie','COMPONENT_KNUCKLE_VARMOD_BALLAS', 15500),
	('LSQuincaillerie','COMPONENT_SWITCHBLADE_VARMOD_VAR1', 14500),
	('LSQuincaillerie','COMPONENT_SWITCHBLADE_VARMOD_VAR2', 15000),
	('LSQuincaillerie','COMPONENT_REVOLVER_VARMOD_BOSS', 14500),
	('LSQuincaillerie','COMPONENT_REVOLVER_VARMOD_GOON', 15500),
	('LSQuincaillerie','COMPONENT_VARMOD_LOWRIDER', 25000),
	('LSQuincaillerie','COMPONENT_VARMOD_LUXE', 50000)
;

INSERT INTO `quincaillerie` (name, item, price) VALUES
	('LSQuincaillerie','COMPONENT_AT_PI_SUPP', 15000),
	('LSQuincaillerie','COMPONENT_AT_AR_SUPP_02', 25000),
	('LSQuincaillerie','COMPONENT_AT_PI_FLSH', 10000),
	('LSQuincaillerie','COMPONENT_AT_AR_FLSH', 15000),
	('LSQuincaillerie','COMPONENT_AT_AR_AFGRIP', 30000),
	('LSQuincaillerie','COMPONENT_AT_SCOPE_MACRO', 35000),
	('LSQuincaillerie','COMPONENT_AT_PI_CLIP_02', 30000),
	('LSQuincaillerie','COMPONENT_AT_AR_CLIP_02', 40000),
	('LSQuincaillerie','COMPONENT_AT_AR_CLIP_03', 60000)
;

INSERT INTO `quincaillerie` (name, item, price) VALUES
	('LSQuincaillerie','TINT_01', 5500),
	('LSQuincaillerie','TINT_02', 5500),
	('LSQuincaillerie','TINT_03', 5500),
	('LSQuincaillerie','TINT_04', 5500),
	('LSQuincaillerie','TINT_06', 5500),
	('LSQuincaillerie','TINT_07', 5500)
;