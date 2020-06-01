DROP TABLE IF EXISTS image;
DROP TABLE IF EXISTS booking;
DROP TABLE IF EXISTS favorite;
DROP TABLE IF EXISTS room;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS host;

CREATE TABLE IF NOT EXISTS host
(
    id        INT PRIMARY KEY AUTO_INCREMENT,
    name      VARCHAR(45) NOT NULL,
    email     VARCHAR(45) NOT NULL,
    superhost BOOLEAN     NOT NULL
);

CREATE TABLE IF NOT EXISTS room
(
    id            INT PRIMARY KEY AUTO_INCREMENT,
    name          VARCHAR(150) NOT NULL,
    type          VARCHAR(45)  NOT NULL,
    price         INT          NOT NULL,
    maximum_guest INT          NOT NULL,
    bedroom       INT          NOT NULL,
    bed           INT          NOT NULL,
    bath          INT          NOT NULL,
    review_rating DOUBLE       NOT NULL,
    review_count  INT          NOT NULL,
    location      VARCHAR(45)  NOT NULL,
    latitude      DOUBLE       NOT NULL,
    longitude     DOUBLE       NOT NULL,
    address       VARCHAR(45)  NOT NULL,
    host_id       INT          NOT NULL,
    CONSTRAINT room_has_host FOREIGN KEY (host_id) REFERENCES host (id)
);

CREATE TABLE IF NOT EXISTS image
(
    id        INT PRIMARY KEY AUTO_INCREMENT,
    image_url VARCHAR(500),
    room_id   INT,
    CONSTRAINT image_has_room_id FOREIGN KEY (room_id) REFERENCES room (id)
);

CREATE TABLE IF NOT EXISTS booking
(
    id        INT PRIMARY KEY AUTO_INCREMENT,
    room_id   INT  NOT NULL,
    book_date DATE NOT NULL,
    guest     INT  NOT NULL DEFAULT 1,
    CONSTRAINT booking_has_room_id FOREIGN KEY (room_id) REFERENCES room (id)
);

CREATE TABLE IF NOT EXISTS favorite
(
    id      INT PRIMARY KEY AUTO_INCREMENT,
    room_id INT NOT NULL,
    user_id INT NOT NULL,
    favor   TINYINT DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS user
(
    id        INT PRIMARY KEY AUTO_INCREMENT,
    github_id VARCHAR(45) NOT NULL
);