-- Hotel Room Table
CREATE TABLE rooms (
    id INT PRIMARY KEY AUTO_INCREMENT,
    room_type VARCHAR(50),
    price_per_night DECIMAL(10,2),
    description TEXT,
    availability INT
);

-- Bookings Table
CREATE TABLE bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    room_id INT,
    user_name VARCHAR(100),
    nights INT,
    total_amount DECIMAL(10,2),
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (room_id) REFERENCES rooms(id)
);

-- Admin Table
CREATE TABLE admin (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(100)
);