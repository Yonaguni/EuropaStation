
// Keep these two together, they *must* be defined on both
// If /client ever becomes /datum/client or similar, they can be merged
/client/proc/get_view_variables_header()
	return "<b>[src]</b>"
/datum/proc/get_view_variables_header()
	return "<b>[src]</b>"

/atom/get_view_variables_header()
	return {"
		<a href='?_src_=vars;datumedit=\ref[src];varnameedit=name'><b>[src]</b></a>
		<br><font size='1'>
		<a href='?_src_=vars;rotatedatum=\ref[src];rotatedir=left'><<</a>
		<a href='?_src_=vars;datumedit=\ref[src];varnameedit=dir'>[dir2text(dir)]</a>
		<a href='?_src_=vars;rotatedatum=\ref[src];rotatedir=right'>>></a>
		</font>
		"}

/mob/living/get_view_variables_header()
	return {"
		<a href='?_src_=vars;rename=\ref[src]'><b>[src]</b></a><font size='1'>
		<br><a href='?_src_=vars;rotatedatum=\ref[src];rotatedir=left'><<</a> <a href='?_src_=vars;datumedit=\ref[src];varnameedit=dir'>[dir2text(dir)]</a> <a href='?_src_=vars;rotatedatum=\ref[src];rotatedir=right'>>></a>
		<br><a href='?_src_=vars;datumedit=\ref[src];varnameedit=ckey'>[ckey ? ckey : "No ckey"]</a> / <a href='?_src_=vars;datumedit=\ref[src];varnameedit=real_name'>[real_name ? real_name : "No real name"]</a>
		<br>
		BRUTE:<a href='?_src_=vars;mobToDamage=\ref[src];adjustDamage=brute'>[getBruteLoss()]</a>
		FIRE:<a href='?_src_=vars;mobToDamage=\ref[src];adjustDamage=fire'>[getFireLoss()]</a>
		TOXIN:<a href='?_src_=vars;mobToDamage=\ref[src];adjustDamage=toxin'>[getToxLoss()]</a>
		OXY:<a href='?_src_=vars;mobToDamage=\ref[src];adjustDamage=oxygen'>[getOxyLoss()]</a>
		BRAIN:<a href='?_src_=vars;mobToDamage=\ref[src];adjustDamage=brain'>[getBrainLoss()]</a>
		</font>
		"}

// Same for these as for get_view_variables_header() above
/client/proc/get_view_variables_options()
	return ""
/datum/proc/get_view_variables_options()
	return ""

/mob/get_view_variables_options()
	return ..() + {"
		<option value='?_src_=vars;mob_player_panel=\ref[src]'>Show player panel</option>
		<option>---</option>
		<option value='?_src_=vars;direct_control=\ref[src]'>Assume Direct Control</option>
		<option value='?_src_=vars;regenerateicons=\ref[src]'>Regenerate Icons</option>
		<option value='?_src_=vars;addlanguage=\ref[src]'>Add Language</option>
		<option value='?_src_=vars;remlanguage=\ref[src]'>Remove Language</option>
		<option value='?_src_=vars;addorgan=\ref[src]'>Add Organ</option>
		<option value='?_src_=vars;remorgan=\ref[src]'>Remove Organ</option>
		<option value='?_src_=vars;fix_nano=\ref[src]'>Fix NanoUI</option>
		"}

/mob/living/human/get_view_variables_options()
	return ..() + "<option value='?_src_=vars;setspecies=\ref[src]'>Set Species</option>"

/obj/get_view_variables_options()
	return ..() + {"
		<option value='?_src_=vars;delall=\ref[src]'>Delete all of type</option>
		"}

