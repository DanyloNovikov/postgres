CREATE DATABASE study_db;

CREATE TABLE users
(
    id           SERIAL PRIMARY KEY,
    username     VARCHAR(40) NOT NULL,
    bio          VARCHAR(400),
    avatar       VARCHAR(200),
    phone_number VARCHAR(20),
    email        VARCHAR(20),
    password     VARCHAR(40),
    status       VARCHAR(20),
    lat          REAL CHECK (lat IS NULL OR (lat >= -90 AND lat <= 90)),
    lng          REAL CHECK ( lng IS NULL OR (lng >= -180 AND lng <= 180)),
    created_at   TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CHECK (COALESCE(phone_number, email) IS NOT NULL )
);

CREATE TABLE posts
(
    id         SERIAL PRIMARY KEY,
    url        VARCHAR(200) NOT NULL,
    user_id    INTEGER      NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    lat        REAL CHECK ( lat IS NULL OR (lat >= -90 AND lat <= 90)),
    lng        REAL CHECK ( lng IS NULL OR (lng >= -180 AND lng <= 180)),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE comments
(
    id         SERIAL PRIMARY KEY,
    content    VARCHAR(400) NOT NULL,
    user_id    INTEGER      NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    post_id    INTEGER      NOT NULL REFERENCES posts (id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE likes
(
    id         SERIAL PRIMARY KEY,
    user_id    INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    post_id    INTEGER REFERENCES posts (id) ON DELETE CASCADE,
    comment_id INTEGER REFERENCES comments (id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
--     check that comment or post reference present
    CHECK (
                COALESCE((post_id)::BOOLEAN::INTEGER, 0) +
                COALESCE((comment_id)::BOOLEAN::INTEGER, 0) = 1
        ),
    UNIQUE (user_id, post_id, comment_id)
);

CREATE TABLE photo_tags
(
    id         SERIAL PRIMARY KEY,
    x          INTEGER NOT NULL,
    y          INTEGER NOT NULL,
    post_id    INTEGER NOT NULL REFERENCES posts (id) ON DELETE CASCADE,
    user_id    INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, post_id)
);

CREATE TABLE capture_tags
(
    id         SERIAL PRIMARY KEY,
    post_id    INTEGER NOT NULL REFERENCES posts (id),
    user_id    INTEGER NOT NULL REFERENCES users (id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, post_id)
);

CREATE TABLE hashtags
(
    id         SERIAL PRIMARY KEY,
    title      VARCHAR(40) NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE hashtags_posts
(
    id         SERIAL PRIMARY KEY,
    hashtag_id INTEGER NOT NULL REFERENCES hashtags (id) ON DELETE CASCADE,
    post_id    INTEGER NOT NULL REFERENCES posts (id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (hashtag_id, post_id)
);

CREATE TABLE followers
(
    id         SERIAL PRIMARY KEY,
    user_id    INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    leader_id  INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE users;
DROP TABLE posts;
DROP TABLE comments;
DROP TABLE likes;
DROP TABLE photo_tags;
DROP TABLE capture_tags;
DROP TABLE hashtags;
DROP TABLE hashtags_posts;
DROP TABLE followers;

-- task from udemy;
SELECT *
FROM users
ORDER BY id DESC
LIMIT 3;

SELECT U.id, U.first_name AS count_orders
FROM users AS U
LEFT JOIN orders AS O ON U.id = O.user_id
GROUP BY U.id;

SELECT U.id, U.first_name, P.name, P.department, O.paid
FROM users AS U
Full JOIN orders AS O ON U.id = O.user_id
Full JOIN products AS P ON O.product_id = P.id;

SELECT * FROM orders;

