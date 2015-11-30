function noteManager() {
	hideNote();
	if (JQ("div[class^='note']").length > 0) {
		JQ('#noteDivButton').html("<p id='noteButtonP' onclick='showNote();'>Note</p>");
	} else {
		JQ('#noteDivButton').html('');
	}
}

function showNote() {
	JQ("div[class^='note']").show('slow');
	JQ('#noteButtonP').click(function() {
	      hideNote();
	});
}

function hideNote() {
	JQ("div[class^='note']").hide('slow');
	JQ('#noteButtonP').click(function() {
	      showNote();
	});

}