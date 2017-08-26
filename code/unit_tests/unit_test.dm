/*   Unit Tests originally designed by Ccomp5950
 *
 *   Tests are created to prevent changes that would create bugs or change expected behaviour.
 *   For the most part I think any test can be created that doesn't require a client in a mob or require a game mode other then extended
 *
 *   The easiest way to make effective tests is to create a "template" if you intend to run the same test over and over and make your actual
 *   tests be a "child object" of those templates.  Be sure and name your templates with the word "template" somewhere in var/name.
 *
 *   The goal is to have all sorts of tests that run and to run them as quickly as possible.
 *
 *   Tests that require time to run we instead just check back on their results later instead of waiting around in a sleep(1) for each test.
 *   This allows us to finish unit testing quicker since we can start other tests while we're waiting on that one to finish.
 *
 *   An example of that is listed in mob_tests.dm with the human_breath test.  We spawn the mob in space and set the async flag to 1 so that we run the check later.
 *   After 10 life ticks for that mob we check it's oxyloss but while that is going on we've already ran other tests.
 *
 *   If your test requires a significant amount of time...cheat on the timers.  Either speed up the process/life runs or do as we did in the timers for the shuttle
 *   transfers in zas_tests.dm   we move a shuttle but instead of waiting 3 minutes we set the travel time to a very low number.
 *
 *   At the same time, Unit tests are intended to reflect standard usage so avoid changing to much about how stuff is processed.
 *
 *
 *   WRITE UNIT TEST TEMPLATES AS GENERIC AS POSSIBLE (makes for easy reusability)
 *
 */


#define MAX_UNIT_TEST_RUN_TIME 2 MINUTES

var/all_unit_tests_passed = 1
var/failed_unit_tests = 0
var/skipped_unit_tests = 0
var/total_unit_tests = 0
var/currently_running_tests = 0

// For console out put in Linux/Bash makes the output green or red.
// Should probably only be used for unit tests/Travis since some special folks use winders to host servers.
// if you want plain output, use dm.sh -DUNIT_TEST -DUNIT_TEST_PLAIN baystation12.dme
#ifdef UNIT_TEST_PLAIN
var/ascii_esc = ""
var/ascii_red = ""
var/ascii_green = ""
var/ascii_yellow = ""
var/ascii_reset = ""
#else
var/ascii_esc = ascii2text(27)
var/ascii_red = "[ascii_esc]\[31m"
var/ascii_green = "[ascii_esc]\[32m"
var/ascii_yellow = "[ascii_esc]\[33m"
var/ascii_reset = "[ascii_esc]\[0m"
#endif


// We list these here so we can remove them from the for loop running this.
// Templates aren't intended to be ran but just serve as a way to create child objects of it with inheritable tests for quick test creation.

/datum/unit_test
	var/name = "template - should not be ran."
	var/disabled = 0        // If we want to keep a unit test in the codebase but not run it for some reason.
	var/async = 0           // If the check can be left to do it's own thing, you must define a check_result() proc if you use this.
	var/reported = 0	// If it's reported a success or failure.  Any tests that have not are assumed to be failures.
	var/why_disabled = "No reason set."   // If we disable a unit test we will display why so it reminds us to check back on it later.

/datum/unit_test/proc/log_debug(var/message)
	log_unit_test("[ascii_yellow]---  DEBUG  --- \[[name]\]: [message][ascii_reset]")

/datum/unit_test/proc/log_bad(var/message)
	log_unit_test("[ascii_red]\[[name]\]: [message][ascii_reset]")

/datum/unit_test/proc/fail(var/message)
	all_unit_tests_passed = 0
	failed_unit_tests++
	reported = 1
	log_unit_test("[ascii_red]!!! FAILURE !!! \[[name]\]: [message][ascii_reset]")

/datum/unit_test/proc/pass(var/message)
	reported = 1
	log_unit_test("[ascii_green]*** SUCCESS *** \[[name]\]: [message][ascii_reset]")

/datum/unit_test/proc/skip(var/message)
	skipped_unit_tests++
	reported = 1
	log_unit_test("[ascii_yellow]--- SKIPPED --- \[[name]\]: [message][ascii_reset]")

/datum/unit_test/proc/start_test()
	fail("No test proc.")

/datum/unit_test/proc/check_result()
	fail("No check results proc")
	return 1

#undef MAX_UNIT_TEST_RUN_TIME
