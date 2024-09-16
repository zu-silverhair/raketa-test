
---регистрация пользователей
CREATE TABLE users (
    id bigint PRIMARY key generated always as IDENTITY,
    nikname varchar(20) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);


---данные пользователей
CREATE TABLE users_contact (
    users_id bigint references users(id),
    email varchar(50) NOT NULL,
    phone varchar(12) NOT NULL,
    update_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);


---регистрация сообщений
CREATE TABLE users_delivered (
    message_id bigint PRIMARY key generated always as IDENTITY,
    to_users_id bigint references users(id),
    from_users_id bigint references users(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    status_id BOOLEAN DEFAULT FALSE ---0-undelivered,1-delivered
);

---данные о сообщениях
CREATE TABLE message (
    message_id bigint references users_delivered(message_id),
    message_content varchar(255) NULL
);


---посчитать текущее кол-во непрочитанных сообщений пользователей, полученных за последние сутки.

select 
count(message_id) as count_undelivered
from users_delivered
where status_id = false
and created_at between now() - interval '24 HOURS' and NOW()



