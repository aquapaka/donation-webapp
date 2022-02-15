USE donationdb
GO

/* Drop table, constrants */
ALTER TABLE donation
DROP CONSTRAINT FK_donation_donation_event,
				FK_donation_app_user
GO

DROP TABLE app_user
DROP TABLE donation
DROP TABLE donation_event
GO

CREATE TABLE app_user(
	app_user_id bigint NOT NULL PRIMARY KEY,
	date_of_birth date NOT NULL,
	email nvarchar(255) NOT NULL,
	fullname nvarchar(255) NOT NULL,
	gender bit NOT NULL,
	password nvarchar(255) NOT NULL,
	phone_number int NULL,
	role nvarchar(255) NOT NULL,
	username nvarchar(255) NOT NULL
)
GO

CREATE TABLE dbo.donation(
	donation_id bigint NOT NULL PRIMARY KEY,
	date date NOT NULL,
	donation_amount bigint NOT NULL,
	donation_event_id bigint NOT NULL,
	app_user_id bigint NOT NULL,
)
GO

CREATE TABLE dbo.donation_event(
	donation_event_id bigint NOT NULL PRIMARY KEY,
	current_donation_amount bigint NOT NULL,
	detail nvarchar(500) NOT NULL,
	end_time date NOT NULL,
	images nvarchar(255) NOT NULL,
	start_time date NOT NULL,
	title nvarchar(255) NOT NULL,
	total_donation_amount bigint NOT NULL,
)
GO

ALTER TABLE dbo.donation  WITH CHECK ADD CONSTRAINT FK_donation_donation_event FOREIGN KEY(donation_event_id)
REFERENCES dbo.donation_event (donation_event_id)
GO

ALTER TABLE dbo.donation  WITH CHECK ADD CONSTRAINT FK_donation_app_user FOREIGN KEY(app_user_id)
REFERENCES dbo.app_user (app_user_id)
GO
