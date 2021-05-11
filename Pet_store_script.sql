-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Pet_Store
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pet_Store
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pet_Store` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `Pet_Store` ;

-- -----------------------------------------------------
-- Table `Pet_Store`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pet_Store`.`Customer` (
  `C_FName` VARCHAR(45) NOT NULL,
  `C_LName` VARCHAR(45) NOT NULL,
  `C_ID` INT NOT NULL,
  `C_PhoneNum` INT NULL DEFAULT NULL,
  `C_Address` VARCHAR(45) NULL DEFAULT NULL,
  `Pets_Pet_ID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`C_ID`, `Pets_Pet_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Pet_Store`.`Pets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pet_Store`.`Pets` (
  `Pet_FName` VARCHAR(45) NOT NULL,
  `Pet_LName` VARCHAR(45) NOT NULL,
  `Pet_Type` VARCHAR(45) NOT NULL,
  `Pet_Nutrition` VARCHAR(45) NULL DEFAULT NULL,
  `Pet_Behavior` VARCHAR(45) NULL DEFAULT NULL,
  `Pet_ID` VARCHAR(45) NOT NULL,
  `Customer_C_ID` INT NOT NULL,
  `Customer_Pets_Pet_ID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Pet_ID`, `Customer_C_ID`, `Customer_Pets_Pet_ID`),
  INDEX `fk_Pets_Customer_idx` (`Customer_C_ID` ASC, `Customer_Pets_Pet_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Pets_Customer`
    FOREIGN KEY (`Customer_C_ID` , `Customer_Pets_Pet_ID`)
    REFERENCES `Pet_Store`.`Customer` (`C_ID` , `Pets_Pet_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Pet_Store`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pet_Store`.`Employee` (
  `Employ_ID` INT NOT NULL,
  `Employ_FName` VARCHAR(45) NOT NULL,
  `Employ_LNmae` VARCHAR(45) NOT NULL,
  `Employ_JobTitle` VARCHAR(45) NOT NULL,
  `Employ_Salary` DECIMAL(25,0) NULL DEFAULT NULL,
  `Employ_DOB` DECIMAL(8,0) NULL DEFAULT NULL,
  `Pets_Pet_ID` VARCHAR(45) NOT NULL,
  `Pets_Customer_C_ID` INT NOT NULL,
  `Pets_Customer_Pets_Pet_ID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Employ_ID`, `Pets_Pet_ID`, `Pets_Customer_C_ID`, `Pets_Customer_Pets_Pet_ID`),
  INDEX `fk_Employee_Pets1_idx` (`Pets_Pet_ID` ASC, `Pets_Customer_C_ID` ASC, `Pets_Customer_Pets_Pet_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_Pets1`
    FOREIGN KEY (`Pets_Pet_ID` , `Pets_Customer_C_ID` , `Pets_Customer_Pets_Pet_ID`)
    REFERENCES `Pet_Store`.`Pets` (`Pet_ID` , `Customer_C_ID` , `Customer_Pets_Pet_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Pet_Store`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pet_Store`.`Products` (
  `Product_ID` INT NOT NULL,
  `Product_Name` VARCHAR(45) NULL DEFAULT NULL,
  `Product_Type` VARCHAR(45) NOT NULL,
  `Store_price` DECIMAL(10,0) NOT NULL,
  `Customer_C_ID` INT NOT NULL,
  `Customer_Pets_Pet_ID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Product_ID`, `Customer_C_ID`, `Customer_Pets_Pet_ID`),
  INDEX `fk_Products_Customer1_idx` (`Customer_C_ID` ASC, `Customer_Pets_Pet_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Products_Customer1`
    FOREIGN KEY (`Customer_C_ID` , `Customer_Pets_Pet_ID`)
    REFERENCES `Pet_Store`.`Customer` (`C_ID` , `Pets_Pet_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Pet_Store`.`Supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pet_Store`.`Supplier` (
  `Sup_Name` VARCHAR(45) NOT NULL,
  `Sup_PhoneNum` INT NULL DEFAULT NULL,
  `Sup_Type` VARCHAR(45) NULL DEFAULT NULL,
  `Sup_cost` DECIMAL(15,0) NULL DEFAULT NULL,
  PRIMARY KEY (`Sup_Name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Pet_Store`.`Supplier_has_Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pet_Store`.`Supplier_has_Products` (
  `Supplier_Sup_Name` VARCHAR(45) NOT NULL,
  `Products_Product_ID` INT NOT NULL,
  PRIMARY KEY (`Supplier_Sup_Name`, `Products_Product_ID`),
  INDEX `fk_Supplier_has_Products_Products1_idx` (`Products_Product_ID` ASC) VISIBLE,
  INDEX `fk_Supplier_has_Products_Supplier1_idx` (`Supplier_Sup_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Supplier_has_Products_Supplier1`
    FOREIGN KEY (`Supplier_Sup_Name`)
    REFERENCES `Pet_Store`.`Supplier` (`Sup_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Supplier_has_Products_Products1`
    FOREIGN KEY (`Products_Product_ID`)
    REFERENCES `Pet_Store`.`Products` (`Product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Pet_Store`.`Employees _use_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pet_Store`.`Employees _use_products` (
  `Products_Product_ID` INT NOT NULL,
  `Employee_Employ_ID` INT NOT NULL,
  PRIMARY KEY (`Products_Product_ID`, `Employee_Employ_ID`),
  INDEX `fk_Products_has_Employee_Employee1_idx` (`Employee_Employ_ID` ASC) VISIBLE,
  INDEX `fk_Products_has_Employee_Products1_idx` (`Products_Product_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Products_has_Employee_Products1`
    FOREIGN KEY (`Products_Product_ID`)
    REFERENCES `Pet_Store`.`Products` (`Product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_has_Employee_Employee1`
    FOREIGN KEY (`Employee_Employ_ID`)
    REFERENCES `Pet_Store`.`Employee` (`Employ_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
