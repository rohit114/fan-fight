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
