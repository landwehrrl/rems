use rems;
DROP TABLE IF EXISTS `property`;
DROP TABLE IF EXISTS `unit`;
DROP TABLE IF EXISTS `lease_inclusion`;
DROP TABLE IF EXISTS `tenant`;
DROP TABLE IF EXISTS `rent_history`;
DROP TABLE IF EXISTS `security_deposit`;
DROP TABLE IF EXISTS `tax`;
DROP TABLE IF EXISTS `tax_schedule`;
DROP TABLE IF EXISTS `lease_info`;
DROP TABLE IF EXISTS `lease_doc`;
DROP TABLE IF EXISTS `insurance`;
DROP TABLE IF EXISTS `insurance_schedule`;
DROP TABLE IF EXISTS `loan`;
DROP TABLE IF EXISTS `loan_schedule`;
DROP TABLE IF EXISTS `maintenance`;
DROP TABLE IF EXISTS `maintenance_doc`;
DROP TABLE IF EXISTS `bill`;
DROP TABLE IF EXISTS `bill_doc`;
DROP TABLE IF EXISTS `legal_action`;
DROP TABLE IF EXISTS `standard_form`;

CREATE TABLE `property` (
  `property_id` INT NULL AUTO_INCREMENT,
  `number` VARCHAR(10) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `number_of_units` INT NOT NULL,
  PRIMARY KEY (`property_id`));

CREATE TABLE `unit` (
  `unit_id` INT NULL AUTO_INCREMENT,
  `property_id` INT NOT NULL,
  `unit_descriptor` VARCHAR(45) NULL,
  `rent_amount` DOUBLE NOT NULL,
  PRIMARY KEY (`unit_id`));

CREATE TABLE `lease_inclusion` (
  `inclusion_id` INT NULL AUTO_INCREMENT,
  `unit_id` INT NOT NULL,
  `inclusion_descriptor` VARCHAR(45) NULL,
  PRIMARY KEY (`inclusion_id`));

