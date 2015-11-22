// Sanitize inputs to avoid SQL injection attacks
proc/sql_sanitize_text(var/text)
	text = replacetext(text, "'", "''")
	text = replacetext(text, ";", "")
	text = replacetext(text, "&", "")
	return text

proc/feedback_set(var/variable,var/value)
	if(!blackbox) return

	variable = sql_sanitize_text(variable)

	var/datum/feedback_variable/FV = blackbox.find_feedback_datum(variable)

	if(!FV) return

	FV.set_value(value)

proc/feedback_inc(var/variable,var/value)
	if(!blackbox) return

	variable = sql_sanitize_text(variable)

	var/datum/feedback_variable/FV = blackbox.find_feedback_datum(variable)

	if(!FV) return

	FV.inc(value)

proc/feedback_dec(var/variable,var/value)
	if(!blackbox) return

	variable = sql_sanitize_text(variable)

	var/datum/feedback_variable/FV = blackbox.find_feedback_datum(variable)

	if(!FV) return

	FV.dec(value)

proc/feedback_set_details(var/variable,var/details)
	if(!blackbox) return

	variable = sql_sanitize_text(variable)
	details = sql_sanitize_text(details)

	var/datum/feedback_variable/FV = blackbox.find_feedback_datum(variable)

	if(!FV) return

	FV.set_details(details)

proc/feedback_add_details(var/variable,var/details)
	if(!blackbox) return

	variable = sql_sanitize_text(variable)
	details = sql_sanitize_text(details)

	var/datum/feedback_variable/FV = blackbox.find_feedback_datum(variable)

	if(!FV) return

	FV.add_details(details)