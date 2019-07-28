--tables for database fanfight

CREATE TABLE "user" (
  "id" SERIAL PRIMARY KEY,
  "name" text,
  "imageUrl" text,
  "phone" text,
  "email" text,
  "registeredAt" timestamp with time zone,
  "createdAt" timestamp with time zone,
  "updatedAt" timestamp with time zone 
);

CREATE TABLE wallet (
  "id" SERIAL PRIMARY KEY,
  "user" integer REFERENCES "user"(id),
  "bonus" real,
  "deposit" real,
  "winnings" real,
  "createdAt" timestamp with time zone,
  "updatedAt" timestamp with time zone 
);


INSERT INTO wallet ("user", bonus, deposit, winnings) VALUES(1, 60, 100, 340);
INSERT INTO wallet ("user", bonus, deposit, winnings) VALUES(2, 60, 400, 340);
UPDATE wallet set bonus=60, deposit=100, winnings=340 where "user"=1;
UPDATE wallet set bonus=60, deposit=400, winnings=340 where "user"=2;