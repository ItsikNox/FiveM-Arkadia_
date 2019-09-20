ALTER TABLE `banlist` ADD `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL AFTER `license`;
ALTER TABLE `banlist` ADD `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL AFTER `liveid`;
ALTER TABLE `banlist` ADD `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL AFTER `xblid`;

ALTER TABLE `banlisthistory` ADD `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL AFTER `license`;
ALTER TABLE `banlisthistory` ADD `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL AFTER `liveid`;
ALTER TABLE `banlisthistory` ADD `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL AFTER `xblid`;