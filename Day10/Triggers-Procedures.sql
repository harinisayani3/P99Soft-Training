CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name TEXT,
    salary NUMERIC
);

-- Log table
CREATE TABLE employees_log (
    log_id SERIAL PRIMARY KEY,
    emp_id INT,
    name TEXT,
    salary NUMERIC,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger Function
CREATE OR REPLACE FUNCTION log_employee_insert()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO employees_log(emp_id, name, salary)
    VALUES (NEW.id, NEW.name, NEW.salary);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trg_log_insert
AFTER INSERT ON employees
FOR EACH ROW
EXECUTE FUNCTION log_employee_insert();

-- commands
insert into employees values(1,'Harini',10000);
insert into employees values(2,'Harika',12000);
select * from employees;
select * from employees_log;

-- To perform any restrictions on the data

CREATE OR REPLACE FUNCTION prevent_invalid_salary()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.salary <= 0 THEN
        RAISE EXCEPTION 'Salary must be greater than 0';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prevent_invalid_insert
BEFORE INSERT ON employees
FOR EACH ROW
EXECUTE FUNCTION prevent_invalid_salary();

--commands
insert into employees values(3,'Chandana',-1);

--To restrict the deleting

CREATE OR REPLACE FUNCTION restrict_delete_high_salary()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.salary > 50000 THEN
        RAISE EXCEPTION 'Cannot delete high salary employee';
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_restrict_delete
BEFORE DELETE ON employees
FOR EACH ROW
EXECUTE FUNCTION restrict_delete_high_salary();

--commands

Delete from employees where salary=20000;

--To store old values

CREATE TABLE employee_audit (
    audit_id SERIAL PRIMARY KEY,
    emp_id INT,
    old_salary NUMERIC,
    new_salary NUMERIC,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Function
CREATE OR REPLACE FUNCTION audit_employee_update()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO employee_audit(emp_id, old_salary, new_salary)
    VALUES (OLD.id, OLD.salary, NEW.salary);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trg_audit_update
AFTER UPDATE ON employees
FOR EACH ROW
WHEN (OLD.salary IS DISTINCT FROM NEW.salary)
EXECUTE FUNCTION audit_employee_update();

--commands

update employees set name ='chandana' where salary=-1;

--procedures

CREATE OR REPLACE PROCEDURE insert_employee(id NUMERIC, p_name TEXT, p_salary NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO employees(id, name, salary)
    VALUES (id, p_name, p_salary);
END;
$$;
CALL insert_employee(3,'Ravi', 30000);

--commands

select * from employees;

--delete procedure

CREATE OR REPLACE PROCEDURE delete_employee(p_id INT)
LANGUAGE plpgsql
AS $$
DECLARE
    emp_salary NUMERIC;
BEGIN
    SELECT salary INTO emp_salary
    FROM employees
    WHERE id = p_id;

    IF emp_salary IS NULL THEN
        RAISE EXCEPTION 'Employee not found';
    END IF;

    IF emp_salary > 50000 THEN
        RAISE EXCEPTION 'Cannot delete high salary employee';
    END IF;

    DELETE FROM employees WHERE id = p_id;
END;
$$;

CALL delete_employee(1);

-- Return Parameters

CREATE OR REPLACE FUNCTION get_employee_by_id(p_id INT)
RETURNS TABLE(id INT, name TEXT, salary NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT e.id, e.name, e.salary
    FROM employees e
    WHERE e.id = p_id;
END;
$$;

--commands

SELECT * FROM get_employee_by_id(1);
