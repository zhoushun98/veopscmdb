/*
 Navicat Premium Data Transfer

 Source Server         : vm-mysql
 Source Server Type    : MySQL
 Source Server Version : 50743 (5.7.43)
 Source Host           : 192.168.41.10:3306
 Source Schema         : cmdb

 Target Server Type    : MySQL
 Target Server Version : 50743 (5.7.43)
 File Encoding         : 65001

 Date: 04/01/2024 21:37:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for acl_apps
-- ----------------------------
DROP TABLE IF EXISTS `acl_apps`;
CREATE TABLE `acl_apps` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `app_id` text COLLATE utf8_unicode_ci,
  `secret_key` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `ix_acl_apps_name` (`name`),
  KEY `ix_acl_apps_deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for acl_audit_login_logs
-- ----------------------------
DROP TABLE IF EXISTS `acl_audit_login_logs`;
CREATE TABLE `acl_audit_login_logs` (
  `created_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel` enum('web','api') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `browser` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_ok` tinyint(1) DEFAULT NULL,
  `login_at` datetime DEFAULT NULL,
  `logout_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_acl_audit_login_logs_created_at` (`created_at`),
  KEY `ix_acl_audit_login_logs_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for acl_audit_permission_logs
-- ----------------------------
DROP TABLE IF EXISTS `acl_audit_permission_logs`;
CREATE TABLE `acl_audit_permission_logs` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` int(11) DEFAULT NULL,
  `operate_uid` int(11) DEFAULT NULL COMMENT '操作人uid',
  `operate_type` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '操作类型',
  `rid` int(11) DEFAULT NULL COMMENT '角色id',
  `resource_type_id` int(11) DEFAULT NULL COMMENT '资源类型id',
  `resource_ids` json DEFAULT NULL COMMENT '资源',
  `group_ids` json DEFAULT NULL COMMENT '资源组',
  `permission_ids` json DEFAULT NULL COMMENT '权限',
  `source` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '来源',
  PRIMARY KEY (`id`),
  KEY `ix_acl_audit_permission_logs_deleted` (`deleted`),
  KEY `ix_acl_audit_permission_logs_rid` (`rid`),
  KEY `ix_acl_audit_permission_logs_app_id` (`app_id`),
  KEY `ix_acl_audit_permission_logs_operate_uid` (`operate_uid`),
  KEY `ix_acl_audit_permission_logs_resource_type_id` (`resource_type_id`),
  KEY `ix_acl_audit_permission_logs_operate_type` (`operate_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for acl_audit_resource_logs
-- ----------------------------
DROP TABLE IF EXISTS `acl_audit_resource_logs`;
CREATE TABLE `acl_audit_resource_logs` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` int(11) DEFAULT NULL,
  `operate_uid` int(11) DEFAULT NULL COMMENT '操作人uid',
  `operate_type` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '操作类型',
  `scope` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '范围',
  `link_id` int(11) DEFAULT NULL COMMENT '资源名',
  `origin` json DEFAULT NULL COMMENT '原始数据',
  `current` json DEFAULT NULL COMMENT '当前数据',
  `extra` json DEFAULT NULL COMMENT '权限名',
  `source` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '来源',
  PRIMARY KEY (`id`),
  KEY `ix_acl_audit_resource_logs_operate_uid` (`operate_uid`),
  KEY `ix_acl_audit_resource_logs_operate_type` (`operate_type`),
  KEY `ix_acl_audit_resource_logs_deleted` (`deleted`),
  KEY `ix_acl_audit_resource_logs_app_id` (`app_id`),
  KEY `ix_acl_audit_resource_logs_link_id` (`link_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for acl_audit_role_logs
-- ----------------------------
DROP TABLE IF EXISTS `acl_audit_role_logs`;
CREATE TABLE `acl_audit_role_logs` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` int(11) DEFAULT NULL,
  `operate_uid` int(11) DEFAULT NULL COMMENT '操作人uid',
  `operate_type` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '操作类型',
  `scope` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '范围',
  `link_id` int(11) DEFAULT NULL COMMENT '资源id',
  `origin` json DEFAULT NULL COMMENT '原始数据',
  `current` json DEFAULT NULL COMMENT '当前数据',
  `extra` json DEFAULT NULL COMMENT '其他内容',
  `source` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '来源',
  PRIMARY KEY (`id`),
  KEY `ix_acl_audit_role_logs_app_id` (`app_id`),
  KEY `ix_acl_audit_role_logs_link_id` (`link_id`),
  KEY `ix_acl_audit_role_logs_operate_type` (`operate_type`),
  KEY `ix_acl_audit_role_logs_deleted` (`deleted`),
  KEY `ix_acl_audit_role_logs_operate_uid` (`operate_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for acl_audit_trigger_logs
-- ----------------------------
DROP TABLE IF EXISTS `acl_audit_trigger_logs`;
CREATE TABLE `acl_audit_trigger_logs` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` int(11) DEFAULT NULL,
  `trigger_id` int(11) DEFAULT NULL COMMENT 'trigger',
  `operate_uid` int(11) DEFAULT NULL COMMENT '操作人uid',
  `operate_type` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '操作类型',
  `origin` json DEFAULT NULL COMMENT '原始数据',
  `current` json DEFAULT NULL COMMENT '当前数据',
  `extra` json DEFAULT NULL COMMENT '权限名',
  `source` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '来源',
  PRIMARY KEY (`id`),
  KEY `ix_acl_audit_trigger_logs_operate_type` (`operate_type`),
  KEY `ix_acl_audit_trigger_logs_deleted` (`deleted`),
  KEY `ix_acl_audit_trigger_logs_trigger_id` (`trigger_id`),
  KEY `ix_acl_audit_trigger_logs_operate_uid` (`operate_uid`),
  KEY `ix_acl_audit_trigger_logs_app_id` (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for acl_operation_records
-- ----------------------------
DROP TABLE IF EXISTS `acl_operation_records`;
CREATE TABLE `acl_operation_records` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rolename` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `operate` enum('2','4','1','3','0') COLLATE utf8_unicode_ci NOT NULL,
  `obj` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_acl_operation_records_rolename` (`rolename`),
  KEY `ix_acl_operation_records_app` (`app`),
  KEY `ix_acl_operation_records_deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for acl_permissions
-- ----------------------------
DROP TABLE IF EXISTS `acl_permissions`;
CREATE TABLE `acl_permissions` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `resource_type_id` int(11) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `resource_type_id` (`resource_type_id`),
  KEY `app_id` (`app_id`),
  KEY `ix_acl_permissions_deleted` (`deleted`),
  CONSTRAINT `acl_permissions_ibfk_1` FOREIGN KEY (`resource_type_id`) REFERENCES `acl_resource_types` (`id`),
  CONSTRAINT `acl_permissions_ibfk_2` FOREIGN KEY (`app_id`) REFERENCES `acl_apps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for acl_resource_group_items
-- ----------------------------
DROP TABLE IF EXISTS `acl_resource_group_items`;
CREATE TABLE `acl_resource_group_items` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `resource_id` (`resource_id`),
  KEY `ix_acl_resource_group_items_deleted` (`deleted`),
  CONSTRAINT `acl_resource_group_items_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `acl_resource_groups` (`id`),
  CONSTRAINT `acl_resource_group_items_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `acl_resources` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for acl_resource_groups
-- ----------------------------
DROP TABLE IF EXISTS `acl_resource_groups`;
CREATE TABLE `acl_resource_groups` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `resource_type_id` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `resource_type_id` (`resource_type_id`),
  KEY `app_id` (`app_id`),
  KEY `ix_acl_resource_groups_name` (`name`),
  KEY `ix_acl_resource_groups_deleted` (`deleted`),
  KEY `ix_acl_resource_groups_uid` (`uid`),
  CONSTRAINT `acl_resource_groups_ibfk_1` FOREIGN KEY (`resource_type_id`) REFERENCES `acl_resource_types` (`id`),
  CONSTRAINT `acl_resource_groups_ibfk_2` FOREIGN KEY (`app_id`) REFERENCES `acl_apps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for acl_resource_types
-- ----------------------------
DROP TABLE IF EXISTS `acl_resource_types`;
CREATE TABLE `acl_resource_types` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `app_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_id` (`app_id`),
  KEY `ix_acl_resource_types_deleted` (`deleted`),
  KEY `ix_acl_resource_types_name` (`name`),
  CONSTRAINT `acl_resource_types_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `acl_apps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for acl_resources
-- ----------------------------
DROP TABLE IF EXISTS `acl_resources`;
CREATE TABLE `acl_resources` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `resource_type_id` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `resource_type_id` (`resource_type_id`),
  KEY `app_id` (`app_id`),
  KEY `ix_acl_resources_deleted` (`deleted`),
  KEY `ix_acl_resources_uid` (`uid`),
  CONSTRAINT `acl_resources_ibfk_1` FOREIGN KEY (`resource_type_id`) REFERENCES `acl_resource_types` (`id`),
  CONSTRAINT `acl_resources_ibfk_2` FOREIGN KEY (`app_id`) REFERENCES `acl_apps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for acl_role_permissions
-- ----------------------------
DROP TABLE IF EXISTS `acl_role_permissions`;
CREATE TABLE `acl_role_permissions` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rid` int(11) DEFAULT NULL,
  `resource_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `perm_id` int(11) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rid` (`rid`),
  KEY `resource_id` (`resource_id`),
  KEY `group_id` (`group_id`),
  KEY `perm_id` (`perm_id`),
  KEY `app_id` (`app_id`),
  KEY `ix_acl_role_permissions_deleted` (`deleted`),
  CONSTRAINT `acl_role_permissions_ibfk_1` FOREIGN KEY (`rid`) REFERENCES `acl_roles` (`id`),
  CONSTRAINT `acl_role_permissions_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `acl_resources` (`id`),
  CONSTRAINT `acl_role_permissions_ibfk_3` FOREIGN KEY (`group_id`) REFERENCES `acl_resource_groups` (`id`),
  CONSTRAINT `acl_role_permissions_ibfk_4` FOREIGN KEY (`perm_id`) REFERENCES `acl_permissions` (`id`),
  CONSTRAINT `acl_role_permissions_ibfk_5` FOREIGN KEY (`app_id`) REFERENCES `acl_apps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for acl_role_relations
-- ----------------------------
DROP TABLE IF EXISTS `acl_role_relations`;
CREATE TABLE `acl_role_relations` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `child_id` int(11) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `child_id` (`child_id`),
  KEY `app_id` (`app_id`),
  KEY `ix_acl_role_relations_deleted` (`deleted`),
  CONSTRAINT `acl_role_relations_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `acl_roles` (`id`),
  CONSTRAINT `acl_role_relations_ibfk_2` FOREIGN KEY (`child_id`) REFERENCES `acl_roles` (`id`),
  CONSTRAINT `acl_role_relations_ibfk_3` FOREIGN KEY (`app_id`) REFERENCES `acl_apps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for acl_roles
-- ----------------------------
DROP TABLE IF EXISTS `acl_roles`;
CREATE TABLE `acl_roles` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `is_app_admin` tinyint(1) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `key` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `secret` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_id` (`app_id`),
  KEY `ix_acl_roles_deleted` (`deleted`),
  KEY `ix_acl_roles_name` (`name`),
  CONSTRAINT `acl_roles_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `acl_apps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for acl_triggers
-- ----------------------------
DROP TABLE IF EXISTS `acl_triggers`;
CREATE TABLE `acl_triggers` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `wildcard` text COLLATE utf8_unicode_ci,
  `uid` text COLLATE utf8_unicode_ci,
  `resource_type_id` int(11) DEFAULT NULL,
  `roles` text COLLATE utf8_unicode_ci,
  `permissions` text COLLATE utf8_unicode_ci,
  `enabled` tinyint(1) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `resource_type_id` (`resource_type_id`),
  KEY `app_id` (`app_id`),
  KEY `ix_acl_triggers_deleted` (`deleted`),
  CONSTRAINT `acl_triggers_ibfk_1` FOREIGN KEY (`resource_type_id`) REFERENCES `acl_resource_types` (`id`),
  CONSTRAINT `acl_triggers_ibfk_2` FOREIGN KEY (`app_id`) REFERENCES `acl_apps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_ad_ci
-- ----------------------------
DROP TABLE IF EXISTS `c_ad_ci`;
CREATE TABLE `c_ad_ci` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) DEFAULT NULL,
  `adt_id` int(11) DEFAULT NULL,
  `unique_value` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `instance` json DEFAULT NULL,
  `ci_id` int(11) DEFAULT NULL,
  `is_accept` tinyint(1) DEFAULT NULL,
  `accept_by` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accept_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  KEY `adt_id` (`adt_id`),
  KEY `ix_c_ad_ci_accept_by` (`accept_by`),
  KEY `ix_c_ad_ci_deleted` (`deleted`),
  KEY `ix_c_ad_ci_ci_id` (`ci_id`),
  KEY `ix_c_ad_ci_unique_value` (`unique_value`),
  CONSTRAINT `c_ad_ci_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `c_ci_types` (`id`),
  CONSTRAINT `c_ad_ci_ibfk_2` FOREIGN KEY (`adt_id`) REFERENCES `c_ad_ci_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_ad_ci_types
-- ----------------------------
DROP TABLE IF EXISTS `c_ad_ci_types`;
CREATE TABLE `c_ad_ci_types` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) DEFAULT NULL,
  `adr_id` int(11) DEFAULT NULL,
  `attributes` json DEFAULT NULL,
  `relation` json DEFAULT NULL,
  `auto_accept` tinyint(1) DEFAULT NULL,
  `agent_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `query_expr` text COLLATE utf8_unicode_ci,
  `interval` int(11) DEFAULT NULL,
  `cron` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extra_option` json DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  KEY `adr_id` (`adr_id`),
  KEY `ix_c_ad_ci_types_uid` (`uid`),
  KEY `ix_c_ad_ci_types_agent_id` (`agent_id`),
  KEY `ix_c_ad_ci_types_deleted` (`deleted`),
  CONSTRAINT `c_ad_ci_types_ibfk2` FOREIGN KEY (`adr_id`) REFERENCES `c_ad_rules` (`id`),
  CONSTRAINT `c_ad_ci_types_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `c_ci_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_ad_rules
-- ----------------------------
DROP TABLE IF EXISTS `c_ad_rules`;
CREATE TABLE `c_ad_rules` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` enum('snmp','agent','http') COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_inner` tinyint(1) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `option` json DEFAULT NULL,
  `attributes` json DEFAULT NULL,
  `is_plugin` tinyint(1) DEFAULT NULL,
  `plugin_script` text COLLATE utf8_unicode_ci,
  `unique_key` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_c_ad_rules_type` (`type`),
  KEY `ix_c_ad_rules_deleted` (`deleted`),
  KEY `ix_c_ad_rules_is_inner` (`is_inner`),
  KEY `ix_c_ad_rules_owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_attribute_histories
-- ----------------------------
DROP TABLE IF EXISTS `c_attribute_histories`;
CREATE TABLE `c_attribute_histories` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_type` enum('1','2','0') COLLATE utf8_unicode_ci DEFAULT NULL,
  `record_id` int(11) NOT NULL,
  `ci_id` int(11) NOT NULL,
  `attr_id` int(11) DEFAULT NULL,
  `old` text COLLATE utf8_unicode_ci,
  `new` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `record_id` (`record_id`),
  KEY `ix_c_attribute_histories_attr_id` (`attr_id`),
  KEY `ix_c_attribute_histories_ci_id` (`ci_id`),
  KEY `ix_c_attribute_histories_deleted` (`deleted`),
  CONSTRAINT `c_attribute_histories_ibfk_1` FOREIGN KEY (`record_id`) REFERENCES `c_records` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_attributes
-- ----------------------------
DROP TABLE IF EXISTS `c_attributes`;
CREATE TABLE `c_attributes` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `alias` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `value_type` enum('4','6','2','1','5','3','0') COLLATE utf8_unicode_ci NOT NULL,
  `is_choice` tinyint(1) DEFAULT NULL,
  `is_list` tinyint(1) DEFAULT NULL,
  `is_unique` tinyint(1) DEFAULT NULL,
  `is_index` tinyint(1) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `is_computed` tinyint(4) DEFAULT '0',
  `is_link` tinyint(1) DEFAULT NULL,
  `choice_web_hook` json DEFAULT NULL,
  `option` json DEFAULT NULL,
  `is_password` tinyint(1) DEFAULT NULL,
  `compute_script` text COLLATE utf8_unicode_ci,
  `compute_expr` text COLLATE utf8_unicode_ci,
  `is_sortable` tinyint(1) DEFAULT NULL,
  `default` json DEFAULT NULL,
  `choice_other` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_c_attributes_deleted` (`deleted`),
  KEY `idx_c_attributes_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_c_d
-- ----------------------------
DROP TABLE IF EXISTS `c_c_d`;
CREATE TABLE `c_c_d` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category` smallint(6) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `attr_id` int(11) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `options` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  KEY `attr_id` (`attr_id`),
  KEY `ix_c_custom_dashboard_deleted` (`deleted`),
  CONSTRAINT `c_c_d_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `c_ci_types` (`id`),
  CONSTRAINT `c_c_d_ibfk_2` FOREIGN KEY (`attr_id`) REFERENCES `c_attributes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_c_t_t
-- ----------------------------
DROP TABLE IF EXISTS `c_c_t_t`;
CREATE TABLE `c_c_t_t` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `attr_id` int(11) DEFAULT NULL,
  `notify` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  KEY `attr_id` (`attr_id`),
  KEY `ix_c_ci_type_triggers_deleted` (`deleted`),
  CONSTRAINT `c_c_t_t_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `c_ci_types` (`id`),
  CONSTRAINT `c_c_t_t_ibfk_2` FOREIGN KEY (`attr_id`) REFERENCES `c_attributes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_c_t_u_c
-- ----------------------------
DROP TABLE IF EXISTS `c_c_t_u_c`;
CREATE TABLE `c_c_t_u_c` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `attr_ids` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  KEY `ix_c_ci_type_unique_constraints_deleted` (`deleted`),
  CONSTRAINT `c_c_t_u_c_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `c_ci_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_cfp
-- ----------------------------
DROP TABLE IF EXISTS `c_cfp`;
CREATE TABLE `c_cfp` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `a` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `b` int(11) DEFAULT NULL,
  `c` text COLLATE utf8_unicode_ci,
  `d` text COLLATE utf8_unicode_ci,
  `e` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `b` (`b`),
  KEY `ix_c_cfp_deleted` (`deleted`),
  KEY `ix_c_cfp_e` (`e`),
  KEY `ix_c_cfp_a` (`a`),
  CONSTRAINT `c_cfp_ibfk_1` FOREIGN KEY (`b`) REFERENCES `c_ci_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_choice_floats
-- ----------------------------
DROP TABLE IF EXISTS `c_choice_floats`;
CREATE TABLE `c_choice_floats` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attr_id` int(11) NOT NULL,
  `value` float NOT NULL,
  `option` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attr_id` (`attr_id`),
  KEY `ix_c_choice_floats_deleted` (`deleted`),
  CONSTRAINT `c_choice_floats_ibfk_1` FOREIGN KEY (`attr_id`) REFERENCES `c_attributes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_choice_integers
-- ----------------------------
DROP TABLE IF EXISTS `c_choice_integers`;
CREATE TABLE `c_choice_integers` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attr_id` int(11) NOT NULL,
  `value` int(11) NOT NULL,
  `option` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attr_id` (`attr_id`),
  KEY `ix_c_choice_integers_deleted` (`deleted`),
  CONSTRAINT `c_choice_integers_ibfk_1` FOREIGN KEY (`attr_id`) REFERENCES `c_attributes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_choice_texts
-- ----------------------------
DROP TABLE IF EXISTS `c_choice_texts`;
CREATE TABLE `c_choice_texts` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attr_id` int(11) NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  `option` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attr_id` (`attr_id`),
  KEY `ix_c_choice_texts_deleted` (`deleted`),
  CONSTRAINT `c_choice_texts_ibfk_1` FOREIGN KEY (`attr_id`) REFERENCES `c_attributes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_ci_filter_perms
-- ----------------------------
DROP TABLE IF EXISTS `c_ci_filter_perms`;
CREATE TABLE `c_ci_filter_perms` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `ci_filter` text COLLATE utf8_unicode_ci,
  `attr_filter` text COLLATE utf8_unicode_ci,
  `rid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  KEY `ix_c_ci_filter_perms_rid` (`rid`),
  KEY `ix_c_ci_filter_perms_name` (`name`),
  KEY `ix_c_ci_filter_perms_deleted` (`deleted`),
  CONSTRAINT `c_ci_filter_perms_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `c_ci_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_ci_relations
-- ----------------------------
DROP TABLE IF EXISTS `c_ci_relations`;
CREATE TABLE `c_ci_relations` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_ci_id` int(11) NOT NULL,
  `second_ci_id` int(11) NOT NULL,
  `relation_type_id` int(11) NOT NULL,
  `more` int(11) DEFAULT NULL,
  `ancestor_ids` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `first_ci_id` (`first_ci_id`),
  KEY `second_ci_id` (`second_ci_id`),
  KEY `relation_type_id` (`relation_type_id`),
  KEY `more` (`more`),
  KEY `ix_c_ci_relations_deleted` (`deleted`),
  CONSTRAINT `c_ci_relations_ibfk_1` FOREIGN KEY (`first_ci_id`) REFERENCES `c_cis` (`id`),
  CONSTRAINT `c_ci_relations_ibfk_2` FOREIGN KEY (`second_ci_id`) REFERENCES `c_cis` (`id`),
  CONSTRAINT `c_ci_relations_ibfk_3` FOREIGN KEY (`relation_type_id`) REFERENCES `c_relation_types` (`id`),
  CONSTRAINT `c_ci_relations_ibfk_4` FOREIGN KEY (`more`) REFERENCES `c_cis` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_ci_trigger_histories
-- ----------------------------
DROP TABLE IF EXISTS `c_ci_trigger_histories`;
CREATE TABLE `c_ci_trigger_histories` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_type` enum('1','0','2') DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `ci_id` int(11) NOT NULL,
  `trigger_id` int(11) DEFAULT NULL,
  `trigger_name` varchar(64) DEFAULT NULL,
  `is_ok` tinyint(1) DEFAULT NULL,
  `notify` text,
  `webhook` text,
  PRIMARY KEY (`id`),
  KEY `record_id` (`record_id`),
  KEY `trigger_id` (`trigger_id`),
  KEY `ix_c_ci_trigger_histories_ci_id` (`ci_id`),
  KEY `ix_c_ci_trigger_histories_deleted` (`deleted`),
  CONSTRAINT `c_ci_trigger_histories_ibfk_1` FOREIGN KEY (`record_id`) REFERENCES `c_records` (`id`),
  CONSTRAINT `c_ci_trigger_histories_ibfk_2` FOREIGN KEY (`trigger_id`) REFERENCES `c_c_t_t` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for c_ci_type_attribute_group_items
-- ----------------------------
DROP TABLE IF EXISTS `c_ci_type_attribute_group_items`;
CREATE TABLE `c_ci_type_attribute_group_items` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `attr_id` int(11) NOT NULL,
  `order` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `attr_id` (`attr_id`),
  KEY `ix_c_ci_type_attribute_group_items_deleted` (`deleted`),
  CONSTRAINT `c_ci_type_attribute_group_items_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `c_ci_type_attribute_groups` (`id`),
  CONSTRAINT `c_ci_type_attribute_group_items_ibfk_2` FOREIGN KEY (`attr_id`) REFERENCES `c_attributes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_ci_type_attribute_groups
-- ----------------------------
DROP TABLE IF EXISTS `c_ci_type_attribute_groups`;
CREATE TABLE `c_ci_type_attribute_groups` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `type_id` int(11) NOT NULL,
  `order` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  KEY `ix_c_ci_type_attribute_groups_deleted` (`deleted`),
  CONSTRAINT `c_ci_type_attribute_groups_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `c_ci_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_ci_type_attributes
-- ----------------------------
DROP TABLE IF EXISTS `c_ci_type_attributes`;
CREATE TABLE `c_ci_type_attributes` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `attr_id` int(11) NOT NULL,
  `order` int(11) DEFAULT NULL,
  `is_required` tinyint(1) DEFAULT NULL,
  `default_show` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  KEY `attr_id` (`attr_id`),
  KEY `ix_c_ci_type_attributes_deleted` (`deleted`),
  CONSTRAINT `c_ci_type_attributes_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `c_ci_types` (`id`),
  CONSTRAINT `c_ci_type_attributes_ibfk_2` FOREIGN KEY (`attr_id`) REFERENCES `c_attributes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_ci_type_group_items
-- ----------------------------
DROP TABLE IF EXISTS `c_ci_type_group_items`;
CREATE TABLE `c_ci_type_group_items` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `order` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `type_id` (`type_id`),
  KEY `ix_c_ci_type_group_items_deleted` (`deleted`),
  CONSTRAINT `c_ci_type_group_items_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `c_ci_type_groups` (`id`),
  CONSTRAINT `c_ci_type_group_items_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `c_ci_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_ci_type_groups
-- ----------------------------
DROP TABLE IF EXISTS `c_ci_type_groups`;
CREATE TABLE `c_ci_type_groups` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_c_ci_type_groups_deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_ci_type_histories
-- ----------------------------
DROP TABLE IF EXISTS `c_ci_type_histories`;
CREATE TABLE `c_ci_type_histories` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_type` enum('1','12','11','9','0','10','4','13','6','2','5','3','7','8') COLLATE utf8_unicode_ci DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `attr_id` int(11) DEFAULT NULL,
  `trigger_id` int(11) DEFAULT NULL,
  `unique_constraint_id` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `change` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_c_ci_type_histories_uid` (`uid`),
  KEY `ix_c_ci_type_histories_deleted` (`deleted`),
  KEY `ix_c_ci_type_histories_type_id` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_ci_type_relations
-- ----------------------------
DROP TABLE IF EXISTS `c_ci_type_relations`;
CREATE TABLE `c_ci_type_relations` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `child_id` int(11) NOT NULL,
  `relation_type_id` int(11) NOT NULL,
  `constraint` enum('0','1','2') COLLATE utf8_unicode_ci DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `child_id` (`child_id`),
  KEY `relation_type_id` (`relation_type_id`),
  KEY `ix_c_ci_type_relations_deleted` (`deleted`),
  CONSTRAINT `c_ci_type_relations_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `c_ci_types` (`id`),
  CONSTRAINT `c_ci_type_relations_ibfk_2` FOREIGN KEY (`child_id`) REFERENCES `c_ci_types` (`id`),
  CONSTRAINT `c_ci_type_relations_ibfk_3` FOREIGN KEY (`relation_type_id`) REFERENCES `c_relation_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_ci_types
-- ----------------------------
DROP TABLE IF EXISTS `c_ci_types`;
CREATE TABLE `c_ci_types` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `alias` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `unique_id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `is_attached` tinyint(1) NOT NULL,
  `order` smallint(6) NOT NULL,
  `uid` int(11) DEFAULT NULL,
  `icon` text COLLATE utf8_unicode_ci,
  `default_order_attr` varchar(33) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `unique_id` (`unique_id`),
  KEY `ix_c_ci_types_deleted` (`deleted`),
  KEY `c_ci_types_uid` (`uid`),
  CONSTRAINT `c_ci_types_ibfk_1` FOREIGN KEY (`unique_id`) REFERENCES `c_attributes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_cis
-- ----------------------------
DROP TABLE IF EXISTS `c_cis`;
CREATE TABLE `c_cis` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `status` enum('1','0') COLLATE utf8_unicode_ci DEFAULT NULL,
  `heartbeat` datetime DEFAULT NULL,
  `a` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  KEY `ix_c_cis_deleted` (`deleted`),
  CONSTRAINT `c_cis_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `c_ci_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_kv
-- ----------------------------
DROP TABLE IF EXISTS `c_kv`;
CREATE TABLE `c_kv` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `ix_c_kv_key` (`key`),
  KEY `ix_c_kv_deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for c_prv
-- ----------------------------
DROP TABLE IF EXISTS `c_prv`;
CREATE TABLE `c_prv` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `cr_ids` json DEFAULT NULL,
  `is_public` tinyint(4) DEFAULT '0',
  `uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_c_preference_relation_views_name` (`name`),
  KEY `ix_c_preference_relation_views_deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_psa
-- ----------------------------
DROP TABLE IF EXISTS `c_psa`;
CREATE TABLE `c_psa` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `attr_id` int(11) DEFAULT NULL,
  `order` smallint(6) DEFAULT NULL,
  `is_fixed` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  KEY `attr_id` (`attr_id`),
  KEY `ix_c_preference_show_attributes_deleted` (`deleted`),
  KEY `ix_c_preference_show_attributes_uid` (`uid`),
  CONSTRAINT `c_psa_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `c_ci_types` (`id`),
  CONSTRAINT `c_psa_ibfk_2` FOREIGN KEY (`attr_id`) REFERENCES `c_attributes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_pso
-- ----------------------------
DROP TABLE IF EXISTS `c_pso`;
CREATE TABLE `c_pso` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prv_id` int(11) DEFAULT NULL,
  `ptv_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `option` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prv_id` (`prv_id`),
  KEY `ptv_id` (`ptv_id`),
  KEY `type_id` (`type_id`),
  KEY `ix_c_pso_uid` (`uid`),
  KEY `ix_c_pso_deleted` (`deleted`),
  CONSTRAINT `c_pso_ibfk_1` FOREIGN KEY (`prv_id`) REFERENCES `c_prv` (`id`),
  CONSTRAINT `c_pso_ibfk_2` FOREIGN KEY (`ptv_id`) REFERENCES `c_ptv` (`id`),
  CONSTRAINT `c_pso_ibfk_3` FOREIGN KEY (`type_id`) REFERENCES `c_ci_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_ptv
-- ----------------------------
DROP TABLE IF EXISTS `c_ptv`;
CREATE TABLE `c_ptv` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `levels` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  KEY `ix_c_preference_tree_views_uid` (`uid`),
  KEY `ix_c_preference_tree_views_deleted` (`deleted`),
  CONSTRAINT `c_ptv_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `c_ci_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_records
-- ----------------------------
DROP TABLE IF EXISTS `c_records`;
CREATE TABLE `c_records` (
  `created_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `origin` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ticket_id` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reason` text COLLATE utf8_unicode_ci,
  `type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_c_records_created_at` (`created_at`),
  KEY `ix_c_records_type_id` (`type_id`),
  KEY `ix_c_records_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_relation_histories
-- ----------------------------
DROP TABLE IF EXISTS `c_relation_histories`;
CREATE TABLE `c_relation_histories` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_type` enum('0','1') COLLATE utf8_unicode_ci DEFAULT NULL,
  `record_id` int(11) NOT NULL,
  `first_ci_id` int(11) DEFAULT NULL,
  `second_ci_id` int(11) DEFAULT NULL,
  `relation_type_id` int(11) DEFAULT NULL,
  `relation_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `record_id` (`record_id`),
  KEY `relation_type_id` (`relation_type_id`),
  KEY `ix_c_relation_histories_deleted` (`deleted`),
  CONSTRAINT `c_relation_histories_ibfk_1` FOREIGN KEY (`record_id`) REFERENCES `c_records` (`id`),
  CONSTRAINT `c_relation_histories_ibfk_2` FOREIGN KEY (`relation_type_id`) REFERENCES `c_relation_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_relation_types
-- ----------------------------
DROP TABLE IF EXISTS `c_relation_types`;
CREATE TABLE `c_relation_types` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_c_relation_types_name` (`name`),
  KEY `ix_c_relation_types_deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_sc
-- ----------------------------
DROP TABLE IF EXISTS `c_sc`;
CREATE TABLE `c_sc` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `option` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_c_sc_name` (`name`),
  KEY `ix_c_sc_deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_value_datetime
-- ----------------------------
DROP TABLE IF EXISTS `c_value_datetime`;
CREATE TABLE `c_value_datetime` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ci_id` int(11) NOT NULL,
  `attr_id` int(11) NOT NULL,
  `value` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ci_id` (`ci_id`),
  KEY `attr_id` (`attr_id`),
  KEY `ix_c_value_datetime_deleted` (`deleted`),
  CONSTRAINT `c_value_datetime_ibfk_1` FOREIGN KEY (`ci_id`) REFERENCES `c_cis` (`id`),
  CONSTRAINT `c_value_datetime_ibfk_2` FOREIGN KEY (`attr_id`) REFERENCES `c_attributes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_value_floats
-- ----------------------------
DROP TABLE IF EXISTS `c_value_floats`;
CREATE TABLE `c_value_floats` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ci_id` int(11) NOT NULL,
  `attr_id` int(11) NOT NULL,
  `value` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ci_id` (`ci_id`),
  KEY `attr_id` (`attr_id`),
  KEY `ix_c_value_floats_deleted` (`deleted`),
  CONSTRAINT `c_value_floats_ibfk_1` FOREIGN KEY (`ci_id`) REFERENCES `c_cis` (`id`),
  CONSTRAINT `c_value_floats_ibfk_2` FOREIGN KEY (`attr_id`) REFERENCES `c_attributes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_value_index_datetime
-- ----------------------------
DROP TABLE IF EXISTS `c_value_index_datetime`;
CREATE TABLE `c_value_index_datetime` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ci_id` int(11) NOT NULL,
  `attr_id` int(11) NOT NULL,
  `value` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ci_id` (`ci_id`),
  KEY `datetime_attr_value_index` (`attr_id`,`value`),
  KEY `ix_c_value_index_datetime_deleted` (`deleted`),
  CONSTRAINT `c_value_index_datetime_ibfk_1` FOREIGN KEY (`ci_id`) REFERENCES `c_cis` (`id`),
  CONSTRAINT `c_value_index_datetime_ibfk_2` FOREIGN KEY (`attr_id`) REFERENCES `c_attributes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_value_index_floats
-- ----------------------------
DROP TABLE IF EXISTS `c_value_index_floats`;
CREATE TABLE `c_value_index_floats` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ci_id` int(11) NOT NULL,
  `attr_id` int(11) NOT NULL,
  `value` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ci_id` (`ci_id`),
  KEY `float_attr_value_index` (`attr_id`,`value`),
  KEY `ix_c_value_index_floats_deleted` (`deleted`),
  CONSTRAINT `c_value_index_floats_ibfk_1` FOREIGN KEY (`ci_id`) REFERENCES `c_cis` (`id`),
  CONSTRAINT `c_value_index_floats_ibfk_2` FOREIGN KEY (`attr_id`) REFERENCES `c_attributes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_value_index_integers
-- ----------------------------
DROP TABLE IF EXISTS `c_value_index_integers`;
CREATE TABLE `c_value_index_integers` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ci_id` int(11) NOT NULL,
  `attr_id` int(11) NOT NULL,
  `value` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ci_id` (`ci_id`),
  KEY `integer_attr_value_index` (`attr_id`,`value`),
  KEY `ix_c_value_index_integers_deleted` (`deleted`),
  CONSTRAINT `c_value_index_integers_ibfk_1` FOREIGN KEY (`ci_id`) REFERENCES `c_cis` (`id`),
  CONSTRAINT `c_value_index_integers_ibfk_2` FOREIGN KEY (`attr_id`) REFERENCES `c_attributes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_value_index_texts
-- ----------------------------
DROP TABLE IF EXISTS `c_value_index_texts`;
CREATE TABLE `c_value_index_texts` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ci_id` int(11) NOT NULL,
  `attr_id` int(11) NOT NULL,
  `value` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ci_id` (`ci_id`),
  KEY `ix_c_value_index_texts_deleted` (`deleted`),
  KEY `text_attr_value_index` (`attr_id`,`value`),
  CONSTRAINT `c_value_index_texts_ibfk_1` FOREIGN KEY (`ci_id`) REFERENCES `c_cis` (`id`),
  CONSTRAINT `c_value_index_texts_ibfk_2` FOREIGN KEY (`attr_id`) REFERENCES `c_attributes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_value_integers
-- ----------------------------
DROP TABLE IF EXISTS `c_value_integers`;
CREATE TABLE `c_value_integers` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ci_id` int(11) NOT NULL,
  `attr_id` int(11) NOT NULL,
  `value` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ci_id` (`ci_id`),
  KEY `attr_id` (`attr_id`),
  KEY `ix_c_value_integers_deleted` (`deleted`),
  CONSTRAINT `c_value_integers_ibfk_1` FOREIGN KEY (`ci_id`) REFERENCES `c_cis` (`id`),
  CONSTRAINT `c_value_integers_ibfk_2` FOREIGN KEY (`attr_id`) REFERENCES `c_attributes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_value_json
-- ----------------------------
DROP TABLE IF EXISTS `c_value_json`;
CREATE TABLE `c_value_json` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ci_id` int(11) NOT NULL,
  `attr_id` int(11) NOT NULL,
  `value` json NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ci_id` (`ci_id`),
  KEY `attr_id` (`attr_id`),
  KEY `ix_c_value_json_deleted` (`deleted`),
  CONSTRAINT `c_value_json_ibfk_1` FOREIGN KEY (`ci_id`) REFERENCES `c_cis` (`id`),
  CONSTRAINT `c_value_json_ibfk_2` FOREIGN KEY (`attr_id`) REFERENCES `c_attributes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for c_value_texts
-- ----------------------------
DROP TABLE IF EXISTS `c_value_texts`;
CREATE TABLE `c_value_texts` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ci_id` int(11) NOT NULL,
  `attr_id` int(11) NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ci_id` (`ci_id`),
  KEY `attr_id` (`attr_id`),
  KEY `ix_c_value_texts_deleted` (`deleted`),
  CONSTRAINT `c_value_texts_ibfk_1` FOREIGN KEY (`ci_id`) REFERENCES `c_cis` (`id`),
  CONSTRAINT `c_value_texts_ibfk_2` FOREIGN KEY (`attr_id`) REFERENCES `c_attributes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for common_company_info_json
-- ----------------------------
DROP TABLE IF EXISTS `common_company_info_json`;
CREATE TABLE `common_company_info_json` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `info` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_common_company_info_json_deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for common_data
-- ----------------------------
DROP TABLE IF EXISTS `common_data`;
CREATE TABLE `common_data` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_common_data_deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for common_department
-- ----------------------------
DROP TABLE IF EXISTS `common_department`;
CREATE TABLE `common_department` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '部门名称',
  `department_director_id` int(11) DEFAULT NULL COMMENT '部门负责人ID',
  `department_parent_id` int(11) DEFAULT NULL COMMENT '上级部门ID',
  `sort_value` int(11) DEFAULT NULL COMMENT '排序值',
  `acl_rid` int(11) DEFAULT NULL COMMENT 'ACL中rid',
  PRIMARY KEY (`department_id`),
  KEY `ix_common_department_deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for common_employee
-- ----------------------------
DROP TABLE IF EXISTS `common_employee`;
CREATE TABLE `common_employee` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `employee_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '用户名',
  `nickname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '姓名',
  `sex` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '性别',
  `position_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '职位名称',
  `mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '电话号码',
  `avatar` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '头像',
  `direct_supervisor_id` int(11) DEFAULT NULL COMMENT '直接上级ID',
  `department_id` int(11) DEFAULT NULL COMMENT '部门ID',
  `acl_uid` int(11) DEFAULT NULL COMMENT 'ACL中uid',
  `acl_rid` int(11) DEFAULT NULL COMMENT 'ACL中rid',
  `acl_virtual_rid` int(11) DEFAULT NULL COMMENT 'ACL中虚拟角色rid',
  `last_login` timestamp NULL DEFAULT NULL COMMENT '上次登录时间',
  `block` int(11) DEFAULT NULL COMMENT '锁定状态',
  `notice_info` json DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `department_id` (`department_id`),
  KEY `ix_common_employee_deleted` (`deleted`),
  CONSTRAINT `common_employee_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `common_department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for common_employee_info
-- ----------------------------
DROP TABLE IF EXISTS `common_employee_info`;
CREATE TABLE `common_employee_info` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `info` json DEFAULT NULL COMMENT '员工信息',
  `employee_id` int(11) DEFAULT NULL COMMENT '员工ID',
  PRIMARY KEY (`id`),
  KEY `employee_id` (`employee_id`),
  KEY `ix_common_employee_info_deleted` (`deleted`),
  CONSTRAINT `common_employee_info_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `common_employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for common_file
-- ----------------------------
DROP TABLE IF EXISTS `common_file`;
CREATE TABLE `common_file` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  `origin_name` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  `binary` longblob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_common_file_deleted` (`deleted`),
  KEY `ix_common_file_file_name` (`file_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for common_internal_message
-- ----------------------------
DROP TABLE IF EXISTS `common_internal_message`;
CREATE TABLE `common_internal_message` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` text COLLATE utf8_unicode_ci COMMENT '内容',
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '跳转路径',
  `is_read` tinyint(1) DEFAULT NULL COMMENT '是否已读',
  `app_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT '应用名称',
  `category` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT '分类',
  `message_data` json DEFAULT NULL COMMENT '数据',
  `employee_id` int(11) DEFAULT NULL COMMENT 'ID',
  PRIMARY KEY (`id`),
  KEY `employee_id` (`employee_id`),
  KEY `ix_common_internal_message_deleted` (`deleted`),
  CONSTRAINT `common_internal_message_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `common_employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for common_notice_config
-- ----------------------------
DROP TABLE IF EXISTS `common_notice_config`;
CREATE TABLE `common_notice_config` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `platform` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `info` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_common_notice_config_deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nickname` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `department` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `catalog` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `secret` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `date_joined` datetime DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `block` tinyint(1) DEFAULT NULL,
  `has_logined` tinyint(1) DEFAULT NULL,
  `wx_id` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `employee_id` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `apps` json DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `mobile` (`mobile`),
  KEY `ix_users_employee_id` (`employee_id`),
  KEY `ix_users_deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
