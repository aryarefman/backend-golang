postgres:
	docker run --name postgres17 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=armelan844 -d postgres:17-alpine

createdb:
	docker exec -it postgres17 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres17 dropdb --username=root simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:armelan844@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:armelan844@localhost:5432/simple_bank?sslmode=disable" -verbose down

.PHONY: createdb postgres dropdb migrateup migratedown