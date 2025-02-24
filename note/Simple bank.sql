-- Membuat tabel 'accounts' untuk menyimpan data akun pengguna
CREATE TABLE "accounts" (
  "id" bigserial PRIMARY KEY,  -- ID unik untuk setiap akun, auto-increment (bigserial = bigint + autoincrement)
  "owner" varchar NOT NULL,   -- Nama pemilik akun
  "balance" bigint NOT NULL,  -- Saldo akun
  "currency" varchar NOT NULL, -- Mata uang akun
  "created_code" timestampz NOT NULL DEFAULT 'now()' -- Waktu pembuatan akun, default ke waktu saat ini
);

-- Membuat tabel 'entries' untuk mencatat setiap transaksi yang berhubungan dengan akun
CREATE TABLE "entries" (
  "id" bigserial PRIMARY KEY,  -- ID unik untuk setiap transaksi
  "account_id" bigint,         -- Foreign key ke tabel 'accounts', menghubungkan transaksi dengan akun
  "amount" bigint NOT NULL,    -- Jumlah transaksi, bisa positif atau negatif
  "created_code" timestampz NOT NULL DEFAULT 'now()' -- Waktu transaksi, default ke waktu saat ini
);

-- Membuat tabel 'transfers' untuk mencatat transfer antar akun
CREATE TABLE "transfers" (
  "id" bigserial PRIMARY KEY,  -- ID unik untuk setiap transfer
  "from_account_id" bigint,    -- Foreign key ke 'accounts', menunjukkan akun pengirim
  "to_account_id" bigint,      -- Foreign key ke 'accounts', menunjukkan akun penerima
  "amount" bigint NOT NULL,    -- Jumlah yang ditransfer, harus positif
  "created_code" timestampz DEFAULT 'now()' -- Waktu transfer, default ke waktu saat ini
);

-- Membuat indeks untuk meningkatkan kecepatan pencarian berdasarkan 'owner' di tabel accounts
CREATE INDEX ON "accounts" ("owner");

-- Membuat indeks untuk mempercepat pencarian berdasarkan account_id di tabel entries
CREATE INDEX ON "entries" ("account_id");

-- Membuat indeks untuk mempercepat pencarian transaksi berdasarkan from_account_id di tabel transfers
CREATE INDEX ON "transfers" ("from_account_id");

-- Membuat indeks untuk mempercepat pencarian transaksi berdasarkan to_account_id di tabel transfers
CREATE INDEX ON "transfers" ("to_account_id");

-- Membuat indeks komposit untuk mempercepat pencarian berdasarkan kombinasi from_account_id dan to_account_id
CREATE INDEX ON "transfers" ("from_account_id", "to_account_id");

-- Menambahkan catatan pada kolom 'amount' di tabel entries, menjelaskan bahwa nilai bisa positif atau negatif
COMMENT ON COLUMN "entries"."amount" IS 'can be negative or positive';

-- Menambahkan catatan pada kolom 'amount' di tabel transfers, menjelaskan bahwa nilai harus positif
COMMENT ON COLUMN "transfers"."amount" IS 'must be positive';

-- Menetapkan foreign key untuk memastikan integritas referensial antara 'entries' dan 'accounts'
ALTER TABLE "entries" ADD FOREIGN KEY ("account_id") REFERENCES "accounts" ("id");

-- Menetapkan foreign key untuk memastikan bahwa 'from_account_id' di tabel transfers berasal dari tabel accounts
ALTER TABLE "transfers" ADD FOREIGN KEY ("from_account_id") REFERENCES "accounts" ("id");

-- Menetapkan foreign key untuk memastikan bahwa 'to_account_id' di tabel transfers berasal dari tabel accounts
ALTER TABLE "transfers" ADD FOREIGN KEY ("to_account_id") REFERENCES "accounts" ("id");