CREATE TABLE `tenant` (
  `tenant_id` INT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tenant_id`));

CREATE TABLE `rent_history` (
  `record_id` INT NULL AUTO_INCREMENT,
  `tenant_id` INT NOT NULL,
  `unit_id` INT NOT NULL,
  `rent_amount` INT NOT NULL,
  `pet_rent_amount` INT NOT NULL,
  `late_fee_amount` INT NOT NULL,
  `payment_date` DATE NULL,
  `payment_due_date` DATE NOT NULL,
  `payer` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`record_id`));

CREATE TABLE `security_deposit` (
  `deposit_id` INT NULL AUTO_INCREMENT,
  `tenant_id` INT NOT NULL,
  `unit_id` INT NOT NULL,
  `security_deposit_amount` INT NOT NULL,
  `pet_deposit_amount` INT NOT NULL,
  `security_payer` VARCHAR(45) NOT NULL,
  `pet_payer` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`deposit_id`));

CREATE TABLE `tax` (
  `tax_id` INT NULL AUTO_INCREMENT,
  `property_id` INT NOT NULL,
  `payment_due_date` DATE NOT NULL,
  `number_of_payments_per_year` INT NOT NULL,
  `total_cost` DOUBLE NOT NULL,
  PRIMARY KEY (`tax_id`));

CREATE TABLE `tax_schedule` (
  `tax_schedule_id` INT NULL AUTO_INCREMENT,
  `tax_id` INT NOT NULL,
  `amount` DOUBLE NOT NULL,
  `due_date` DATE NOT NULL,
  `paid_date` DATE NULL,
  PRIMARY KEY (`tax_schedule_id`));

CREATE TABLE `lease_info` (
  `lease_id` INT NULL AUTO_INCREMENT,
  `tenant_id` INT NOT NULL,
  `unit_id` INT NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `actual_move_out_date` DATE NULL,
  PRIMARY KEY (`lease_id`));

CREATE TABLE `lease_doc` (
  `lease_doc_id` INT NULL AUTO_INCREMENT,
  `lease_id` INT NOT NULL,
  `location` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`lease_doc_id`));

CREATE TABLE `insurance` (
  `insurance_id` INT NULL AUTO_INCREMENT,
  `property_id` INT NOT NULL,
  `provider` VARCHAR(45) NOT NULL,
  `total_cost` DOUBLE NOT NULL,
  `pay_schedule` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`insurance_id`));

CREATE TABLE `insurance_schedule` (
  `insurance_schedule_id` INT NULL AUTO_INCREMENT,
  `insurance_id` INT NOT NULL,
  `amount` DOUBLE NOT NULL,
  `due_date` DATE NOT NULL,
  `paid_date` DATE NULL,
  PRIMARY KEY (`insurance_schedule_id`));

CREATE TABLE `loan` (
  `loan_id` INT NULL AUTO_INCREMENT,
  `property_id` INT NOT NULL,
  `provider` VARCHAR(45) NOT NULL,
  `bank_loan_number` INT NOT NULL,
  `monthly_PI_amount` DOUBLE NOT NULL,
  `ammort_length_months` INT NOT NULL,
  `start_date` DATE NOT NULL,
  `renewal_date` DATE NOT NULL,
  `active` BOOLEAN NOT NULL,
  PRIMARY KEY (`loan_id`));

CREATE TABLE `loan_schedule` (
  `loan_schedule_id` INT NULL AUTO_INCREMENT,
  `loan_id` INT NOT NULL,
  `amount` DOUBLE NOT NULL,
  `due_date` DATE NOT NULL,
  `paid_date` DATE NULL,
  `balance` DOUBLE NOT NULL,
  PRIMARY KEY (`loan_schedule_id`));

CREATE TABLE `maintenance` (
  `maintenance_id` INT NULL AUTO_INCREMENT,
  `property_id` INT NOT NULL,
  `unit_id` INT NULL,
  `contractor` VARCHAR(45) NOT NULL,
  `labor_cost` DOUBLE NOT NULL,
  `material_cost` DOUBLE NOT NULL,
  `labor_paid_date` DATE NULL,
  `material_paid_date` DATE NULL,
  PRIMARY KEY (`maintenance_id`));

CREATE TABLE `maintenance_doc` (
  `maintenance_doc_id` INT NULL AUTO_INCREMENT,
  `maintenance_id` INT NOT NULL,
  `location` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`maintenance_doc_id`));

CREATE TABLE `bill` (
  `bill_id` INT NULL AUTO_INCREMENT,
  `property_id` INT NOT NULL,
  `unit_id` INT NULL,
  `bill_type` VARCHAR(45) NOT NULL,
  `amount` DOUBLE NOT NULL,
  `due_date` DATE NOT NULL,
  `paid_date` DATE NULL,
  `company` VARCHAR(45) NULL,
  PRIMARY KEY (`bill_id`));

CREATE TABLE `bill_doc` (
  `bill_doc_id` INT NULL AUTO_INCREMENT,
  `bill_id` INT NOT NULL,
  `location` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`bill_doc_id`));

CREATE TABLE `legal_action` (
  `legal_id` INT NULL AUTO_INCREMENT,
  `property_id` INT NOT NULL,
  `unit_id` INT NOT NULL,
  `tenant_id` INT NOT NULL,
  `cost` DOUBLE NOT NULL,
  `due_date` DATE NOT NULL,
  `paid_date` DATE NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`legal_id`));

CREATE TABLE `standard_form` (
  `form_id` INT NULL AUTO_INCREMENT,
  `description` VARCHAR(45),
  `location` VARCHAR(255),
  PRIMARY KEY(`form_id`));

show tables;
/*  

DROP PROCEDURE if EXISTS `sp_createUser`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createUser`(
    IN p_name VARCHAR(20),
    IN p_username VARCHAR(20),
    IN p_password VARCHAR(20)
)
BEGIN
    if ( select exists (select 1 from tbl_user where user_username = p_username) ) THEN
     
        select 'Username Exists !!';
     
    ELSE
     
        insert into tbl_user
        (
            user_name,
            user_username,
            user_password
        )
        values
        (
            p_name,
            p_username,
            p_password
        );
     
    END IF;
END$$
DELIMITER ;
*/
