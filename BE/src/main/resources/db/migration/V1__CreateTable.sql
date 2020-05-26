DROP TABLE IF EXISTS host;
DROP TABLE IF EXISTS room;
DROP TABLE IF EXISTS image;

CREATE TABLE host
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