/datum/console_program/server_login
	name = "Server Login"
	html_template = 'html/templates/terminal_form_template.html'

/datum/console_program/server_login/initialize()
	..()
	html[1] =  "<pre class='alignCentre'>=== Yonaguni Primary Server ==="
	html[2] =  "=========================================================="
	html[3] =  "<pre> __   _____  _   _    _    ____ _   _ _   _ ___"
	html[4] =  "<pre> \\ \\ / / _ \\| \\ | |  / \\  / ___| | | | \\ | |_ _|"
	html[5] =  "<pre>  \\ &#709; / | | |  \\| | / &#916; \\| |  _| | | |  \\| || | "
	html[6] =  "<pre>   | || |_| | |\\  |/ ___ \\ |_| | |_| | |\\  || | "
	html[7] =  "<pre>   |_| \\___/|_| \\_/_/   \\_\\____|\\___/|_| \\_|___|"
	html[8] =  " "
	html[9] =  " "
	html[10] = "<pre> Welcome to the Yonaguni Primary Server."
	html[11] = "<pre> Please login below:"
	html[12] = " "
	html[13] = "----------------------------------------------------------"
	html[14] = "<input type='hidden' name='src' value='\ref[src]' ><input type='hidden' name='action' value='login'>"
	html[15] = "<pre class='floatLeft'> Username: </pre><input id='loginName' type='text' name='loginName' class='floatLeft' style='[TERM_STD_STYLE]'>"
	html[16] = " "
	html[17] = "<pre class='floatLeft'> Password: </pre><input id='loginPass' type='password' name='loginPass' class='floatLeft' style='[TERM_STD_STYLE]'>"
	html[18] = " "
	html[19] = "<pre> <input type='submit' value='\[LOGIN\]' style='font: bold 18px \"Share Tech Mono\", monospace; color: #0F0'>"
	html[20] = " "
	html[21] = "=========================================================="
	html[22] = "<pre> \[BACK\]                                        user: null"


/datum/console_program/main_menu
	name = "Main Menu"

/datum/console_program/main_menu/initialize()
	..()
	html[1] =  "<pre class='alignCentre'>=== [owner] ==="
	html[2] =  "=========================================================="
	html[3] =  " "

	var/i = 4
	var/list/installed_software = owner.GetInstalledTerminalSoftware()
	for(var/a in installed_software)
		var/datum/console_program/P = installed_software[a]
		if(i < 21)
			html[i] = "<pre class='alignCentre'>\[[P]\]"
		else
			break
		i++

	while(i < 21)
		html[i] = " "
		i++

	html[21] = "=========================================================="
	html[22] = " "
