CREATE TABLE `iris_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dbid` varchar(50) NOT NULL,
  `template` longblob NOT NULL,
  `deviceId` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `siteId` varchar(50) DEFAULT NULL,
  `creationDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `modificationDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `participantUuid` varchar(45) DEFAULT NULL,
  `voided` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Subjects_index` (`dbid`),
  UNIQUE KEY `participantUuid_UNIQUE` (`participantUuid`),
  KEY `index_hashKey` (`deviceId`(10))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

