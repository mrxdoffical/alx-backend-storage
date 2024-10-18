-- Create a trigger to update item quantity after a new order is inserted
DELIMITER $$
CREATE TRIGGER after_order_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE items
    SET quantity = quantity - NEW.number
    WHERE name = NEW.item_name;
END$$
DELIMITER ;
