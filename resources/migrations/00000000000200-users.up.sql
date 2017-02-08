CREATE TABLE users
(user_id     SERIAL      NOT NULL PRIMARY KEY,
 screenname  VARCHAR(30) UNIQUE NOT NULL,
 pass        TEXT,
 email       VARCHAR(60),
 group_name  text      NOT NULL references groups (group_name),
 admin       BOOLEAN,
 last_login  TIMESTAMP,
 is_active   BOOLEAN,
 create_date TIMESTAMP   NOT NULL DEFAULT (now() AT TIME ZONE 'utc'),
 update_date TIMESTAMP   NOT NULL DEFAULT (now() AT TIME ZONE 'utc'));
--;;
-- create a system account for which the stock entries will be created
INSERT INTO users (screenname, email, group_name, admin, is_active, last_login, pass)
VALUES ('admin', 'admin@admin.com', 'Default', TRUE, TRUE, (select now() at time zone 'utc'), 'bcrypt+sha512$86186fc28f83b3e3db78bcf8350a3a57$12$8f215420e68fd7922561167b07354f05d8db6d49e212689e');
