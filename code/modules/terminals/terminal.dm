/obj/machinery/terminal
	name = "terminal"
	icon = 'icons/obj/machines/consoles.dmi'
	icon_state = "console"
	var/datum/console_program/program
	var/startup_program = /datum/console_program/server_login

/obj/machinery/terminal/New()
	..()
	program = new startup_program()

/obj/machinery/terminal/attack_hand(mob/user)
	if(program)
		program.Run(user)

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
