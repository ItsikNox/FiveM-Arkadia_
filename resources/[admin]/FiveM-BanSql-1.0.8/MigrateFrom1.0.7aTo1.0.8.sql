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