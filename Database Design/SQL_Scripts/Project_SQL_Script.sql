set FOREIGN_KEY_CHECKS = 0;

DROP TABLE RESOURCE;
DROP TABLE CRATE;
DROP TABLE WORKBENCH;
DROP TABLE WEAPON;
DROP TABLE WEAPON_STATS;
DROP TABLE DROP_RESOURCE;
DROP TABLE DROP_WEAPON;
DROP TABLE CRAFT_BENCH;
DROP TABLE CRAFT_WEAPON;

set FOREIGN_KEY_CHECKS = 1;

-- create entity tables
CREATE TABLE RESOURCE(
    uuid INT(20) PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    imageURL VARCHAR(200),
    craftable INT(1) DEFAULT 0
    );

CREATE TABLE CRATE(
    uuid INT(20) PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    imageURL VARCHAR(200)
    );

CREATE TABLE WORKBENCH(
    uuid INT(20) PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    imageURL VARCHAR(200)
    );

CREATE TABLE WEAPON(
    uuid INT(20) PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    imageURL VARCHAR(200),
    craftable INT(1) DEFAULT 0
    );

CREATE TABLE WEAPON_STATS(
    uuid INT(20) PRIMARY KEY,
    FOREIGN KEY (uuid) REFERENCES WEAPON(uuid),
    damage INT(8),
    fire_rate INT(8),
    ttk INT(8),
    reload_time FLOAT(8),
    dropoff_distance FLOAT(8)
    );

-- create relationship tables

CREATE TABLE DROP_RESOURCE(
    source_uuid INT(20),
    drop_uuid INT(20),
    PRIMARY KEY (source_uuid, drop_uuid),
    FOREIGN KEY (source_uuid) REFERENCES CRATE(uuid),
    FOREIGN KEY (drop_uuid) REFERENCES RESOURCE(uuid),
    loot_amount INT(8),
    loot_chance FLOAT(8)
    );
CREATE TABLE DROP_WEAPON(
    source_uuid INT(20),
    drop_uuid INT(20),
    PRIMARY KEY (source_uuid, drop_uuid),
    FOREIGN KEY (source_uuid) REFERENCES CRATE(uuid),
    FOREIGN KEY (drop_uuid) REFERENCES WEAPON(uuid),
    loot_amount INT(8),
    loot_chance FLOAT(8)
    );
CREATE TABLE CRAFT_BENCH(
    crafted_id INT(20),
    required_bench_id INT(20),
    required_resource_id INT(20),
    PRIMARY KEY (crafted_id, required_bench_id),
    FOREIGN KEY (crafted_id) REFERENCES WORKBENCH(uuid),
    FOREIGN KEY (required_bench_id) REFERENCES WORKBENCH(uuid),
    FOREIGN KEY (required_resource_id) REFERENCES RESOURCE(uuid)
    );
CREATE TABLE CRAFT_WEAPON(
    crafted_id INT(20),
    required_bench_id INT(20),
    required_resource_id INT(20),
    PRIMARY KEY (crafted_id, required_bench_id),
    FOREIGN KEY (crafted_id) REFERENCES WEAPON(uuid),
    FOREIGN KEY (required_bench_id) REFERENCES WORKBENCH(uuid),
    FOREIGN KEY (required_resource_id) REFERENCES RESOURCE(uuid)
    );



--DESCRIBE RESOURCE;
-- SHOW TABLE DATA
--SELECT * FROM RESOURCE;
set FOREIGN_KEY_CHECKS = 1;