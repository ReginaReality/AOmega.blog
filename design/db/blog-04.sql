SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `AOmega-blog` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `AOmega-blog` ;

-- -----------------------------------------------------
-- Table `AOmega-blog`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AOmega-blog`.`roles` ;

CREATE  TABLE IF NOT EXISTS `AOmega-blog`.`roles` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `role` VARCHAR(128) NOT NULL ,
  `yaml_model` TEXT NOT NULL ,
  `ser_settings` TEXT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
COMMENT = 'Роли пользователей';


-- -----------------------------------------------------
-- Table `AOmega-blog`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AOmega-blog`.`users` ;

CREATE  TABLE IF NOT EXISTS `AOmega-blog`.`users` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `role_id` INT(10) NOT NULL ,
  `fio` VARCHAR(128) NOT NULL ,
  `nick` VARCHAR(64) NOT NULL ,
  `email` VARCHAR(128) NOT NULL ,
  `site` VARCHAR(128) NOT NULL ,
  `avatar` VARCHAR(128) NOT NULL ,
  `sex` VARCHAR(1) NOT NULL ,
  `signature` VARCHAR(512) NOT NULL ,
  `active` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'код активации' ,
  `activate_code` VARCHAR(64) NOT NULL COMMENT 'код активации' ,
  `birth_at` DATE NOT NULL ,
  `registered_at` DATETIME NOT NULL ,
  `visited_at` DATETIME NOT NULL ,
  `userscol` VARCHAR(45) NOT NULL ,
  `rating` DECIMAL(4,2) NOT NULL ,
  `rating_plus` INT(10) NOT NULL ,
  `rating_minus` INT(10) NOT NULL ,
  `rating_count` INT(10) NOT NULL ,
  PRIMARY KEY (`id`, `role_id`) ,
  CONSTRAINT `fk_users_roles1`
    FOREIGN KEY (`role_id` )
    REFERENCES `AOmega-blog`.`roles` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Основные данные пользователя';

CREATE INDEX `fk_users_roles1` ON `AOmega-blog`.`users` (`role_id` ASC) ;


-- -----------------------------------------------------
-- Table `AOmega-blog`.`accounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AOmega-blog`.`accounts` ;

CREATE  TABLE IF NOT EXISTS `AOmega-blog`.`accounts` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `user_id` INT(10) NOT NULL ,
  `type` INT(1) NOT NULL ,
  `login` VARCHAR(128) NOT NULL ,
  `password` VARCHAR(128) NOT NULL ,
  `service_name` VARCHAR(128) NOT NULL ,
  `service_id` INT(10) NOT NULL ,
  PRIMARY KEY (`id`, `user_id`) ,
  CONSTRAINT `fk_users_services_users`
    FOREIGN KEY (`user_id` )
    REFERENCES `AOmega-blog`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Список аккаунтов на разл. сервисах, service_id = 0 наш';

CREATE INDEX `fk_users_services_users` ON `AOmega-blog`.`accounts` (`user_id` ASC) ;


-- -----------------------------------------------------
-- Table `AOmega-blog`.`blogs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AOmega-blog`.`blogs` ;

CREATE  TABLE IF NOT EXISTS `AOmega-blog`.`blogs` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `created_at` DATETIME NOT NULL ,
  `alias` VARCHAR(128) NOT NULL ,
  `blog` VARCHAR(128) NOT NULL ,
  `template` VARCHAR(128) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
COMMENT = 'Блоги или категории, разделы для постов';


-- -----------------------------------------------------
-- Table `AOmega-blog`.`tags`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AOmega-blog`.`tags` ;

CREATE  TABLE IF NOT EXISTS `AOmega-blog`.`tags` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `alias` VARCHAR(32) NOT NULL ,
  `tag` VARCHAR(32) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
COMMENT = 'Тэги';


-- -----------------------------------------------------
-- Table `AOmega-blog`.`modules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AOmega-blog`.`modules` ;

CREATE  TABLE IF NOT EXISTS `AOmega-blog`.`modules` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `module` VARCHAR(64) NOT NULL ,
  `title` VARCHAR(64) NOT NULL ,
  `description` VARCHAR(255) NOT NULL ,
  `yaml_model` TEXT NOT NULL ,
  `ser_settings` TEXT NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
COMMENT = 'Имеющиеся модули в системе';


-- -----------------------------------------------------
-- Table `AOmega-blog`.`posts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AOmega-blog`.`posts` ;

CREATE  TABLE IF NOT EXISTS `AOmega-blog`.`posts` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `blog_id` INT(10) NOT NULL ,
  `user_id` INT(10) NOT NULL ,
  `title` VARCHAR(255) NOT NULL ,
  `description` VARCHAR(512) NOT NULL ,
  `alias` VARCHAR(128) NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  `edited_at` DATETIME NOT NULL ,
  `rating` DECIMAL(4,2) NOT NULL ,
  `rating_plus` INT(10) NOT NULL ,
  `rating_minus` INT(10) NOT NULL ,
  `rating_count` INT(10) NOT NULL ,
  PRIMARY KEY (`id`, `blog_id`, `user_id`) ,
  CONSTRAINT `fk_posts_blogs1`
    FOREIGN KEY (`blog_id` )
    REFERENCES `AOmega-blog`.`blogs` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_posts_users1`
    FOREIGN KEY (`user_id` )
    REFERENCES `AOmega-blog`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Сообщения в блогах, посты\n';

