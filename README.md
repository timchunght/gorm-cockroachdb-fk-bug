### CockroachDB Gorm Debug repo

DB Schema in `init.sql`

```
gvm use go1.16
export PG_DSN="user=<dbuser> dbname=<dbname> port=26257 host=127.0.0.1 sslmode=disable password=" # update the user and dbuser and dbname
go run main.go
```

#### Observed Behaviour: 

If `payment_channel_id` is commented out, we noticed that the FK constraint error does show up like the log below.

```sql
ERROR: insert on table "transactions" violates foreign key constraint "fk_parent_account_id_ref_accounts" (SQLSTATE 23503)
[3.058ms] [rows:0] INSERT INTO "transactions" ("id","parent_account_id","created_at","updated_at") VALUES ('1190cb1f-5564-4db0-8bb1-7b1fe45fc410','invalid-acct-id',1627922889,1627922889)
2021/08/02 12:48:09 DBError:  ERROR: insert on table "transactions" violates foreign key constraint "fk_parent_account_id_ref_accounts" (SQLSTATE 23503)
```

However, with the payment_channel_id as NULL, the follow successful insert happens,

```sql
 /Users/timothychung/Documents/workspace/gorm-cockroach-bug/main.go:31
[22.258ms] [rows:1] INSERT INTO "transactions" ("id","parent_account_id","payment_channel_id","created_at","updated_at") VALUES ('1e053b81-022e-4503-9111-4a39b3d4da11','invalid-acct-id',NULL,1627922929,1627922929)
```