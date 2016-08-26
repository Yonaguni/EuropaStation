//Replaces the specified row (1-22) with the supplied string
function replaceRow(row, string) {
	document.getElementById("row" + row).innerHTML = string;
}

//Adds the provided string to the last row (22) after shuffling all the other lines up one row (deleting the top line)
function addRow(string) {
	for (var i = 1; i < 22; i++) {
		var newRow = i + 1;
		document.getElementById("row" + i).innerHTML = document.getElementById("row" + newRow).innerHTML;
	}
	document.getElementById("row22").innerHTML = string;
}

//Clears all the rows of any content
function clearScreen() {
	for (var i = 1; i < 23; i++) {
		document.getElementById("row" + i).innerHTML = "";
	}
}
