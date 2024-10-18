-- Create users table with id, email, and name attributes
-- The id is an integer, never null, auto increment, and primary key
-- The email is a string (255 characters), never null, and unique
-- The name is a string (255 characters)
-- If the table already exists, the script should not fail

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255)
);
