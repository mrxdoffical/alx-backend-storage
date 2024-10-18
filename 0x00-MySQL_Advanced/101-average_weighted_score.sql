-- Create the ComputeAverageWeightedScoreForUsers stored procedure
DELIMITER $$

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE uid INT;
    
    -- Declare cursor for iterating through users
    DECLARE user_cursor CURSOR FOR SELECT id FROM users;
    
    -- Declare a continue handler for the cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN user_cursor;
    
    read_loop: LOOP
        FETCH user_cursor INTO uid;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Compute the average weighted score for the user
        CALL ComputeAverageWeightedScoreForUser(uid);
    END LOOP;
    
    CLOSE user_cursor;
END$$

DELIMITER ;
