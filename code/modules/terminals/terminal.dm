/obj/machinery/terminal
	name = "terminal"
	icon = 'icons/obj/machines/consoles.dmi'
	icon_state = "console"

//This is all placeholder code for testing that the core functionality works
//I still need to break it all out into a framework
/obj/machinery/terminal/attack_hand(mob/user)
	var/output[23]

	//58 x 22 grid

	output[1] =  "<pre class='alignCentre'>=== Yonaguni Primary Server ===</pre>"
	output[2] =  "=========================================================="
	output[3] =  "<pre> __   _____  _   _    _    ____ _   _ _   _ ___</pre>"
	output[4] =  "<pre> \\ \\ / / _ \\| \\ | |  / \\  / ___| | | | \\ | |_ _|</pre>"
	output[5] =  "<pre>  \\ &#709; / | | |  \\| | / &#916; \\| |  _| | | |  \\| || | </pre>"
	output[6] =  "<pre>   | || |_| | |\\  |/ ___ \\ |_| | |_| | |\\  || | "
	output[7] =  "<pre>   |_| \\___/|_| \\_/_/   \\_\\____|\\___/|_| \\_|___|</pre>"
	output[8] =  " "
	output[9] = " "
	output[10] = "<pre> Welcome to the Yonaguni Primary Server.</pre>"
	output[11] = "<pre> Please login below:</pre>"
	output[12] = " "
	output[13] = "----------------------------------------------------------"
	output[14] = " "
	output[15] = "<pre> Username: jdaniels</pre>"
	output[16] = " "
	output[17] = "<pre> Password: **************</pre>"
	output[18] = " "
	output[19] = "<pre> \[LOGIN\]</pre>"
	output[20] = " "
	output[21] = "=========================================================="
	output[22] = "<pre> \[BACK\]                                        user: null</pre>"

	//Push all required resources to the users cache (does nothing if they already have them)
	user << browse('html/browser/terminal.css', "display=0")
	user << browse('html/terminalFunctions.js', "display=0")
	user << browse('html/images/terminal_bg.png', "display=0")

	//Open a browser window with the base terminal html page (does not yet have any content in it)
	user << browse('html/templates/terminal_template.html', "window=terminal;size=800x600;can_resize=0")

	sleep(20)

	//Push the placeholder starting page, row-by-row to the browser, using the replaceRow javascript function
	for(var/i = 1 to 22)
		user << output(list2params(list("[i]", output[i])), "terminal.browser:replaceRow")

//Nothing to see here, move along
/obj/machinery/terminal/proc/ReplaceRow(var/row, var/string)
	return

//Debug verbs for testing browser side javascript functions
/client/verb/TermReplaceRow()
	set name = "Replace Row"
	set category = "Terminal"

	var/replaceRow = input("Input a row") as num
	var/replaceText = input("Input replacement text") as text

	mob << output(list2params(list("[replaceRow]", replaceText)), "terminal.browser:replaceRow")

/client/verb/TermClear()
	set name = "Clear"
	set category = "Terminal"

	mob << output(null, "terminal.browser:clearScreen")

/client/verb/TermAddRow()
	set name = "Add Row"
	set category = "Terminal"

	var/replaceText = input("Input new text") as text

	mob << output(list2params(list(replaceText)), "terminal.browser:addRow")
