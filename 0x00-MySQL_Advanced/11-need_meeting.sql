-- Create the need_meeting view to list all students with a score under 80 and no last_meeting or more than a month

CREATE VIEW need_meeting AS
SELECT name
FROM students
WHERE score < 80
AND (last_meeting IS NULL OR last_meeting < CURDATE() - INTERVAL 1 MONTH);
