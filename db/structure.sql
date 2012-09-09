CREATE TABLE "authorizations" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "provider" varchar(255) NOT NULL, "uid" varchar(255) NOT NULL, "user_id" integer NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "comments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "commentable_id" integer DEFAULT 0, "commentable_type" varchar(255) DEFAULT '', "title" varchar(255) DEFAULT '', "body" text DEFAULT '', "subject" varchar(255) DEFAULT '', "user_id" integer DEFAULT 0 NOT NULL, "parent_id" integer, "lft" integer, "rgt" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "countries" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "slug" varchar(255), "code" varchar(255) NOT NULL, "name" varchar(255) NOT NULL, "alias" varchar(255), "full_name" varchar(255), "polls_count" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "polls" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "slug" varchar(255), "question" varchar(255) NOT NULL, "votings_count" integer, "yes" varchar(255) DEFAULT 'Yes' NOT NULL, "no" varchar(255) DEFAULT 'No' NOT NULL, "yes_positive" boolean DEFAULT 't' NOT NULL, "user_id" integer NOT NULL, "country_code" varchar(255) NOT NULL, "category" integer DEFAULT 4 NOT NULL, "coverage" integer DEFAULT 0 NOT NULL, "weight" integer DEFAULT -1 NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "featured" boolean DEFAULT 'f', "positive_votings_count" integer, "negative_votings_count" integer);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "scores" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "value" float DEFAULT 50.0 NOT NULL, "previous_score" float, "country_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) NOT NULL, "email" varchar(255) NOT NULL, "crypted_password" varchar(255), "password_salt" varchar(255), "country_code" varchar(255) NOT NULL, "persistence_token" varchar(255), "login_count" integer DEFAULT 0 NOT NULL, "failed_login_count" integer DEFAULT 0 NOT NULL, "last_request_at" datetime, "current_login_at" datetime, "last_login_at" datetime, "current_login_ip" varchar(255), "last_login_ip" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "avatar" varchar(255), "admin" boolean DEFAULT 'f', "first_name" varchar(255), "last_name" varchar(255));
CREATE TABLE "votings" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "poll_id" integer NOT NULL, "user_id" integer NOT NULL, "country_code" varchar(255) NOT NULL, "vote" integer NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_authorizations_on_user_id" ON "authorizations" ("user_id");
CREATE INDEX "index_comments_on_commentable_id" ON "comments" ("commentable_id");
CREATE INDEX "index_comments_on_user_id" ON "comments" ("user_id");
CREATE UNIQUE INDEX "index_countries_on_code" ON "countries" ("code");
CREATE UNIQUE INDEX "index_countries_on_name" ON "countries" ("name");
CREATE UNIQUE INDEX "index_countries_on_slug" ON "countries" ("slug");
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_persistence_token" ON "users" ("persistence_token");
CREATE INDEX "index_votings_on_poll_id" ON "votings" ("poll_id");
CREATE INDEX "index_votings_on_user_id" ON "votings" ("user_id");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20110908002142');

INSERT INTO schema_migrations (version) VALUES ('20120326130623');

INSERT INTO schema_migrations (version) VALUES ('20120327081920');

INSERT INTO schema_migrations (version) VALUES ('20120515071403');

INSERT INTO schema_migrations (version) VALUES ('20120611085414');

INSERT INTO schema_migrations (version) VALUES ('20120611085949');

INSERT INTO schema_migrations (version) VALUES ('20120715023602');

INSERT INTO schema_migrations (version) VALUES ('20120715060128');

INSERT INTO schema_migrations (version) VALUES ('20120731062406');

INSERT INTO schema_migrations (version) VALUES ('20120731074617');

INSERT INTO schema_migrations (version) VALUES ('20120822023707');

INSERT INTO schema_migrations (version) VALUES ('20120824080902');