CREATE INDEX `fk_posts_blogs1` ON `AOmega-blog`.`posts` (`blog_id` ASC) ;

CREATE INDEX `fk_posts_users1` ON `AOmega-blog`.`posts` (`user_id` ASC) ;


-- -----------------------------------------------------
-- Table `AOmega-blog`.`blogs_modules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AOmega-blog`.`blogs_modules` ;

CREATE  TABLE IF NOT EXISTS `AOmega-blog`.`blogs_modules` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `blog_id` INT(10) NOT NULL ,
  `module_id` INT(10) NOT NULL ,
  `primary` TINYINT(1) NOT NULL DEFAULT 0 ,
  `variable` VARCHAR(64) NOT NULL ,
  `ser_settings` TEXT NOT NULL ,
  PRIMARY KEY (`id`, `blog_id`, `module_id`) ,
  CONSTRAINT `fk_blogs_has_modules_blogs1`
    FOREIGN KEY (`blog_id` )
    REFERENCES `AOmega-blog`.`blogs` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_blogs_has_modules_modules1`
    FOREIGN KEY (`module_id` )
    REFERENCES `AOmega-blog`.`modules` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Блоги и их модули: 1 всегда будет PRIMARY обязательный';

CREATE INDEX `fk_blogs_has_modules_modules1` ON `AOmega-blog`.`blogs_modules` (`module_id` ASC) ;


-- -----------------------------------------------------
-- Table `AOmega-blog`.`posts_modules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AOmega-blog`.`posts_modules` ;

CREATE  TABLE IF NOT EXISTS `AOmega-blog`.`posts_modules` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `post_id` INT(10) NOT NULL ,
  `module_id` INT(10) NOT NULL ,
  `ord` INT(2) NOT NULL COMMENT 'порядок следования модуля в переменной\n' ,
  `ser_settings` TEXT NOT NULL ,
  `variable` VARCHAR(64) NOT NULL DEFAULT 'content' ,
  `replace` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'надо ли замещать 1 или только клеить к предыдущим результатам 0' ,
  PRIMARY KEY (`id`, `post_id`, `module_id`) ,
  CONSTRAINT `fk_posts_has_modules_posts1`
    FOREIGN KEY (`post_id` , `id` )
    REFERENCES `AOmega-blog`.`posts` (`id` , `blog_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_posts_has_modules_modules1`
    FOREIGN KEY (`module_id` )
    REFERENCES `AOmega-blog`.`modules` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Модули непосредственно уже установленные на странице';

CREATE INDEX `fk_posts_has_modules_modules1` ON `AOmega-blog`.`posts_modules` (`module_id` ASC) ;


-- -----------------------------------------------------
-- Table `AOmega-blog`.`posts_tags`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AOmega-blog`.`posts_tags` ;

