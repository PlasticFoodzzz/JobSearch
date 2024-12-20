-- phpMyAdmin SQL Dump
-- version 3.3.9
-- http://www.phpmyadmin.net
-- Host: localhost
-- Generation Time: May 28, 2018 at 12:35 PM
-- Server version: 5.5.8
-- PHP Version: 5.3.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- Original database creation here
CREATE DATABASE IF NOT EXISTS `erisdb`;
USE `erisdb`;

-- Table structure for `tblapplicants`
CREATE TABLE IF NOT EXISTS `tblapplicants` (
  `APPLICANTID` int(11) NOT NULL AUTO_INCREMENT,
  `FNAME` varchar(90) NOT NULL,
  `LNAME` varchar(90) NOT NULL,
  `MNAME` varchar(90) NOT NULL,
  `ADDRESS` varchar(255) NOT NULL,
  `SEX` varchar(11) NOT NULL,
  `CIVILSTATUS` varchar(30) NOT NULL,
  `BIRTHDATE` date NOT NULL,
  `BIRTHPLACE` varchar(255) NOT NULL,
  `AGE` int(2) NOT NULL,
  `USERNAME` varchar(90) NOT NULL,
  `PASS` varchar(90) NOT NULL,
  `EMAILADDRESS` varchar(90) NOT NULL,
  `CONTACTNO` varchar(90) NOT NULL,
  `DEGREE` text NOT NULL,
  `APPLICANTPHOTO` varchar(255) NOT NULL,
  `NATIONALID` varchar(255) NOT NULL,
  PRIMARY KEY (`APPLICANTID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=2018016;

-- Add other tables like tblattachmentfile, tblautonumbers, tblcategory, etc. (from your original SQL)

-- Table structure for `tbljob`
CREATE TABLE IF NOT EXISTS `tbljob` (
  `JOBID` int(11) NOT NULL AUTO_INCREMENT,
  `COMPANYID` int(11) NOT NULL,
  `CATEGORY` varchar(250) NOT NULL,
  `OCCUPATIONTITLE` varchar(90) NOT NULL,
  `REQ_NO_EMPLOYEES` int(11) NOT NULL,
  `SALARIES` double NOT NULL,
  `DURATION_EMPLOYEMENT` varchar(90) NOT NULL,
  `QUALIFICATION_WORKEXPERIENCE` text NOT NULL,
  `JOBDESCRIPTION` text NOT NULL,
  `PREFEREDSEX` varchar(30) NOT NULL,
  `SECTOR_VACANCY` text NOT NULL,
  `JOBSTATUS` varchar(90) NOT NULL,
  `DATEPOSTED` datetime NOT NULL,
  PRIMARY KEY (`JOBID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=3;

-- Original data dumping (INSERT statements) for all tables...

-- Audit table for `tbljob`
CREATE TABLE IF NOT EXISTS `tbljob_audit` (
    `audit_id` INT AUTO_INCREMENT PRIMARY KEY,
    `job_id` INT NOT NULL,
    `changed_by` VARCHAR(90) NOT NULL,
    `change_date` DATETIME NOT NULL,
    `old_salary` DOUBLE,
    `new_salary` DOUBLE,
    `description` TEXT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DELIMITER $$
CREATE TRIGGER `before_job_update`
BEFORE UPDATE ON `tbljob`
FOR EACH ROW
BEGIN
    INSERT INTO `tbljob_audit` (`job_id`, `changed_by`, `change_date`, `old_salary`, `new_salary`, `description`)
    VALUES (OLD.JOBID, 'admin', NOW(), OLD.SALARIES, NEW.SALARIES, CONCAT('Job salary updated from ', OLD.SALARIES, ' to ', NEW.SALARIES));
END$$
DELIMITER ;

-- Similar triggers and audit tables for `tblapplicants`, `tblemployees`, `tbljobregistration`...

-- Example:
CREATE TABLE IF NOT EXISTS `tblapplicant_audit` (
    `audit_id` INT AUTO_INCREMENT PRIMARY KEY,
    `applicant_id` INT NOT NULL,
    `changed_by` VARCHAR(90) NOT NULL,
    `change_date` DATETIME NOT NULL,
    `old_data` TEXT,
    `new_data` TEXT,
    `description` TEXT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DELIMITER $$
CREATE TRIGGER `before_applicant_update`
BEFORE UPDATE ON `tblapplicants`
FOR EACH ROW
BEGIN
    INSERT INTO `tblapplicant_audit` (`applicant_id`, `changed_by`, `change_date`, `old_data`, `new_data`, `description`)
    VALUES (
        OLD.APPLICANTID,
        'admin',
        NOW(),
        CONCAT('Old: ', OLD.FNAME, ' ', OLD.LNAME, ' ', OLD.ADDRESS),
        CONCAT('New: ', NEW.FNAME, ' ', NEW.LNAME, ' ', NEW.ADDRESS),
        'Applicant details updated.'
    );
END$$
DELIMITER ;
