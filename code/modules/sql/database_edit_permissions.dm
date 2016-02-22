/client/proc/edit_admin_permissions()
	set category = "Admin"
	set name = "Permissions Panel"
	set desc = "Edit admin permissions"
	if(!check_rights(R_PERMISSIONS))	return
	usr.client.holder.edit_admin_permissions()

/datum/admins/proc/edit_admin_permissions()
	if(!check_rights(R_PERMISSIONS))	return

	var/output = {"<!DOCTYPE html>
<html>
<head>
<title>Permissions Panel</title>
<script type='text/javascript' src='search.js'></script>
<link rel='stylesheet' type='text/css' href='panels.css'>
</head>
<body onload='selectTextField();updateSearch();'>
<div id='main'><table id='searchable' cellspacing='0'>
<tr class='title'>
<th style='width:125px;text-align:right;'>CKEY <a class='small' href='?src=\ref[src];editrights=add'>\[+\]</a></th>
<th style='width:125px;'>RANK</th><th style='width:100%;'>PERMISSIONS</th>
</tr>
"}

	for(var/adm_ckey in admin_datums)
		var/datum/admins/D = admin_datums[adm_ckey]
		if(!D)	continue
		var/rank = D.rank ? D.rank : "*none*"
		var/rights = rights2text(D.rights," ")
		if(!rights)	rights = "*none*"

		output += "<tr>"
		output += "<td style='text-align:right;'>[adm_ckey] <a class='small' href='?src=\ref[src];editrights=remove;ckey=[adm_ckey]'>\[-\]</a></td>"
		output += "<td><a href='?src=\ref[src];editrights=rank;ckey=[adm_ckey]'>[rank]</a></td>"
		output += "<td><a class='small' href='?src=\ref[src];editrights=permissions;ckey=[adm_ckey]'>[rights]</a></td>"
		output += "</tr>"

	output += {"
</table></div>
<div id='top'><b>Search:</b> <input type='text' id='filter' value='' style='width:70%;' onkeyup='updateSearch();'></div>
</body>
</html>"}

	usr << browse(output,"window=editrights;size=600x500")

/datum/admins/proc/log_admin_rank_modification(var/adm_ckey, var/new_rank)
	if(!config.sql_enabled)
		return

	if(!usr.client)
		return

	if(!usr.client.holder || !(usr.client.holder.rights & R_PERMISSIONS))
		usr << "You do not have permission to do this!"
		return

	establish_database_connection()

	if(!global_db)
		usr << "<span class='warning'>Failed to establish database connection.</span>"
		return

	if(!adm_ckey || !new_rank)
		return

	adm_ckey = ckey(adm_ckey)

	if(!adm_ckey)
		return

	if(!istext(adm_ckey) || !istext(new_rank))
		return

	var/database/query/select_query = new("SELECT * FROM admin WHERE ckey = '[adm_ckey]'")
	select_query.Execute(global_db)

	var/new_admin = 1
	var/admin_id
	while(select_query.NextRow())
		new_admin = 0

	if(new_admin)
		var/database/query/insert_query = new("INSERT INTO admin VALUES ('[adm_ckey]', '[new_rank]', 0)")
		insert_query.Execute(global_db)
		usr << "<span class='notice'>New admin added.</span>"
	else
		if(!isnull(admin_id) && isnum(admin_id))
			var/database/query/insert_query = new("UPDATE admin SET rank = '[new_rank]' WHERE ckey = [adm_ckey]")
			insert_query.Execute(global_db)
			usr << "<span class='notice'>Admin rank changed.</span>"

/datum/admins/proc/log_admin_permission_modification(var/adm_ckey, var/new_permission)
	if(!config.sql_enabled)	return

	if(!usr.client)
		return

	if(!usr.client.holder || !(usr.client.holder.rights & R_PERMISSIONS))
		usr << "<span class='warning'>You do not have permission to do this!</span>"
		return

	establish_database_connection()
	if(!global_db)
		usr << "<span class='warning'>Failed to establish database connection.</span>"
		return

	if(!adm_ckey || !new_permission)
		return

	adm_ckey = ckey(adm_ckey)

	if(!adm_ckey)
		return

	if(istext(new_permission))
		new_permission = text2num(new_permission)

	if(!istext(adm_ckey) || !isnum(new_permission))
		return

	var/database/query/select_query = new("SELECT * FROM admin WHERE ckey = '[adm_ckey]'")
	select_query.Execute(global_db)

	var/admin_rights
	while(select_query.NextRow())
		var/list/querydata = select_query.GetRowData()
		admin_rights = text2num(querydata["rights"])

	if(admin_rights & new_permission) //This admin already has this permission, so we are removing it.
		var/database/query/insert_query = new("UPDATE admin SET rights = [admin_rights & ~new_permission] WHERE ckey = [adm_ckey]")
		insert_query.Execute(global_db)
		usr << "<span class = 'notice'>Permission removed.</span>"
	else
		var/database/query/insert_query = new("UPDATE admin SET rights = '[admin_rights | new_permission]' WHERE ckey = [adm_ckey]")
		insert_query.Execute(global_db)
		usr << "<span class = 'notice'>Permission added.</span>"
