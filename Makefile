database:
	psql -U postgres -d postgres -bq -f ./scripts/database/step_01_prepare.sql
	psql -U postgres -d postgres -bq -f ./scripts/database/step_02_schema.sql
	psql -U postgres -d postgres -bq -f ./scripts/database/step_03_permissions.sql