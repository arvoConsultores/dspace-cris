/**
* fragmentUtil cilea v. 2.1// 2011.04.22 // jQuery 1.5.1+
*/
function fragmentElementList(fragmentDivId){
	var url=globalFragmentListUrl;
	var pars=serializeArray(getFragmentCurrentParamArray(fragmentDivId));		
	pars+=getAmpersand(pars)+"rand="+Math.random(10000000);	
	showFragmentWait(fragmentDivId);
	/*recupero l'array dei parametri*/
	var paramArray=getFragmentCurrentParamArray(fragmentDivId);
	/*
	 *scorro l'array e se trovo la stringa firstAccess=1
	 *allora devo cancellare il valore associato in quanto
	 *questo param viene usato per pulire la sessione SOLO 
	 *in fase di primo accesso.
	 *Lo stesso script infatti viene lanciato in seguito ad 
	 *un inserimento ajax di un nuovo item 
	 */
	for (i=0;i<paramArray.length;i++){
		if (paramArray[i]=="firstAccess=1"){
			paramArray[i]="firstAccess=0";
		}
	}	
	JQ.ajax({
		url: url+'?'+pars,
		contentType: "application/x-www-form-urlencoded;charset=UTF-8",
		type: "POST",
		success: function(data, textStatus, jqXHR) {
			showFragmentElementList(data,jqXHR);
		},
		error: function(jqXHR, textStatus, errorThrown) {
			showFragmentError(jqXHR);
		}
	});
}

function fragmentElementForm(fragmentDivId,elementoId,uniqueIdentifier){
	var url=globalFragmentFormUrl;		
	var pars=serializeArray(getFragmentCurrentParamArray(fragmentDivId));	
	pars+=getAmpersand(pars)+"uniqueIdentifier="+uniqueIdentifier;		
	pars+=getAmpersand(pars)+"rand="+Math.random(10000000);	
	showFragmentWait(fragmentDivId);
	JQ.ajax({
		url: url+'?'+pars,
		contentType: "application/x-www-form-urlencoded;charset=UTF-8",
		type: "GET",
		success: function(data, textStatus, jqXHR) {
			showFragmentElementForm(data,jqXHR);
		},
		error: function(jqXHR, textStatus, errorThrown) {
			showFragmentError(jqXHR);
		}
	});
}

function fragmentElementMove(fragmentDivId,elementoId,uniqueIdentifier,direction,priorityProperty){
	var url=globalFragmentMoveUrl;		
	var pars=serializeArray(getFragmentCurrentParamArray(fragmentDivId));
	pars+=getAmpersand(pars)+"uniqueIdentifier="+uniqueIdentifier;		
	pars+=getAmpersand(pars)+"rand="+Math.random(10000000);	
	pars+=getAmpersand(pars)+"direction="+direction;
	pars+=getAmpersand(pars)+"priorityProperty="+priorityProperty;
	showFragmentWait(fragmentDivId);
	JQ.ajax({
		url: url+'?'+pars,
		contentType: "application/x-www-form-urlencoded;charset=UTF-8",
		type: "GET",
		success: function(data, textStatus, jqXHR) {
			showRememberToSaveMessage();
			showFragmentElementList(data,jqXHR);
		},
		error: function(jqXHR, textStatus, errorThrown) {
			showFragmentError(jqXHR);
		}
	});
}

