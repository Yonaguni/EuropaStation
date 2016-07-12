/obj/machinery/terminal
	name = "terminal"
	icon = 'icons/obj/computer.dmi'
	icon_state = "aiupload"

/obj/machinery/terminal/attack_hand(mob/user as mob)
	var/output[23]

	//58 x 23 grid

	output[1] =  "              === Yonaguni Primary Server ==="
	output[2] =  "=========================================================="
	output[3] =  " __   _____  _   _    _    ____ _   _ _   _ ___"
	output[4] =  " \\ \\ / / _ \\| \\ | |  / \\  / ___| | | | \\ | |_ _|"
	output[5] =  "  \\ &#709; / | | |  \\| | / &#916; \\| |  _| | | |  \\| || | "
	output[6] =  "   | || |_| | |\\  |/ ___ \\ |_| | |_| | |\\  || | "
	output[7] =  "   |_| \\___/|_| \\_/_/   \\_\\____|\\___/|_| \\_|___|"
	output[8] =  " "
	output[9] =  " Date: 04-Jun-2453"
	output[10] = " "
	output[11] = " Welcome to the Yonaguni Primary Server."
	output[12] = " Please login below:"
	output[13] = " "
	output[14] = "----------------------------------------------------------"
	output[15] = " "
	output[16] = " Username: jdaniels"
	output[17] = " "
	output[18] = " Password: **************"
	output[19] = " "
	output[20] = " \[LOGIN\]"
	output[21] = " "
	output[22] = "=========================================================="
	output[23] = " \[BACK\]                                        user: null"

	var/html_output = {"<html>
	<head>
		<title>Terminal</title>
		<script type="text/javascript">
			document.body.innerHTML = 'butts'
		</script>
	</head>
	<body style=\"background-image: url(terminal_bg.png); overflow: hidden\">"}

	html_output = html_output + {"
		<div style=\"margin: 60px 0px 0px 70px; width: 640px; height: 480px; font: 900 18px monospace; color: #0F0\">
			<pre>
"}

	var/page_content = ""

	for(var/i = 1; i < 24; i++)
		page_content = page_content + output[i] + {"
"}

	html_output = html_output + page_content + {"
			</pre>
		</div>
	</body>
</html>"}

	user << browse(html_output, "window=terminal_[src];size=800x600;can_resize=0")

/obj/machinery/terminal/AssembleHTML(var/list/content)
	var/header ={"<html>
	<head>
		<title>[src]</title>
	</head>
	<body style=\"background-image: url(terminal_bg.png); overflow: hidden\">"}





	}
