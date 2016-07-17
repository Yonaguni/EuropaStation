/obj/machinery/terminal
	name = "terminal"
	icon = 'icons/obj/computer.dmi'
	icon_state = "aiupload"

/obj/machinery/terminal/attack_hand(mob/user as mob)
	var/output[23]

	//62 x 22 grid

	output[1] =  "              === Yonaguni Primary Server ==="
	output[2] =  "=========================================================="
	output[3] =  " __   _____  _   _    _    ____ _   _ _   _ ___"
	output[4] =  " \\ \\ / / _ \\| \\ | |  / \\  / ___| | | | \\ | |_ _|"
	output[5] =  "  \\ &#709; / | | |  \\| | / &#916; \\| |  _| | | |  \\| || | "
	output[6] =  "   | || |_| | |\\  |/ ___ \\ |_| | |_| | |\\  || | "
	output[7] =  "   |_| \\___/|_| \\_/_/   \\_\\____|\\___/|_| \\_|___|"
	output[8] =  " "
	output[9] = " "
	output[10] = " Welcome to the Yonaguni Primary Server."
	output[11] = " Please login below:"
	output[12] = " "
	output[13] = "----------------------------------------------------------"
	output[14] = " "
	output[15] = " Username: jdaniels"
	output[16] = " "
	output[17] = " Password: **************"
	output[18] = " "
	output[19] = " \[LOGIN\]"
	output[20] = " "
	output[21] = "=========================================================="
	output[22] = " \[BACK\]                                        user: null"

	user << browse('html/browser/terminal.css', "display=0")
	user << browse('html/terminalFunctions.js', "display=0")
	user << browse('html/images/terminal_bg.png', "display=0")

	user << browse('html/templates/terminal_template.html', "window=terminal;size=800x600;can_resize=0")

	sleep(100)

	user << output(list2params(list("10", "Test")), "terminal:replaceRow")
