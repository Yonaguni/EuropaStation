proc/sql_report_death(var/mob/living/H)
	if(!config.sql_enabled)
		return
	if(!H)
		return
	if(!H.key || !H.mind)
		return

	var/area/placeofdeath = get_area(H)
	var/podname = placeofdeath ? placeofdeath.name : "Unknown area"

	var/sqlname = sql_sanitize_text(H.real_name)
	var/sqlkey = sql_sanitize_text(H.key)
	var/sqlpod = sql_sanitize_text(podname)
	var/sqlspecial = sql_sanitize_text(H.mind.special_role)
	var/sqljob = sql_sanitize_text(H.mind.assigned_role)
	var/laname
	var/lakey
	if(H.lastattacker)
		laname = sql_sanitize_text(H.lastattacker:real_name)
		lakey = sql_sanitize_text(H.lastattacker:key)
	var/sqltime = time2text(world.realtime, "YYYY-MM-DD hh:mm:ss")
	var/coord = "[H.x], [H.y], [H.z]"
	establish_database_connection()
	if(!global_db)
		log_game("SQL ERROR during death reporting. Failed to connect.")
	else
		var/database/query/query = new("INSERT INTO death (name, byondkey, job, special, pod, tod, laname, lakey, gender, bruteloss, fireloss, brainloss, oxyloss, coord) VALUES ('[sqlname]', '[sqlkey]', '[sqljob]', '[sqlspecial]', '[sqlpod]', '[sqltime]', '[laname]', '[lakey]', '[H.gender]', [H.getBruteLoss()], [H.getFireLoss()], [H.brainloss], [H.getOxyLoss()], '[coord]')")
		if(!query.Execute(global_db))
			var/err = query.ErrorMsg()
			log_game("SQL ERROR during death reporting. Error : \[[err]\]\n")

// Add a string to feedback table.
/proc/feedback_add_details(var/feedback_type, var/feedback_data)
	establish_database_connection()
	if(!global_db)
		return
	//TODO

// Overwrite a feedback table string.
/proc/feedback_set_details(var/feedback_type, var/feedback_data)
	establish_database_connection()
	if(!global_db)
		return
	//TODO

// Increment a feedback field.
/proc/feedback_inc(var/feedback_type, var/feedback_amt)
	establish_database_connection()
	if(!global_db)
		return
	//TODO

// Set a feedback val.
/proc/feedback_set(var/feedback_type, var/feedback_amt)
	establish_database_connection()
	if(!global_db)
		return
	//TODO
