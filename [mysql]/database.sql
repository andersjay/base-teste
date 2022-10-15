-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.14-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Copiando estrutura do banco de dados para vrp
CREATE DATABASE IF NOT EXISTS `vrp` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `vrp`;

-- Copiando estrutura para tabela vrp.phone_app_chat
CREATE TABLE IF NOT EXISTS `phone_app_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela vrp.phone_app_chat: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `phone_app_chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_app_chat` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.phone_calls
CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(10) NOT NULL COMMENT 'Num tel proprio',
  `num` varchar(10) NOT NULL COMMENT 'Num reférence du contact',
  `incoming` int(11) NOT NULL COMMENT 'Défini si on est à l''origine de l''appels',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela vrp.phone_calls: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `phone_calls` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_calls` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.phone_messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela vrp.phone_messages: 0 rows
/*!40000 ALTER TABLE `phone_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_messages` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.phone_users_contacts
CREATE TABLE IF NOT EXISTS `phone_users_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela vrp.phone_users_contacts: 0 rows
/*!40000 ALTER TABLE `phone_users_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_users_contacts` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.twitter_accounts
CREATE TABLE IF NOT EXISTS `twitter_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela vrp.twitter_accounts: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `twitter_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_accounts` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.twitter_likes
CREATE TABLE IF NOT EXISTS `twitter_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_twitter_likes_twitter_accounts` (`authorId`),
  KEY `FK_twitter_likes_twitter_tweets` (`tweetId`),
  CONSTRAINT `FK_twitter_likes_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`),
  CONSTRAINT `FK_twitter_likes_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela vrp.twitter_likes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `twitter_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_likes` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.twitter_tweets
CREATE TABLE IF NOT EXISTS `twitter_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_twitter_tweets_twitter_accounts` (`authorId`),
  CONSTRAINT `FK_twitter_tweets_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela vrp.twitter_tweets: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `twitter_tweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_tweets` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_estoque
CREATE TABLE IF NOT EXISTS `vrp_estoque` (
  `vehicle` varchar(100) NOT NULL,
  `quantidade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_estoque: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_estoque` DISABLE KEYS */;
