-- :name insert-user<! :<! :1
-- :doc add a user
insert into users (screenname, group_name, admin, last_login, is_active, pass)
     values (:screenname, :group-name, :admin, (select now() at time zone 'utc'), :is-active, :pass)
returning user_id;

-- :name user-by-screenname :? :1
-- :doc get a user based on the screenname
select user_id, screenname, group_name, admin, last_login, is_active, pass
from users
where screenname = :screenname
and is_active = true;

-- :name users-by-screenname :? :*
-- :doc get a users with matching screennames
select user_id, screenname, group_name, admin, last_login, is_active
from users
where screenname like :screenname;

-- :name users-by-group :? :*
-- :doc get all the users in a group
select user_id, screenname, group_name, admin, last_login, is_active
from users
where group_name = :group-name
and is_active = true;

-- :name update-user-with-pass<! :<! :1
-- :doc Updates all user fields
update users
set screenname = :screenname,
    pass = :pass,
    group_name = :group-name,
    admin = :admin,
    is_active = :is-active,
    last_login=(select now() at time zone 'utc')
where user_id=:user-id
returning user_id, group_name, screenname, last_login, is_active, admin;

-- :name update-user<! :<! :1
-- :doc Updates users fields except for pass
update users
set screenname = :screenname,
    group_name = :group-name,
    admin = :admin,
    is_active = :is-active,
    last_login=(select now() at time zone 'utc')
where user_id=:user-id
returning user_id, group_name, screenname, last_login, is_active, admin;
