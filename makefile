.PHONY: migrate migrate-watch

migrate:
	dart run build_runner build -d

migrate-watch:
	dart run build_runner watch -d

database-migrate:
	flutter pub run build_runner build --delete-conflicting-outputs