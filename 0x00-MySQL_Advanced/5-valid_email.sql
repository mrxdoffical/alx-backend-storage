-- Create a trigger to reset valid_email when the email is changed
DELIMITER $$
CREATE TRIGGER before_email_update
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    IF NEW.email <> OLD.email THEN
        SET NEW.valid_email = 0;
    END IF;
END$$
DELIMITER ;
