function replaceRow(row, string) {
	document.getElementById("row" + row).innerHTML = string;
}

function clearScreen() {
	for (var i = 1; i < 23; i++) {
		document.getElementById("row" + i).innerHTML = "";
	}
}

function scrollOneRow() {
	for (var i = 1; i < 22; i++) {
		var newRow = i + 1;
		document.getElementById("row" + i).innerHTML = document.getElementById("row" + newRow).innerHTML;
	}
	document.getElementById("row22").innerHTML = "<pre> </pre>";
}