function fragmentElementVersionize(fragmentDivIdSource,fragmentDivIdDestination,versionNumberInputId,subElementDiscriminatorDestination,propertiesToCopy){
	var url=globalFragmentVersionizeUrl;		
	var pars=serializeArray(getFragmentCurrentParamArray(fragmentDivIdDestination));
	pars+=getAmpersand(pars)+"rand="+Math.random(10000000);	
	pars+=getAmpersand(pars)+"versionNumber="+JQ('#'+versionNumberInputId).val();
	pars+=getAmpersand(pars)+"subElementDiscriminatorDestination="+subElementDiscriminatorDestination;
	var parsSource=serializeArray(getFragmentCurrentParamArray(fragmentDivIdSource));
	parsSourceArray=parsSource.split('=');
	parsSource="";	
	for (var i=0;i<parsSourceArray.length;i++) {
		if (i!=parsSourceArray.length-1)
			parsSource+=parsSourceArray[i]+'Source=';
		else
			parsSource+=parsSourceArray[i]+'';
	}	
	pars+=getAmpersand(pars)+parsSource;
	
	showFragmentWait(fragmentDivIdSource);
	showFragmentWait(fragmentDivIdDestination);
	JQ.ajax({
		url: url+'?'+pars,
		contentType: "application/x-www-form-urlencoded;charset=UTF-8",
		type: "GET",
		success: function(data, textStatus, jqXHR) {
			showRememberToSaveMessage();
			var uniqueIdentifierNew=getHTTPHeaderValue(jqXHR,'uniqueIdentifier').replace(/-/g,'');
			{
				var url=globalFragmentListUrl;
				var pars=serializeArray(getFragmentCurrentParamArray(fragmentDivIdDestination));		
				pars+=getAmpersand(pars)+"rand="+Math.random(10000000);	
				showFragmentWait(fragmentDivIdDestination);
				var paramArray=getFragmentCurrentParamArray(fragmentDivIdDestination);
				for (i=0;i<paramArray.length;i++){
					if (paramArray[i]=="firstAccess=1"){
						paramArray[i]="firstAccess=0";
					}
				}	
				JQ.ajax({
					url: url+'?'+pars,
					contentType: "application/x-www-form-urlencoded;charset=UTF-8",
					type: "POST",
					success: function(data, textStatus, jqXHR) {
						hideFragmentWait(fragmentDivIdDestination);
						JQ('#'+fragmentDivIdDestination+"ListContainer").html(data);	
						defaultJsInitialize();
						
						
						
						
						url=globalFragmentVersionizeCopyUrl;		
						pars=serializeArray(getFragmentCurrentParamArray('budgetUsedVersioned'+(uniqueIdentifierNew)));
						pars+=getAmpersand(pars)+"rand="+Math.random(10000000);	
						pars+=getAmpersand(pars)+"versionNumber="+JQ('#'+versionNumberInputId).val();
						pars+=getAmpersand(pars)+"subElementDiscriminatorDestination="+subElementDiscriminatorDestination;
						parsSource=serializeArray(getFragmentCurrentParamArray(fragmentDivIdSource));
						parsSourceArray=parsSource.split('=');
						parsSource="";	
						for (var i=0;i<parsSourceArray.length;i++) {
							if (i!=parsSourceArray.length-1)
								parsSource+=parsSourceArray[i]+'Source=';
							else
								parsSource+=parsSourceArray[i]+'';
						}	
						pars+=getAmpersand(pars)+parsSource;
						pars+=getAmpersand(pars)+"propertiesToCopy="+propertiesToCopy;
						showFragmentWait(fragmentDivIdSource);
						showFragmentWait(fragmentDivIdDestination);
						JQ.ajax({
							url: url+'?'+pars,
							contentType: "application/x-www-form-urlencoded;charset=UTF-8",
							type: "GET",
							success: function(data, textStatus, jqXHR) {
								showRememberToSaveMessage();
								fragmentElementList(fragmentDivIdSource);
								fragmentElementList(fragmentDivIdDestination);
							}
						});
						
						
					},
					error: function(jqXHR, textStatus, errorThrown) {
						showFragmentError(jqXHR);
					}
				});
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
			showFragmentError(jqXHR);
		}
	});
}

function showRememberToSaveMessage() { 
	if (JQ('#rememberToSaveText').html()!=null && JQ('#rememberToSaveText').html()!='')
		JQ.jGrowl(JQ('#rememberToSaveText').html(), { theme: 'growl-warning', life: 10000, position: 'top-right'
			/*, beforeOpen: function(e,m,o){
				$(e).width( "550px" );
			}*/
		});
}

function fragmentElementDelete(fragmentDivId, confirmMessage ,elementoId, uniqueIdentifier){
	if (confirm(confirmMessage)){
		var url=globalFragmentDeleteUrl;		
		var pars=serializeArray(getFragmentCurrentParamArray(fragmentDivId));
		pars+=getAmpersand(pars)+"uniqueIdentifier="+uniqueIdentifier;
		pars+=getAmpersand(pars)+"rand="+Math.random(10000000);
		pars+=getAmpersand(pars)+"_form=1";
		showFragmentWait(fragmentDivId);
		JQ.ajax({
			url: url+'?'+pars,
			contentType: "application/x-www-form-urlencoded;charset=UTF-8",
			type: "GET",
			success: function(data, textStatus, jqXHR) {
				showRememberToSaveMessage();
				showFragmentElementList(data,jqXHR);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				showFragmentError(jqXHR);
			}
		});
	}		
}

function fragmentElementAdd(fragmentDivId, linkedItemId, linkedItemStringValue, jumpToListDirectly){
	var pars="";
	var paramArray=getFragmentCurrentParamArray(fragmentDivId);
	/*recupero il paramentro fragmentElementInsert e lo setto a 1*/
	for (i=0;i<paramArray.length;i++){
		if (paramArray[i]=="fragmentElementInsert=0"){
			paramArray[i]="fragmentElementInsert=1";
		}
	}	
	var url=globalFragmentFormUrl;
	var pars=serializeArray(paramArray);	
	if (linkedItemId!=null && linkedItemId!=""){
		/*
		*Questo controllo serve solo fino a quando i membri non sono gestiti con 
		*la nuova modali. Attuamente per i membri mi arriva una stringa formata dall'id
		*della persona, un punto "." e un codice numerico per distinguere partecipanti da contraenti.
		*/
		
		var tempLinkedItemId;
		if(linkedItemId.indexOf(".")!=-1)
			tempLinkedItemId=linkedItemId.substring(0, linkedItemId.indexOf("."));
		else
			tempLinkedItemId=linkedItemId;
		linkedItemId.substring(0, linkedItemId.indexOf("."))
		pars+=getAmpersand(pars)+"linkedItemId="+tempLinkedItemId;
	} else if (linkedItemStringValue!=null && linkedItemStringValue!=""){
		pars+=getAmpersand(pars)+"linkedItemStringValue="+linkedItemStringValue;			
	}
	if (jumpToListDirectly!=null && jumpToListDirectly!="" && (jumpToListDirectly=="true"||jumpToListDirectly=="1"))
		pars+=getAmpersand(pars)+"jumpToListDirectly=true";
			
	pars+=getAmpersand(pars)+"rand="+Math.random(10000000);
	showFragmentWait(fragmentDivId);		
	JQ.ajax({
		url: url+'?'+pars,
		contentType: "application/x-www-form-urlencoded;charset=UTF-8",
		type: "GET",
		success: function(data, textStatus, jqXHR) {
			showFragmentElementAdd(data,jqXHR);
		},
		error: function(jqXHR, textStatus, errorThrown) {
			showFragmentError(jqXHR);
		}
	});
}

function fragmentElementAddSetDefaults(fragmentDivId,defaultParams){
	var pars="";
	var paramArray=getFragmentCurrentParamArray(fragmentDivId);
	/*recupero il paramentro fragmentElementInsert e lo setto a 1*/
	for (i=0;i<paramArray.length;i++){
		if (paramArray[i]=="fragmentElementInsert=0"){
			paramArray[i]="fragmentElementInsert=1";
		}
	}	
	var url=globalFragmentFormUrl;
	var pars=serializeArray(paramArray);	
	pars+=getAmpersand(pars)+defaultParams;
	pars+=getAmpersand(pars)+"rand="+Math.random(10000000);
	showFragmentWait(fragmentDivId);		
	JQ.ajax({
		url: url+'?'+pars,
		contentType: "application/x-www-form-urlencoded;charset=UTF-8",
		type: "GET",
		success: function(data, textStatus, jqXHR) {
			showFragmentElementAdd(data,jqXHR);
		},
		error: function(jqXHR, textStatus, errorThrown) {
			showFragmentError(jqXHR);
		}
	});
}

function fragmentElementPost(fragmentDivId, buttonLabel){
	var paramArray=getFragmentCurrentParamArray(fragmentDivId);
	var pars=serializeArray(paramArray);
	var parsFromForm=serializeFormInputInDiv(fragmentDivId+"EditContainer");	
	/* ALERT: DONT USE FIELDSET IN A FRAGMENT FORM */
	if (parsFromForm!="")
		pars+=getAmpersand(pars)+ parsFromForm;	
	var url=globalFragmentFormUrl;	
	pars+=getAmpersand(pars)+"posting="+buttonLabel;
	JQ('#'+fragmentDivId+'EditContainer').modal('hide');
	JQ('#'+fragmentDivId+'EditContainer').html('');
	showFragmentWait(fragmentDivId);
	JQ.ajax({
		url: url,
		data: pars,		
		contentType: "application/x-www-form-urlencoded;charset=UTF-8",
		type: "POST",
		success: function(data, textStatus, jqXHR) {
			showFragmentElementPost(data,jqXHR);
		},
		error: function(jqXHR, textStatus, errorThrown) {
			showFragmentError(jqXHR);
		}
	});
}

function showFragmentElementPost(data,jqXHR){
	if (getHTTPHeaderValue(jqXHR,"FragmentError")=="1"){
		showFragmentElementForm(data,jqXHR);
	} else {	
		var fragmentDivId=getHTTPHeaderValue(jqXHR,"fragmentDivId");
		var paramArray=getFragmentCurrentParamArray(fragmentDivId);
		for (i=0;i<paramArray.length;i++){
			if (paramArray[i]=="fragmentElementInsert=1"){
				paramArray[i]="fragmentElementInsert=0";
			}
		}
		hideFragmentElementForm(data,jqXHR);
		showRememberToSaveMessage();
		//showFragmentElementList(data,jqXHR);
		fragmentElementList(fragmentDivId);
	}	
}


function showFragmentElementList(data,jqXHR) {	
	var fragmentDivId=getHTTPHeaderValue(jqXHR,"fragmentDivId");
	hideFragmentWait(fragmentDivId);
	JQ('#'+fragmentDivId+"ListContainer").html(data);	
	defaultJsInitialize();
}

function showFragmentElementAdd(data,jqXHR){	
	var jumpToListDirectly=getHTTPHeaderValue(jqXHR,"jumpToListDirectly");
	if (jumpToListDirectly!=null && jumpToListDirectly!="" && (jumpToListDirectly=="true"||jumpToListDirectly=="1")){
		showRememberToSaveMessage();
		showFragmentElementList(data,jqXHR);
	} else {
		showFragmentElementForm(data,jqXHR);
	}	
}

function showFragmentElementForm(data,jqXHR) {
	var fragmentDivId=getHTTPHeaderValue(jqXHR,"fragmentDivId");
	var framedWindowHeight=parseInt(getHTTPHeaderValue(jqXHR,"framedWindowHeight"));
	var framedWindowWidth=parseInt(getHTTPHeaderValue(jqXHR,"framedWindowWidth"));
	
	if (isNaN(framedWindowHeight))
		framedWindowHeight=500;
	if (isNaN(framedWindowWidth))
		framedWindowWidth=500;
	hideFragmentWait(fragmentDivId);
	var $modal = jQuery(data);
	jQuery('body').append($modal);
	$modal.attr('id',fragmentDivId+"EditContainer");
	$modal.filter('.modal').modal({backdrop: 'static', keyboard: false});
    $modal.filter('.modal').on('hidden.bs.modal', function(){
    	$modal.remove();
	});
	defaultJsInitialize();
}

function hideFragmentElementForm(data,jqXHR) {	
	//var fragmentDivId=getHTTPHeaderValue(jqXHR,"fragmentDivId");
	//JQ('#'+fragmentDivId+"EditContainer").html("");
}

function showFragmentError(jqXHR) {
	var fragmentDivId=getHTTPHeaderValue(jqXHR,"fragmentDivId");
	hideFragmentWait(fragmentDivId);
	//alert ("Errore");
}

function getFragmentCurrentParamArray(fragmentDivId){	
	return eval("fragmentParametersArray"+fragmentDivId);
}

function showFragmentWait(fragmentDivId) {	
	JQ('#'+fragmentDivId+"AjaxWait").attr('style','display: block; width:36px;');
}

function hideFragmentWait(fragmentDivId) {	
	JQ('#'+fragmentDivId+"AjaxWait").attr('style','display: none;');
}

//funzioni usate per la gestione degli allegati
function deleteAttachment(fragmentDivId, iframeId, iframeFormId, iframeShowDivId, iframeUploadDivId,  modelAttributeNameForFileName, modelAttributeNameForFileBlob){
		
	if (confirm("Eliminare allegato?")){
		var iframe=document.getElementById(iframeId);
		var pars=eval("fragmentParametersArray"+fragmentDivId);		
		
		var iframeForm=iframe.contentWindow.document.getElementById(iframeFormId);
		var iframeShowDivId=iframe.contentWindow.document.getElementById(iframeShowDivId);		
		var iframeUploadDivId=iframe.contentWindow.document.getElementById(iframeUploadDivId);
		
		//recupero il valore del campo fileInfo
		//lo ricostruisco eliminando il file name 
		//in modo tale che se elimino il file, salvo il fragment in sessione 
		//(e quindi non faccio l'effettivo salvataggio su db)
		//e poi vado ancora in edit non veda ancora il file 
		var fileInfoId=iframe.contentWindow.document.getElementById("fileInfoId");		
		var fileInfoValue=fileInfoId.value;
		var splittedfileInfoValue=fileInfoValue.split("|");		
		fileInfoId.value=splittedfileInfoValue[0]+"|"+splittedfileInfoValue[1]+"||"+splittedfileInfoValue[3];		
	
		var input=iframe.contentWindow.document.createElement("input");
		input.setAttribute("type","hidden");
	   	input.setAttribute("name",modelAttributeNameForFileName);
	   	input.setAttribute("value","");   		   	
	   	iframeForm.appendChild(input);
	
	   	input=iframe.contentWindow.document.createElement("input");
		input.setAttribute("type","hidden");
	   	input.setAttribute("name","removeFile");
	   	input.setAttribute("value",modelAttributeNameForFileBlob);   		   	
	   	iframeForm.appendChild(input);   	
	   	iframeShowDivId.style.display='none';
	   	iframeUploadDivId.style.display='block';	   	
	   	
	}
}


function viewAttachment(url, uniqueIdentifier, fragmentDivId, fileInfo){	
	var pars=serializeArray(eval("fragmentParametersArray"+fragmentDivId));
	document.location.href=url+"?uniqueIdentifier="+uniqueIdentifier+"&fileInfo="+fileInfo+"&"+pars;
}

function addHiddenInputFromParamArrayToFormInIframe(fragmentDivId, iframeId, iframeFormId){
	var iframe=document.getElementById(iframeId);
	var pars=eval("fragmentParametersArray"+fragmentDivId);
	var iframeForm=iframe.contentWindow.document.getElementById(iframeFormId);
	var str="";	
	for (i=0;i<pars.length;i++){
		var pieces=pars[i].split("=");
		var input=iframe.contentWindow.document.createElement("input");
		input.setAttribute("type","hidden");
	   	input.setAttribute("name",pieces[0]);
	   	input.setAttribute("value",pieces[1]);
	   	str+=input.name+"="+input.value;	   	
	   	iframeForm.appendChild(input);
	}	
	return true;
}

function showChildFragmentDialog(fragmentDivId, fragmentWidth, fragmentHeight) {
	if (fragmentWidth == "" || fragmentWidth == null)
		fragmentWidth = 600;
	if (fragmentHeight == "" || fragmentHeight == null)
		fragmentHeight = 300;
	JQ("#"+fragmentDivId).modal({backdrop: 'static', keyboard: false});
}
