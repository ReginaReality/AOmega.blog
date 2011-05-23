-- phpMyAdmin SQL Dump
-- version 3.3.7
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Май 20 2011 г., 02:51
-- Версия сервера: 5.1.51
-- Версия PHP: 5.2.14

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `aomega-blog`
--

-- --------------------------------------------------------

--
-- Структура таблицы `accounts`
--

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `type` int(1) NOT NULL,
  `login` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `service_name` varchar(128) NOT NULL,
  `service_id` int(10) NOT NULL,
  PRIMARY KEY (`id`,`user_id`),
  KEY `fk_users_services_users` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `accounts`
--

INSERT INTO `accounts` (`id`, `user_id`, `type`, `login`, `password`, `service_name`, `service_id`) VALUES
(1, 3, 0, 'user', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'blog', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `blogs`
--

DROP TABLE IF EXISTS `blogs`;
CREATE TABLE IF NOT EXISTS `blogs` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `alias` varchar(128) NOT NULL,
  `blog` varchar(128) NOT NULL,
  `template` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Блоги или категории, разделы для постов' AUTO_INCREMENT=1 ;

--
-- Дамп данных таблицы `blogs`
--


-- --------------------------------------------------------

--
-- Структура таблицы `blogs_modules`
--

DROP TABLE IF EXISTS `blogs_modules`;
CREATE TABLE IF NOT EXISTS `blogs_modules` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `blog_id` int(10) NOT NULL,
  `module_id` int(10) NOT NULL,
  `primary` tinyint(1) NOT NULL DEFAULT '0',
  `variable` varchar(64) NOT NULL,
  `ser_settings` text NOT NULL,
  PRIMARY KEY (`id`,`blog_id`,`module_id`),
  KEY `fk_blogs_has_modules_blogs1` (`blog_id`),
  KEY `fk_blogs_has_modules_modules1` (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Блоги и их модули: 1 всегда будет PRIMARY обязательный' AUTO_INCREMENT=1 ;

--
-- Дамп данных таблицы `blogs_modules`
--


-- --------------------------------------------------------

--
-- Структура таблицы `blogs_users`
--

DROP TABLE IF EXISTS `blogs_users`;
CREATE TABLE IF NOT EXISTS `blogs_users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `blog_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `subscribed_at` datetime NOT NULL COMMENT 'когда был подписан',
  `moderate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 модератор, 0 просто вступивший пользователь',
  PRIMARY KEY (`id`,`blog_id`,`user_id`),
  KEY `fk_blogs_has_users_blogs1` (`blog_id`),
  KEY `fk_blogs_has_users_users1` (`user_id`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Пользовательские подписки на блоги' AUTO_INCREMENT=1 ;

--
-- Дамп данных таблицы `blogs_users`
--


-- --------------------------------------------------------

--
-- Структура таблицы `comments`
--

DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `commented_at` datetime NOT NULL,
  `comment` text NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'удалён коммент 1 или нет 0',
  `rating` decimal(4,2) NOT NULL,
  `rating_plus` int(10) NOT NULL,
  `rating_minus` int(10) NOT NULL,
  `rating_count` int(10) NOT NULL,
  `resource_id` int(10) NOT NULL COMMENT 'id чтобы было откомменчено',
  `resource_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 - значит what_id = user_id личная переписка \n1 - значит what_id = post_id',
  PRIMARY KEY (`id`,`user_id`),
  KEY `fk_comments_users1` (`user_id`),
  KEY `fk_comments_posts1` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Комментарий на сайте' AUTO_INCREMENT=1 ;

--
-- Дамп данных таблицы `comments`
--


-- --------------------------------------------------------

--
-- Структура таблицы `modules`
--

DROP TABLE IF EXISTS `modules`;
CREATE TABLE IF NOT EXISTS `modules` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `module` varchar(64) NOT NULL,
  `title` varchar(64) NOT NULL,
  `description` varchar(255) NOT NULL,
  `yaml_model` text NOT NULL,
  `ser_settings` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Имеющиеся модули в системе' AUTO_INCREMENT=1 ;

--
-- Дамп данных таблицы `modules`
--


-- --------------------------------------------------------

--
-- Структура таблицы `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `blog_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(512) NOT NULL,
  `alias` varchar(128) NOT NULL,
  `created_at` datetime NOT NULL,
  `edited_at` datetime NOT NULL,
  `rating` decimal(4,2) NOT NULL,
  `rating_plus` int(10) NOT NULL,
  `rating_minus` int(10) NOT NULL,
  `rating_count` int(10) NOT NULL,
  PRIMARY KEY (`id`,`blog_id`,`user_id`),
  KEY `fk_posts_blogs1` (`blog_id`),
  KEY `fk_posts_users1` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Сообщения в блогах, посты\n' AUTO_INCREMENT=1 ;

--
-- Дамп данных таблицы `posts`
--


-- --------------------------------------------------------

--
-- Структура таблицы `posts_modules`
--

DROP TABLE IF EXISTS `posts_modules`;
CREATE TABLE IF NOT EXISTS `posts_modules` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `post_id` int(10) NOT NULL,
  `module_id` int(10) NOT NULL,
  `ord` int(2) NOT NULL COMMENT 'порядок следования модуля в переменной\n',
  `ser_settings` text NOT NULL,
  `variable` varchar(64) NOT NULL DEFAULT 'content',
  `replace` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'надо ли замещать 1 или только клеить к предыдущим результатам 0',
  PRIMARY KEY (`id`,`post_id`,`module_id`),
  KEY `fk_posts_has_modules_posts1` (`post_id`,`id`),
  KEY `fk_posts_has_modules_modules1` (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Модули непосредственно уже установленные на странице' AUTO_INCREMENT=1 ;

--
-- Дамп данных таблицы `posts_modules`
--


-- --------------------------------------------------------

--
-- Структура таблицы `posts_tags`
--

DROP TABLE IF EXISTS `posts_tags`;
CREATE TABLE IF NOT EXISTS `posts_tags` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `post_id` int(10) NOT NULL,
  `tag_id` int(10) NOT NULL,
  PRIMARY KEY (`id`,`post_id`,`tag_id`),
  KEY `fk_posts_has_tags_posts1` (`post_id`,`id`),
  KEY `fk_posts_has_tags_tags1` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Связь сообщений с тэгами' AUTO_INCREMENT=1 ;

--
-- Дамп данных таблицы `posts_tags`
--


-- --------------------------------------------------------

--
-- Структура таблицы `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `role` varchar(128) NOT NULL,
  `yaml_model` text NOT NULL,
  `ser_settings` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Роли пользователей' AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `roles`
--

INSERT INTO `roles` (`id`, `role`, `yaml_model`, `ser_settings`) VALUES
(1, 'admin', '', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `tags`
--

DROP TABLE IF EXISTS `tags`;
CREATE TABLE IF NOT EXISTS `tags` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `alias` varchar(32) NOT NULL,
  `tag` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Тэги' AUTO_INCREMENT=1 ;

--
-- Дамп данных таблицы `tags`
--


-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `role_id` int(10) NOT NULL,
  `fio` varchar(128) NOT NULL,
  `nick` varchar(64) NOT NULL,
  `email` varchar(128) NOT NULL,
  `site` varchar(128) NOT NULL,
  `avatar` varchar(128) NOT NULL,
  `sex` varchar(1) NOT NULL,
  `signature` varchar(512) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'код активации',
  `activate_code` varchar(64) NOT NULL COMMENT 'код активации',
  `birth_at` date NOT NULL,
  `registered_at` datetime NOT NULL,
  `visited_at` datetime NOT NULL,
  `userscol` varchar(45) NOT NULL,
  `rating` decimal(4,2) NOT NULL,
  `rating_plus` int(10) NOT NULL,
  `rating_minus` int(10) NOT NULL,
  `rating_count` int(10) NOT NULL,
  PRIMARY KEY (`id`,`role_id`),
  KEY `fk_users_roles1` (`role_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Основные данные пользователя' AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `role_id`, `fio`, `nick`, `email`, `site`, `avatar`, `sex`, `signature`, `active`, `activate_code`, `birth_at`, `registered_at`, `visited_at`, `userscol`, `rating`, `rating_plus`, `rating_minus`, `rating_count`) VALUES
(3, 1, 'User Userovich', 'User', 'user@aomega.ru', 'aomega.ru', '', '', '', 0, '', '0000-00-00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 0.00, 0, 0, 0);

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `accounts`
--
ALTER TABLE `accounts`
  ADD CONSTRAINT `fk_users_services_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `blogs_modules`
--
ALTER TABLE `blogs_modules`
  ADD CONSTRAINT `fk_blogs_has_modules_blogs1` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_blogs_has_modules_modules1` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `blogs_users`
--
ALTER TABLE `blogs_users`
  ADD CONSTRAINT `fk_blogs_has_users_blogs1` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_blogs_has_users_users1` FOREIGN KEY (`user_id`, `id`) REFERENCES `users` (`id`, `role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_comments_posts1` FOREIGN KEY (`resource_id`) REFERENCES `posts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_comments_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_comments_users2` FOREIGN KEY (`resource_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `fk_posts_blogs1` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_posts_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `posts_modules`
--
ALTER TABLE `posts_modules`
  ADD CONSTRAINT `fk_posts_has_modules_modules1` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_posts_has_modules_posts1` FOREIGN KEY (`post_id`, `id`) REFERENCES `posts` (`id`, `blog_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `posts_tags`
--
ALTER TABLE `posts_tags`
  ADD CONSTRAINT `fk_posts_has_tags_posts1` FOREIGN KEY (`post_id`, `id`) REFERENCES `posts` (`id`, `blog_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_posts_has_tags_tags1` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_roles1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
