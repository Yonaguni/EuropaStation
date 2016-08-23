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
		if(init_schema.ErrorMsg())
			world.log << "SQL ERROR: admin: [init_schema.ErrorMsg()]."

		// Death table.
		init_schema = new(
			"CREATE TABLE IF NOT EXISTS death ( \
			id INTEGER PRIMARY KEY NOT NULL UNIQUE, \
			pod TEXT NOT NULL, \
			coord TEXT NOT NULL, \
			tod DATETIME NOT NULL, \
			job TEXT NOT NULL, \
			special TEXT NOT NULL, \
			name TEXT NOT NULL, \
			byondkey TEXT NOT NULL, \
			laname TEXT NOT NULL, \
			lakey TEXT NOT NULL, \
			gender TEXT NOT NULL, \
			bruteloss INTEGER NOT NULL, \
			brainloss INTEGER NOT NULL, \
			fireloss INTEGER NOT NULL, \
			oxyloss INTEGER NOT NULL \
			);")

		init_schema.Execute(global_db)
		if(init_schema.ErrorMsg())
			world.log << "SQL ERROR: death: [init_schema.ErrorMsg()]."

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
		if(init_schema.ErrorMsg())
			world.log << "SQL ERROR: player: [init_schema.ErrorMsg()]."

		// Ban table.
		init_schema = new(
			"CREATE TABLE IF NOT EXISTS ban ( \
			id INTEGER PRIMARY KEY NOT NULL, \
			bantype TEXT NOT NULL, \
			reason text NOT NULL, \
			job TEXT DEFAULT NULL, \
			expiration_time INTEGER DEFAULT NULL, \
			ckey TEXT NOT NULL, \
			computerid TEXT NOT NULL, \
			ip TEXT NOT NULL, \
			banning_ckey TEXT NOT NULL, \
			banning_time INTEGER DEFAULT NULL, \
			unbanned_ckey  TEXT NOT NULL, \
			unbanned_datetime TEXT DEFAULT NULL \
			);")
		init_schema.Execute(global_db)
		if(init_schema.ErrorMsg())
			world.log << "SQL ERROR: ban: [init_schema.ErrorMsg()]."

		// Feedback table.
		init_schema = new(
			"CREATE TABLE IF NOT EXISTS feedback ( \
			time TEXT NOT NULL, \
			round_id INTEGER NOT NULL, \
			var_name TEXT NOT NULL, \
			var_value INTEGER DEFAULT NULL, \
			details TEXT \
			);")
		init_schema.Execute(global_db)
		if(init_schema.ErrorMsg())
			world.log << "SQL ERROR: feedback: [init_schema.ErrorMsg()]."

		// Whitelist table.
		init_schema = new(
			"CREATE TABLE IF NOT EXISTS whitelist ( \
			ckey TEXT NOT NULL, \
			race TEXT NOT NULL \
			);")
		init_schema.Execute(global_db)
		if(init_schema.ErrorMsg())
			world.log << "SQL ERROR: whitelist: [init_schema.ErrorMsg()]."

		// Whitelist table.
		init_schema = new(
			"CREATE TABLE IF NOT EXISTS playernotes( \
			ckey TEXT NOT NULL, \
			note TEXT NOT NULL \
			);")
		init_schema.Execute(global_db)
		if(init_schema.ErrorMsg())
			world.log << "SQL ERROR: playernotes: [init_schema.ErrorMsg()]."

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
