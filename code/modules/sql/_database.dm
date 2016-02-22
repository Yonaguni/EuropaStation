#define BAN_JOBBAN    "BAN_JOB"
#define BAN_SERVERBAN "BAN_SERVER"

var/database/global_db

proc/establish_database_connection()

	if(!global_db)

		// Create or load the DB.
		global_db = new(config.sql_path)

		world.log << "SQL database loaded."

		// Admin table.
		var/database/query/init_schema = new(
			"CREATE TABLE IF NOT EXISTS admin ( \
			ckey TEXT PRIMARY KEY NOT NULL UNIQUE, \
			rank TEXT NOT NULL DEFAULT 'Administrator', \
			rights INTEGER NOT NULL DEFAULT 0 \
			);")
		init_schema.Execute(global_db)

		// Playerdata table.
		init_schema = new(
			"CREATE TABLE IF NOT EXISTS player ( \
			ckey TEXT PRIMARY KEY NOT NULL UNIQUE, \
			firstseen datetime NOT NULL, \
			lastseen datetime NOT NULL, \
			ip TEXT NOT NULL, \
			computerid TEXT NOT NULL, \
			lastadminrank TEXT NOT NULL DEFAULT 'Player' \
			);")
		init_schema.Execute(global_db)

		// Ban table.
		init_schema = new(
			"CREATE TABLE IF NOT EXISTS ban ( \
			id INTEGER PRIMARY KEY NOT NULL, \
			bantype TEXT NOT NULL, \
			reason text NOT NULL, \
			job TEXT DEFAULT NULL, \
			expiration_datetime datetime DEFAULT NULL, \
			ckey TEXT NOT NULL, \
			computerid TEXT DEFAULT NULL, \
			ip TEXT DEFAULT NULL, \
			banning_ckey TEXT NOT NULL, \
			banning_datetime datetime NOT NULL, \
			unbanned_ckey TEXT DEFAULT NULL, \
			unbanned_datetime datetime DEFAULT NULL \
			);")
		init_schema.Execute(global_db)

		// Whitelist table.
		init_schema = new(
			"CREATE TABLE IF NOT EXISTS whitelist ( \
			ckey TEXT NOT NULL, \
			race TEXT NOT NULL \
			);")
		init_schema.Execute(global_db)

		// Whitelist table.
		init_schema = new(
			"CREATE TABLE IF NOT EXISTS playernotes( \
			ckey TEXT NOT NULL, \
			note TEXT NOT NULL \
			);")
		init_schema.Execute(global_db)

		if(!global_db)
			world.log << "Failed to load or create an SQL database."

	return 1

// Run all strings to be used in an SQL query through this proc first to properly escape out injection attempts.
proc/sql_sanitize_text(var/t = "")
	// removes all non upper/lower/numbers and hyphens    strFirstName = strFirstName.replace(/[^A-Za-z0-9-]/gim, '');
	// only 0 to 9                                        strPhone = strPhone.replace(/[^0-9]/gim, '');
	t = replacetext(t, "'", "''")
	t = replacetext(t, ";", "")
	t = replacetext(t, "&", "")
	return sanitize(t)