INSERT IGNORE INTO `vrp_estoque` (`vehicle`, `quantidade`) VALUES
	('blista', 10),
	('brioso', 10),
	('emperor', 10),
	('emperor2', 10),
	('dilettante', 10),
	('issi2', 10),
	('panto', 10),
	('prairie', 10),
	('rhapsody', 10),
	('cogcabrio', 10),
	('exemplar', 10),
	('f620', 10),
	('felon', 10),
	('ingot', 10),
	('jackal', 10),
	('oracle', 10),
	('oracle2', 10),
	('sentinel', 10),
	('sentinel', 10),
	('windsor', 10),
	('windsor2', 10),
	('zion', 10),
	('zion2', 10),
	('blade', 10),
	('buccaneer', 10),
	('buccaneer2', 10),
	('primo', 10),
	('chino', 10),
	('coquette3', 10),
	('dukes', 10),
	('faction', 10),
	('faction3', 10),
	('gauntlet', 10),
	('gauntlet2', 10),
	('hermes', 10),
	('hotknife', 10),
	('moonbeam', 10),
	('moonbeam2', 10),
	('nightshade', 10),
	('picador', 10),
	('ruiner', 10),
	('sabregt', 10),
	('sabregt2', 10),
	('slamvan', 10),
	('slamvan3', 10),
	('stalion', 10),
	('stalion2', 10),
	('tampa', 10),
	('vigero', 10),
	('virgo', 10),
	('virgo2', 10),
	('virgo3', 10),
	('voodoo', 10),
	('voodoo2', 10),
	('yosemite', 10),
	('bfinjection', 10),
	('bifta', 10),
	('bodhi2', 10),
	('brawler', 10),
	('trophytruck', 10),
	('trophytruck2', 10),
	('dubsta3', 10),
	('mesa3', 10),
	('rancherxl', 10),
	('rebel2', 10),
	('riata', 10),
	('dloader', 10),
	('sandking', 10),
	('sandking2', 10),
	('baller', 10),
	('baller2', 10),
	('baller3', 10),
	('baller4', 5),
	('baller5', 3),
	('baller6', 3),
	('bjxl', 10),
	('cavalcade', 10),
	('cavalcade2', 10),
	('dubsta', 10),
	('dubsta2', 10),
	('fq2', 10),
	('granger', 10),
	('gresley', 10),
	('habanero', 10),
	('seminole', 10),
	('serrano', 10),
	('xls', 10),
	('xls2', 10),
	('asea', 10),
	('asterope', 10),
	('cog552', 10),
	('cognoscenti', 10),
	('cognoscenti2', 10),
	('stanier', 10),
	('stratum', 10),
	('surge', 10),
	('tailgater', 10),
	('warrener', 10),
	('washington', 10),
	('alpha', 10),
	('banshee', 10),
	('bestiagts', 10),
	('blista2', 10),
	('blista3', 10),
	('buffalo', 10),
	('buffalo2', 10),
	('buffalo3', 10),
	('carbonizzare', 10),
	('comet2', 10),
	('comet3', 10),
	('comet5', 10),
	('coquette', 10),
	('elegy', 10),
	('elegy2', 10),
	('feltzer2', 10),
	('furoregt', 10),
	('fusilade', 10),
	('futo', 10),
	('jester', 10),
	('khamelion', 10),
	('kuruma', 10),
	('massacro', 10),
	('massacro2', 10),
	('ninef', 10),
	('ninef2', 10),
	('omnis', 5),
	('pariah', 10),
	('penumbra', 10),
	('raiden', 10),
	('raiden2', 10),
	('rapidgt', 10),
	('rapidgt2', 10),
	('ruston', 10),
	('schafter3', 10),
	('schafter4', 10),
	('schafter5', 10),
	('schwarzer', 10),
	('sentinel3', 10),
	('seven70', 10),
	('specter', 10),
	('specter2', 10),
	('streiter', 10),
	('sultan', 10),
	('surano', 10),
	('tampa2', 10),
	('tropos', 10),
	('verlierer2', 10),
	('btype2', 10),
	('btype3', 10),
	('casco', 10),
	('cheetah', 10),
	('coquette2', 10),
	('feltzer3', 10),
	('gt500', 10),
	('infernus2', 10),
	('jb700', 10),
	('mamba', 10),
	('manana', 10),
	('monroe', 10),
	('peyote', 10),
	('pigalle', 10),
	('rapidgt3', 10),
	('retinue', 10),
	('stinger', 10),
	('stingergt', 10),
	('torero', 10),
	('tornado2', 10),
	('tornado6', 10),
	('tornado', 10),
	('turismo2', 10),
	('ztype', 10),
	('adder', 5),
	('autarch', 5),
	('banshee2', 5),
	('bullet', 5),
	('cheetah2', 5),
	('entityxf', 5),
	('fmj', 5),
	('gp1', 10),
	('infernus', 10),
	('nero', 10),
	('nero2', 10),
	('osiris', 10),
	('penetrator', 10),
	('pfister811', 10),
	('reaper', 10),
	('sc1', 10),
	('sultanrs', 10),
	('t20', 3),
	('tempesta', 10),
	('turismor', 10),
	('tyrus', 10),
	('vacca', 10),
	('visione', 5),
	('voltic', 10),
	('zentorno', 5),
	('sadler', 10),
	('bison', 10),
	('bison2', 10),
	('bobcatxl', 10),
	('burrito', 10),
	('burrito2', 10),
	('burrito4', 10),
	('mule4', 10),
	('rallytruck', 10),
	('minivan', 10),
	('minivan2', 10),
	('paradise', 10),
	('pony', 10),
	('pony2', 10),
	('rumpo', 10),
	('rumpo2', 10),
	('rumpo3', 10),
	('surfer', 10),
	('youga', 10),
	('huntley', 10),
	('landstalker', 10),
	('mesa', 10),
	('patriot', 10),
	('radi', 10),
	('rocoto', 10),
	('tyrant', 5),
	('entity2', 5),
	('cheburek', 10),
	('hotring', 10),
	('jester3', 10),
	('flashgt', 10),
	('ellie', 10),
	('michelli', 10),
	('fagaloa', 10),
	('dominator', 10),
	('dominator2', 10),
	('dominator3', 10),
	('issi3', 10),
	('taipam', 10),
	('gb200', 10),
	('stretch', 10),
	('guardian', 10),
	('kamacho', 10),
	('neon', 10),
	('cyclone', 10),
	('italigtb', 10),
	('italigtb2', 10),
	('vagner', 5),
	('xa21', 5),
	('tezeract', 3),
	('prototipo', 3),
	('patriot2', 10),
	('swinger', 10),
	('clique', 10),
	('deveste', 2),
	('deviant', 10),
	('impaler', 10),
	('italigto', 10),
	('toros', 10),
	('schlagen', 10),
	('tulip', 10),
	('vamos', 10),
	('freecrawler', 10),
	('fugitive', 10),
	('glendale', 10),
	('intruder', 10),
	('le7b', 10),
	('lurcher', 10),
	('lynx', 10),
	('phoenix', 10),
	('premier', 10),
	('raptor', 10),
	('sheava', 10),
	('z190', 10),
	('akuma', 10),
	('avarus', 10),
	('bagger', 10),
	('bati', 10),
	('bati2', 10),
	('bf400', 10),
	('carbonrs', 10),
	('chimera', 10),
	('cliffhanger', 10),
	('daemon2', 10),
	('defiler', 10),
	('diablous', 10),
	('diablous2', 10),
	('double', 10),
	('enduro', 10),
	('esskey', 10),
	('faggio', 10),
	('faggio2', 10),
	('faggio3', 10),
	('fcr', 10),
	('gcr2', 10),
	('gargoyle', 10),
	('hakuchou', 5),
	('hakuchou2', 5),
	('hexer', 10),
	('innovation', 10),
	('lectro', 10),
	('manchez', 10),
	('nemesis', 10),
	('nightblade', 10),
	('pcj', 10),
	('ruffian', 10),
	('sanchez', 10),
	('sanchez2', 10),
	('sovereign', 10),
	('thrust', 10),
	('vader', 10),
	('vindicator', 10),
	('vortex', 10),
	('wolfsbane', 10),
	('zombiea', 10),
	('zombieb', 10),
	('shotaro', 10),
	('rabike', 10),
	('blazer', 10),
	('blazer4', 10),
	('dodgechargersrt', 2),
	('audirs6', 2),
	('bmwm3f80', 2),
	('fordmustang', 2),
	('lancerevolution9', 5),
	('lancerevolutionx', 5),
	('focusrs', 5),
	('mercedesa45', 5),
	('audirs7', 2),
	('hondafk8', 2),
	('mustangmach1', 2),
	('porsche930', 2),
	('teslaprior', 3),
	('type263', 5),
	('beetle74', 5),
	('fe86', 5);
