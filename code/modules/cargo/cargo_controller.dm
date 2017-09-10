var/supply_order_count = 0
var/datum/controller/supply/supply_controller = new()

/datum/controller/supply
	var/points = 50
	var/points_per_process = 1
	var/ordernum
	var/list/shoppinglist = list()
	var/list/requestlist = list()
	var/list/master_supply_list = list()
	var/obj/machinery/computer/supply/primaryterminal //terminal hardcopy forms will be printed to.

/datum/controller/supply/New()
	ordernum = rand(1,9000)

	//Build master supply list
	for(var/decl/hierarchy/supply_pack/sp in cargo_supply_pack_root.children)
		if(sp.is_category())
			for(var/decl/hierarchy/supply_pack/spc in sp.children)
				master_supply_list += spc

// Supply shuttle ticker - handles supply point regeneration
// This is called by the process scheduler every thirty seconds
/datum/controller/supply/process()
	points += points_per_process

//Buying
/datum/controller/supply/proc/buy(var/atom/movable/buyer)

	var/list/spawned_atoms = list()
	for(var/S in shoppinglist)

		var/datum/supply_order/SO = S
		var/decl/hierarchy/supply_pack/SP = SO.object

		var/obj/A = new SP.containertype() // nullspace, will be passed to the drop pod datum after spawn.
		A.name = "[SP.containername][SO.comment ? " ([SO.comment])":"" ]"

		//supply manifest generation begin
		var/obj/item/paper/manifest/slip
		if(!SP.contraband)
			slip = new /obj/item/paper/manifest(A)
			slip.is_copy = 0
			slip.info = "<h3>[command_name()] Shipping Manifest</h3><hr><br>"
			slip.info +="Order #[SO.ordernum]<br>"
			slip.info +="Destination: [station_name()]<br>"
			slip.info +="[shoppinglist.len] PACKAGES IN THIS SHIPMENT<br>"
			slip.info +="CONTENTS:<br><ul>"

		//spawn the stuff, finish generating the manifest while you're at it
		if(SP.access)
			if(isnum(SP.access))
				A.req_access = list(SP.access)
			else if(islist(SP.access))
				var/list/L = SP.access // access var is a plain var, we need a list
				A.req_access = L.Copy()
			else
				world << "<span class='danger'>Supply pack with invalid access restriction [SP.access] encountered!</span>"

		var/list/spawned = SP.spawn_contents(A)
		if(slip)
			for(var/atom/content in spawned)
				slip.info += "<li>[content.name]</li>" //add the item to the manifest
			slip.info += "</ul>"
		shoppinglist.Cut()
		spawned_atoms += A

	// TODO move this to something else.
	new /obj/item/cargo_chit(get_turf(buyer), spawned_atoms, ++supply_order_count)

