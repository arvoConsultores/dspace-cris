function editNode(jstreeEditNodeUrl, nodeId, nodeType) {
	JQ.ajax({
		url: jstreeEditNodeUrl+'?nodeId='+nodeId+'&type='+nodeType,
		sync: true,
		success: function(data) {
			JQ('#contentBody').html(data);
		},
		error: function(data) {
		}
	});
}

function executeNavigation(onclick, link,nodeIdentifier,linkTargetVar,titleUrl){	
	if (!onclick){
		var src=link;
		if(link.indexOf("?") != -1){
			if (link.indexOf("%2Fsaiku%2Findex.html") != -1 || link.indexOf("/saiku/index.html") != -1) {
				if (link.indexOf("query/open/") == -1 && link.indexOf("query%2Fopen%2F") == -1 && link.indexOf("saikuRepository/open/") == -1 && link.indexOf("saikuRepository%2Fopen%2F") == -1 ){
					src=link.replace('%2Fsaiku%2Findex.html%3F','%2Fsaiku%2Findex.html%3FnodeIdentifier%3D'+nodeIdentifier+'%26');
					src=src+"%23bookmark%2Fopen%2F"+nodeIdentifier;
				}
			}else
				src=src+"&nodeIdentifier="+nodeIdentifier;
		}else{
			src=src+"?nodeIdentifier="+nodeIdentifier;
		}	
		if (linkTargetVar=='self')
			JQ("#contentBody").attr("src", src);
		else
			document.location.href=src;
		if (titleUrl!=null)
			reloadtitle(nodeIdentifier,titleUrl);
	} else {		
		eval(onclick);
	}
}

function reloadtitle(nodeIdentifier,titleUrl){	
	var url=titleUrl;
	url+='?nodeIdentifier='+nodeIdentifier;
	JQ("#contentTitle").attr("src", url);
}

function menuShowDialog(title,url,label,closeText){	
	JQ('#menuDialogueNoteDiv').load(url, function() {
		JQ("#menuDialogueNoteDiv").dialog({ 
			open: function(event, ui) { JQ(".ui-dialog-titlebar-close").hide(); },
			title: title,
			modal: true, 
			height: 500,
			width: 600,
			buttons: [
			          {
			              text: closeText,
			              click: function() { JQ(this).dialog("destroy"); }
			          }
			      ]
		});
	});
}