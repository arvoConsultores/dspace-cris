function reloadMenuContext(url) {							
	JQ.ajax({
		url: url,
		dataType: "text",		
		contentType: "application/x-www-form-urlencoded;charset=UTF-8",													
		success: function(data,extStatus, errorThrown) {
			location.reload();
		},
		error: function(data,extStatus, errorThrown) {
			JQ('#divAggiornamento').html('<html>Errore refresh menu</html>');
		}
	});
}