/*!40000 ALTER TABLE `vrp_estoque` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_homes_permissions
CREATE TABLE IF NOT EXISTS `vrp_homes_permissions` (
  `owner` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `garage` int(11) NOT NULL,
  `home` varchar(100) NOT NULL DEFAULT '',
  `tax` varchar(24) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_homes_permissions: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_homes_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_homes_permissions` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_srv_data
CREATE TABLE IF NOT EXISTS `vrp_srv_data` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_srv_data: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_srv_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_srv_data` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_users
CREATE TABLE IF NOT EXISTS `vrp_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_login` varchar(255) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `whitelisted` tinyint(1) DEFAULT NULL,
  `banned` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_users: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_users` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_user_data
CREATE TABLE IF NOT EXISTS `vrp_user_data` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`user_id`,`dkey`),
  CONSTRAINT `fk_user_data_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_user_data: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_user_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_user_data` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_user_identities
CREATE TABLE IF NOT EXISTS `vrp_user_identities` (
  `user_id` int(11) NOT NULL,
  `registration` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `registration` (`registration`),
  KEY `phone` (`phone`),
  CONSTRAINT `fk_user_identities_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_user_identities: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_user_identities` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_user_identities` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_user_ids
CREATE TABLE IF NOT EXISTS `vrp_user_ids` (
  `identifier` varchar(100) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`identifier`),
  KEY `fk_user_ids_users` (`user_id`),
  CONSTRAINT `fk_user_ids_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_user_ids: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_user_ids` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_user_ids` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_user_moneys
CREATE TABLE IF NOT EXISTS `vrp_user_moneys` (
  `user_id` int(11) NOT NULL,
  `wallet` int(11) DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_user_moneys_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_user_moneys: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_user_moneys` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_user_moneys` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_user_vehicles
CREATE TABLE IF NOT EXISTS `vrp_user_vehicles` (
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `detido` int(1) NOT NULL DEFAULT 0,
  `time` varchar(24) NOT NULL DEFAULT '0',
  `engine` int(4) NOT NULL DEFAULT 1000,
  `body` int(4) NOT NULL DEFAULT 1000,
  `fuel` int(3) NOT NULL DEFAULT 100,
  `ipva` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`vehicle`),
  CONSTRAINT `fk_user_vehicles_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_user_vehicles: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_user_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_user_vehicles` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
