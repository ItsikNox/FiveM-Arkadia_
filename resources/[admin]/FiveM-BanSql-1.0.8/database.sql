DROP TABLE IF EXISTS banlist;
CREATE TABLE IF NOT EXISTS banlist (
  identifier varchar(25) COLLATE utf8mb4_bin PRIMARY KEY,
  license varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  liveid varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  xblid varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  discord varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  playerip varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  targetplayername varchar(32) COLLATE utf8mb4_bin NOT NULL,
  sourceplayername varchar(32) COLLATE utf8mb4_bin NOT NULL,
  reason varchar(255) NOT NULL,
  timeat varchar(50) NOT NULL,
  expiration varchar(50) NOT NULL,
  permanent int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS banlisthistory;
CREATE TABLE IF NOT EXISTS banlisthistory (
  id int(11) AUTO_INCREMENT PRIMARY KEY,
  identifier varchar(25) NOT NULL,
  license varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  liveid varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  xblid varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  discord varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  playerip varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  targetplayername varchar(32) COLLATE utf8mb4_bin NOT NULL,
  sourceplayername varchar(32) COLLATE utf8mb4_bin NOT NULL,
  reason varchar(255) NOT NULL,
  timeat int(11) NOT NULL,
  added varchar(40) NOT NULL,
  expiration int(11) NOT NULL,
  permanent int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS baninfo;
CREATE TABLE IF NOT EXISTS baninfo (
  id int(11) AUTO_INCREMENT PRIMARY KEY,
  identifier varchar(25) COLLATE utf8mb4_bin DEFAULT "no info",
  license varchar(50) COLLATE utf8mb4_bin DEFAULT "no info",
  liveid varchar(21) COLLATE utf8mb4_bin DEFAULT "no info",
  xblid varchar(21) COLLATE utf8mb4_bin DEFAULT "no info",
  discord varchar(30) COLLATE utf8mb4_bin DEFAULT "no info",
  playerip varchar(25) COLLATE utf8mb4_bin DEFAULT "0.0.0.0",
  playername varchar(32) COLLATE utf8mb4_bin DEFAULT "no info"
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
