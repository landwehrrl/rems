/* drop tables */
drop table if exists bill;
drop table if exists bill_doc;
drop table if exists insurance;
drop table if exists insurance_schedule;
drop table if exists lease_doc;
drop table if exists lease_inclusion;
drop table if exists lease_info;
drop table if exists legal_action;
drop table if exists loan;
drop table if exists loan_schedule;
drop table if exists maintenance;
drop table if exists maintenance_doc;
drop table if exists property;
drop table if exists rent_history;
drop table if exists security_deposit;
drop table if exists standard_form;
drop table if exists tax;
drop table if exists tax_schedule;
drop table if exists tenant;
drop table if exists unit;
drop table if exists user_credential;

/* add tables */

create table bill(bill_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, 
                  property_id INT(11) NOT NULL, 
                  unit_id INT(11), 
                  bill_type VARCHAR(45) NOT NULL, 
                  amount DOUBLE NOT NULL, 
                  due_date DATE NOT NULL, 
                  paid_date DATE, 
                  company VARCHAR(45));
                  
create table bill_doc(bill_doc_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
                      bill_id INT(11) NOT NULL, 
                      location VARCHAR(255));
                      
create table insurance(insurance_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
                       property_id INT(11) NOT NULL,
                       provider VARCHAR(45) NOT NULL, 
                       total_cost DOUBLE NOT NULL, 
                       pay_schedule VARCHAR(45) NOT NULL);
                       
create table insurance_schedule(insurance_schedule_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, 
                                insurance_id INT(11) NOT NULL, 
                                amount DOUBLE NOT NULL, 
                                due_date DATE NOT NULL, 
                                paid_date DATE);
                                
create table lease_doc(lease_doc_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
                       lease_id INT(11) NOT NULL,
                       location VARCHAR(255) NOT NULL);
                       
create table lease_inclusion(inclusion_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
                             unit_id INT(11) NOT NULL,
                             inclusion_descriptor VARCHAR(45));
                             
create table lease_info(lease_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
                        tenant_id INT(11) NOT NULL,
                        unit_id INT(11) NOT NULL,
                        start_date DATE NOT NULL,
                        end_date DATE NOT NULL,
                        actual_move_out_date DATE);
                        
create table legal_action(legal_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
                          property_id INT(11) NOT NULL,
                          unit_id INT(11) NOT NULL,
                          tenant_id INT(11) NOT NULL,
                          cost DOUBLE NOT NULL,
                          due_date DATE NOT NULL, 
                          paid_date DATE,
                          description VARCHAR(255));
create table loan(loan_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, 
                  property_id INT(11) NOT NULL, 
                  bank_loan_number INT(11) NOT NULL, 
                  provider VARCHAR(45) NOT NULL, 
                  monthly_PI_amount DOUBLE NOT NULL, 
                  ammort_length_months INT(11) NOT NULL,
                  start_date DATE NOT NULL, 
                  renewal_date DATE NOT NULL,
                  active tinyint(1) NOT NULL);

create table loan_schedule(loan_schedule_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
                           property_id INT(11), 
                           loan_id INT(11) NOT NULL, 
                           amount DOUBLE NOT NULL, 
                           due_date DATE NOT NULL, 
                           paid_date DATE, 
                           balance DOUBLE NOT NULL);
                           
create table maintenance(maintenance_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
                         property_id INT(11) NOT NULL,
                         unit_id INT(11), 
                         contractor VARCHAR(45) NOT NULL,
                         labor_cost DOUBLE NOT NULL,
                         material_cost DOUBLE  NOT NULL,
                         labor_paid_date DATE, 
                         material_paid_date DATE);
                         
create table maintenance_doc(maintenance_doc_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
                             maintenance_id INT(11) NOT NULL,
                             location VARCHAR(255) NOT NULL);
                             
create table property(property_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
                      number VARCHAR(10) NOT NULL,
                      street VARCHAR(45) NOT NULL, 
                      city VARCHAR(45) NOT NULL, 
                      state VARCHAR(2) NOT NULL,
                      number_of_units INT(11) NOT NULL);

create table rent_history(record_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, 
                          tenant_id INT(11) NOT NULL, 
                          unit_id INT(11) NOT NULL, 
                          rent_amount INT(11) NOT NULL, 
                          pet_rent_amount INT(11) NOT NULL, 
                          late_fee_amount INT(11) NOT NULL,
                          payment_due_date DATE NOT NULL, 
                          payment_date DATE, 
                          payer VARCHAR(45));
                          
create table security_deposit(deposit_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
                              tenant_id INT(11) NOT NULL,
                              unit_id INT(11) NOT NULL,
                              security_deposit_amount DOUBLE NOT NULL,
                              pet_deposit_amount DOUBLE NOT NULL,
                              security_payer VARCHAR(45) NOT NULL,
                              pet_payer VARCHAR(45) NOT NULL);
                              
create table standard_form(form_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
                           description VARCHAR(45) NOT NULL,
                           location VARCHAR(45) NOT NULL);
                           
create table tax(tax_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
                 property_id INT(11) NOT NULL,
                 payment_due_date DATE NOT NULL,
                 number_of_payments_per_year INT(11) NOT NULL,
                 total_cost DOUBLE NOT NULL);
                 
create table tax_schedule(tax_schedule_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, 
                          tax_id INT(11) NOT NULL,
                          amount DOUBLE NOT NULL, 
                          due_date DATE NOT NULL,
                          paid_date DATE);
                          
create table tenant(tenant_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, 
                    first_name VARCHAR(45) NOT NULL,
                    last_name VARCHAR(45) NOT NULL,
                    remarks VARCHAR(255) NOT NULL);
                    
create table unit(unit_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, 
                  property_id INT(11) NOT NULL,
                  unit_descriptor VARCHAR(45) NOT NULL,
                  rent_amount DOUBLE NOT NULL);
                  
create table user_credential(user_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
                             user_username VARCHAR(45),
                             user_password VARCHAR(45));