CREATE  TABLE IF NOT EXISTS `AOmega-blog`.`posts_tags` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `post_id` INT(10) NOT NULL ,
  `tag_id` INT(10) NOT NULL ,
  PRIMARY KEY (`id`, `post_id`, `tag_id`) ,
  CONSTRAINT `fk_posts_has_tags_posts1`
    FOREIGN KEY (`post_id` , `id` )
    REFERENCES `AOmega-blog`.`posts` (`id` , `blog_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_posts_has_tags_tags1`
    FOREIGN KEY (`tag_id` )
    REFERENCES `AOmega-blog`.`tags` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Связь сообщений с тэгами';

CREATE INDEX `fk_posts_has_tags_tags1` ON `AOmega-blog`.`posts_tags` (`tag_id` ASC) ;


-- -----------------------------------------------------
-- Table `AOmega-blog`.`blogs_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AOmega-blog`.`blogs_users` ;

CREATE  TABLE IF NOT EXISTS `AOmega-blog`.`blogs_users` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `blog_id` INT(10) NOT NULL ,
  `user_id` INT(10) NOT NULL ,
  `subscribed_at` DATETIME NOT NULL COMMENT 'когда был подписан' ,
  `moderate` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '1 модератор, 0 просто вступивший пользователь' ,
  PRIMARY KEY (`id`, `blog_id`, `user_id`) ,
  CONSTRAINT `fk_blogs_has_users_blogs1`
    FOREIGN KEY (`blog_id` )
    REFERENCES `AOmega-blog`.`blogs` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_blogs_has_users_users1`
    FOREIGN KEY (`user_id` , `id` )
    REFERENCES `AOmega-blog`.`users` (`id` , `role_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Пользовательские подписки на блоги';

CREATE INDEX `fk_blogs_has_users_users1` ON `AOmega-blog`.`blogs_users` (`user_id` ASC, `id` ASC) ;


-- -----------------------------------------------------
-- Table `AOmega-blog`.`comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AOmega-blog`.`comments` ;

CREATE  TABLE IF NOT EXISTS `AOmega-blog`.`comments` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `user_id` INT(10) NOT NULL ,
  `commented_at` DATETIME NOT NULL ,
  `comment` TEXT NOT NULL ,
  `deleted` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'удалён коммент 1 или нет 0' ,
  `rating` DECIMAL(4,2) NOT NULL ,
  `rating_plus` INT(10) NOT NULL ,
  `rating_minus` INT(10) NOT NULL ,
  `rating_count` INT(10) NOT NULL ,
  `resource_id` INT(10) NOT NULL COMMENT 'id чтобы было откомменчено' ,
  `resource_type` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '0 - значит what_id = user_id личная переписка \n1 - значит what_id = post_id' ,
  PRIMARY KEY (`id`, `user_id`) ,
  CONSTRAINT `fk_comments_users1`
    FOREIGN KEY (`user_id` )
    REFERENCES `AOmega-blog`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_posts1`
    FOREIGN KEY (`resource_id` )
    REFERENCES `AOmega-blog`.`posts` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_users2`
    FOREIGN KEY (`resource_id` )
    REFERENCES `AOmega-blog`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Комментарий на сайте';

CREATE INDEX `fk_comments_users1` ON `AOmega-blog`.`comments` (`user_id` ASC) ;

CREATE INDEX `fk_comments_posts1` ON `AOmega-blog`.`comments` (`resource_id` ASC) ;


-- -----------------------------------------------------
-- Table `AOmega-blog`.`ratings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AOmega-blog`.`ratings` ;

CREATE  TABLE IF NOT EXISTS `AOmega-blog`.`ratings` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `user_id` INT(10) NOT NULL ,
  `rated_at` DATETIME NOT NULL ,
  `rating` INT(2) NOT NULL ,
  `resource_id` INT(10) NOT NULL COMMENT 'id что было отрейтинговано' ,
  `resource_type` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '0 - значит what_id = user_id\n1 - значит what_id = post_id\n2 - значит what_id = comment_id ' ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_rating_logs_users1`
    FOREIGN KEY (`user_id` )
    REFERENCES `AOmega-blog`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rating_logs_posts1`
    FOREIGN KEY (`user_id` )
    REFERENCES `AOmega-blog`.`posts` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rating_logs_comments1`
    FOREIGN KEY (`user_id` )
    REFERENCES `AOmega-blog`.`comments` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Лог рейтингов, данные пересчитывать в статику Users';

CREATE INDEX `fk_rating_logs_users1` ON `AOmega-blog`.`ratings` (`user_id` ASC) ;


-- -----------------------------------------------------
-- Table `AOmega-blog`.`searches`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AOmega-blog`.`searches` ;

CREATE  TABLE IF NOT EXISTS `AOmega-blog`.`searches` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `search` TEXT NOT NULL ,
  `resource_id` INT(10) NOT NULL ,
  `resource_type` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '0 значит what_id = post_id\n1 значит what_id = comment_id' ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_searches_posts1`
    FOREIGN KEY (`resource_id` )
    REFERENCES `AOmega-blog`.`posts` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_searches_comments1`
    FOREIGN KEY (`resource_id` )
    REFERENCES `AOmega-blog`.`comments` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Поисковая выжимка индексов постов';

CREATE INDEX `fk_searches_posts1` ON `AOmega-blog`.`searches` (`resource_id` ASC) ;


-- -----------------------------------------------------
-- Table `AOmega-blog`.`settings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AOmega-blog`.`settings` ;

CREATE  TABLE IF NOT EXISTS `AOmega-blog`.`settings` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `yaml_model` TEXT NOT NULL ,
  `ser_settings` TEXT NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
COMMENT = 'Все настройки нашего блога';



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
