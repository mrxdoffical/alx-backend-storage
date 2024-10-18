-- Create the ComputeAverageWeightedScoreForUser stored procedure
DELIMITER $$

CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE total_weight INT DEFAULT 0;
    DECLARE weighted_sum FLOAT DEFAULT 0;
    
    -- Calculate the weighted sum and total weight for the user's scores
    SELECT SUM(score * weight), SUM(weight)
    INTO weighted_sum, total_weight
    FROM corrections c
    JOIN projects p ON c.project_id = p.id
    WHERE c.user_id = user_id;
    
    -- Update the user's average score
    IF total_weight > 0 THEN
        UPDATE users
        SET average_score = weighted_sum / total_weight
        WHERE id = user_id;
    ELSE
        UPDATE users
        SET average_score = 0
        WHERE id = user_id;
    END IF;
END$$

DELIMITER ;
