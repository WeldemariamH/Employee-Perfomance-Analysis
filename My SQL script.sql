USE employee_satisfaction;
SELECT * FROM employee_satisfaction.`employee attrition`;

-- Renaming column names to make the much descriptive
ALTER TABLE `employee attrition`
RENAME COLUMN `satisfaction_level` TO  `Employee job satisfaction level 0-1`,
RENAME COLUMN `last_evaluation` TO `Employee's performance evaluation score 0-1`,
RENAME COLUMN `number_project` TO `projects employee is currently working on`,
RENAME COLUMN `average_montly_hours` TO `Avg no of hrs worked per month by the employee`,
RENAME COLUMN `time_spend_company` TO `Number of years the employee has spent with the company`,
RENAME COLUMN `Work_accident` TO `work accident (1 for yes, 0 for no)`,
RENAME COLUMN  `dept` TO `department`;

-- Dropping unneccessary column
ALTER TABLE `employee attrition`
DROP COLUMN `Emp ID`;

-- checking null values
SELECT * FROM `employee attrition`
WHERE `Employee job satisfaction level 0-1`IS NULL OR
       `Employee's performance evaluation score 0-1` IS NULL OR
       `projects employee is currently working on` IS NULL OR
       `Avg no of hrs worked per month by the employee` IS NULL OR
       `Number of years the employee has spent with the company` IS NULL OR
       `work accident (1 for yes, 0 for no)` IS NULL OR
       `promotion_last_5years` IS NULL OR
       `department` IS NULL OR
       `salary` IS NULL;

-- checking a statistical summary       
SELECT AVG(`Employee job satisfaction level 0-1`),
 AVG(`Employee's performance evaluation score 0-1`),
 AVG(`projects employee is currently working on`),
 AVG(`Number of years the employee has spent with the company`)
 FROM `employee attrition`;
 
 -- creating new column of overtime
 ALTER TABLE `employee attrition`
 ADD COLUMN `AVG Overtime worked per month` DECIMAL (5,0);
 
 UPDATE `employee attrition`
 SET `AVG Overtime worked per month`= `Avg no of hrs worked per month by the employee`- 160;
 
-- avergae satisfaction Vs number of projects table creation
CREATE TABLE `avergae satisfaction Vs number of projects`
SELECT
    department,
    AVG(`Employee job satisfaction level 0-1`) AS avg_satisfaction,
    AVG(`projects employee is currently working on`) AS avg_projects
FROM `employee attrition`
GROUP BY department;


-- New Work-Life Balance Index column
ALTER TABLE `employee attrition`
ADD COLUMN `work_life_balance_index` DECIMAL (5,5);

UPDATE `employee attrition`
SET `work_life_balance_index` = (`Employee job satisfaction level 0-1` / NULLIF(`Avg no of hrs worked per month by the employee`, 0));




