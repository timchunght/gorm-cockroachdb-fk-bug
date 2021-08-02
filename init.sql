CREATE TABLE "organizations" (
	"id" VARCHAR(36) PRIMARY KEY,
	"created_at" bigint,
	"updated_at" bigint
);

CREATE TABLE "accounts" (
  "id" VARCHAR(36) PRIMARY KEY,
  "organization_id" VARCHAR(36),
  "unique_id" VARCHAR(255),
  "created_at" bigint,
  "updated_at" bigint
);
ALTER TABLE "accounts" ADD FOREIGN KEY ("organization_id") REFERENCES "organizations" ("id");
CREATE UNIQUE INDEX ON "accounts" ("organization_id", "unique_id");

CREATE TABLE "payment_channels" (
  "id" VARCHAR(36) PRIMARY KEY,
  "unique_id" VARCHAR(255),
  "organization_id" VARCHAR(36) REFERENCES organizations(id),
  "created_at" bigint,
  "updated_at" bigint
);
CREATE UNIQUE INDEX ON "payment_channels" ("organization_id", "unique_id");

CREATE TABLE "transactions" (
  "id" VARCHAR(36) PRIMARY KEY,
  "organization_id" VARCHAR(36),
  "external_id" VARCHAR(255),
  "parent_account_id" VARCHAR(36),
  "payment_channel_id" VARCHAR(36) REFERENCES payment_channels(id),
  "created_at" bigint,
  "updated_at" bigint
);
ALTER TABLE "transactions" ADD FOREIGN KEY ("organization_id") REFERENCES "organizations" ("id");
ALTER TABLE "transactions" ADD FOREIGN KEY ("parent_account_id") REFERENCES "accounts" ("id");
CREATE UNIQUE INDEX ON "transactions" ("organization_id", "external_id");