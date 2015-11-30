function confirmMessageWithUrl(msg,url) {   
    ans = confirm(msg);
    if (ans) 
        location.href=url;
}

function showPopup(href) {
	showPopupByName('win',href);
}
function showPopupByName(name,href) {
	na_open_window(name,href, 10, 10, 930, 630, 0, 0, 0, 1, 1);
}
function showNewTab(href) {
	var win=window.open(href, '_blank');
	win.focus();
}

function cileaUnescape (value) {
	value=value.replace(/&#039;/g,"'");
	value=value.replace(/&#034;/g,'"');
	return value;
}

function evaluateEmbeddedScript(fragment){
	/*
	*ATTENZIONE: 
	*I tag <script> che ritornano dagli AJAX vengono "rimaneggiati" dai browser 
	*per l'inserimento nel DOM.
	*IE vede <SCRIPT>
	*FF vede <script>
	*document.write(fragment);
	*/
	var fragmentLowerCase=fragment.toLowerCase();
	var startIndex=fragmentLowerCase.indexOf('<script');	
	
	while (startIndex!=-1 && startIndex<fragment.length){				
		startIndex = fragment.indexOf(">", startIndex)+1;
		var endIndex = fragmentLowerCase.indexOf("</script", startIndex);
		/*JQ("scriptViewer").innerHTML=$("scriptViewer").innerHTML+fragment.substring(startIndex,endIndex)
		*JQ.globalEval( fragment.substring(startIndex,endIndex));
		*/
		eval( fragment.substring(startIndex,endIndex));
		startIndex=fragmentLowerCase.indexOf("<script", endIndex);
		
	}		
}

function serializeFormInputInDiv(divId){
	/*var inputs=JQ('#'+divId).getElementsByTagName("input");
	var selects=JQ('#'+divId).getElementsByTagName("select");
	var textareas=JQ('#'+divId).getElementsByTagName("textarea");
	
	var results = new Array();
	var counter=0;

	for(var i=0;i<inputs.length;i++,counter++){
		results[counter]=inputs[i];
	}

	for(var i=0;i<selects.length;i++,counter++){
		results[counter]=selects[i];
	}

	for(var i=0;i<textareas.length;i++,counter++){
		results[counter]=textareas[i];
	}	

	var serializedForm="";
	for (var i=0;i<results.length;i++){
		var serializedItem=Form.Element.serialize(JQ('#'+results[i]));
		if (serializedItem!=null && serializedItem!='') {
			if (i!=0)		
				serializedForm+="&";
			serializedForm+=serializedItem;
		} 
	}*/
	/* ALERT: DONT USE FIELDSET IN A FRAGMENT FORM */
	var serializedForm=JQ('#'+divId+" *").serialize();
	//alert(serializedForm);
	
	//recupero tutti gli iframe presenti in questo div
	//gli iframe vengono usati per la gestione dell'upload dei file
	//serializzo SOLO gli input ad eccezione di quelli di tipo file
	//questo perch� l'upload effettivo del file viene fatto a parte
	//devo utilizzare un meccanismo di serializzazione differente rispetto agli 
	//input normali perch� il codice di serializzazione di prototype suppone
	//che tutti gli input facciano parte dello stesso document javascript
	//ma l'iframe ha un DOM separato
	//alert(divId);
	var iframes=document.getElementById(divId).getElementsByTagName("iframe");
	//var iframes=JQ('#'+divId)//.getElementsByTagName("iframe");
	//alert(iframes);
	for (i=0;i<iframes.length;i++){		
		var inputsIframe=iframes[i].contentWindow.document.getElementsByTagName("input");
		
		for (j=0;j<inputsIframe.length;j++){
			//escludo gli input file, submit e quello con nome uniqueIdentifier
			//perch� gi� presente nel documento principale
			if (
					"file"!=inputsIframe[j].type.toLowerCase() 
					&& 
					"submit"!=inputsIframe[j].type.toLowerCase()
					&& 
					"uniqueIdentifier"!=inputsIframe[j].name
					
			){
				var inputName=inputsIframe[j].name;
				var inputValue=inputsIframe[j].value.replace("\"", "\\\"");
				//serializzazione della copia nome/parametro								
				//var command ="{"+inputName+":\""+inputValue+"\"}";
				//var serializedCommandItem=eval(command);
				//var serializedItem=JQ.param(serializedCommandItem);
				serializedForm+="&"+inputName+"="+inputValue;				
			}				
		}
	}	

	return serializedForm;	
}

function addEvent(obj, evType, fn){
	if (obj.addEventListener){ 
		  obj.addEventListener(evType, fn, false); 
		  return true; 
	} else if (obj.attachEvent){ 
		  var r = obj.attachEvent("on"+evType, fn); 
		  return r; 
	} else {
		return false; 
	} 	
}


function getAmpersand(pars){
	if (pars!="")
		return "&";
	else
		return "";
}
function getAmpersandOnUrl(url){
	if (url.indexOf('?')==-1)
		return "?";
	else
		return "&";
}

function serializeArray(paramsArray){
	var result="";	
	for (var i=0;i<paramsArray.length;i++) {
		if (i!=0)
			result+="&";		
		result+=paramsArray[i];
	}	
	return result;	
}

function getHTTPHeaderValue(jqXHR, headerName){
	return jqXHR.getResponseHeader(headerName);
}


//Per aprire pop-up formattati
function na_open_window(name, url, left, top, width, height, toolbar, menubar, statusbar, scrollbar, resizable)
{
toolbar_str = toolbar ? 'yes' : 'no';
menubar_str = menubar ? 'yes' : 'no';
statusbar_str = statusbar ? 'yes' : 'no';
scrollbar_str = scrollbar ? 'yes' : 'no';
resizable_str = resizable ? 'yes' : 'no';
window.open(url, name, 'left='+left+',top='+top+',width='+width+',height='+height+',toolbar='+toolbar_str+',menubar='+menubar_str+',status='+statusbar_str+',scrollbars='+scrollbar_str+',resizable='+resizable_str);
}

function na_open_window_fullscreen(name, url, toolbar, menubar, statusbar, scrollbar, resizable, fullscreen)
{
toolbar_str = toolbar ? 'yes' : 'no';
menubar_str = menubar ? 'yes' : 'no';
statusbar_str = statusbar ? 'yes' : 'no';
scrollbar_str = scrollbar ? 'yes' : 'no';
resizable_str = resizable ? 'yes' : 'no';
fullscreen_str = fullscreen ? 'yes' : 'no';
window.open(url, name, 'toolbar='+toolbar_str+',menubar='+menubar_str+',status='+statusbar_str+',scrollbars='+scrollbar_str+',resizable='+resizable_str+',fullscreen='+fullscreen_str);
}

/*
 * This javascript constructs a new url based on the current one appending the breadCrumbBack parameter
 * with the value passed in. If no value is passed then the default value (-1) is used.
 * breadCrumbBack is the parameter intercepted by NavigationFilter to restore parameters associated with that url.
 * 
 * breadCrumbBack MUST BE a negative number. If a positive number is passed in it is inverted 
 */
function navigationBack(breadCrumbBack){
	
	if(!breadCrumbBack){
		breadCrumbBack=-1;
	} else if(breadCrumbBack>=0){
		breadCrumbBack=breadCrumbBack*(-1);
	}
	
	var currentUrl=document.location.href;
	var questionMarkFound=currentUrl.indexOf("?");
	if (questionMarkFound!=-1){
		currentUrl=currentUrl.substring(0, questionMarkFound);
	}
	
	currentUrl+="?breadCrumbBack="+breadCrumbBack;
	
	document.location.href=currentUrl;	
}
function checkModuleCalls(mapToCheck, postHandler) {
	var areAllImageLoaded=true;
	JQ.each(mapToCheck, function(module, value) { 
		areAllImageLoaded=areAllImageLoaded&value;
	});
	if (!areAllImageLoaded) 
		setTimeout(function(){checkModuleCalls(mapToCheck, postHandler);}, 100);
	else {
		if (postHandler)
			postHandler();
		else
			setTimeout("reloadCurrentUrl();",300);
	}		
}

/*wf*/
function wfFormSubmit() {
	JQ('#wfCommandForm').submit();
}
function wfFormSubmitPage(nextPage,successView) {
	JQ('#wfNextPage').val(nextPage);
	JQ('#successPage').val(successView);
	checkAllSelectMovable();
	JQ('#wfCommandForm').submit();
}
function wfFormForward(wfNextState) {
	JQ('#wfNextState').val(wfNextState);
	checkAllSelectMovable();
	wfFormSubmit();
}

function wfDetailSubmitPage(nextPage, successView) {
	JQ('#wfPage').val(nextPage);
	JQ('#successPage').val(successView);
	JQ('#wfCommandForm').submit();
}


var fineMese = new Array();
	fineMese[1]=31;
	fineMese[2]=28;
	fineMese[3]=31;
	fineMese[4]=30;
	fineMese[5]=31;
	fineMese[6]=30;
	fineMese[7]=31;
	fineMese[8]=31;
	fineMese[9]=30;
	fineMese[10]=31;
	fineMese[11]=30;
	fineMese[12]=31;

function addMesiToDate(dateString,mesi) {
	var giorno = Number(dateString.substr(0,2));
	var mese = Number(dateString.substr(3,2));
	var anno = Number(dateString.substr(6,4));
	var incrementoAnno = Math.floor(mesi/12);
	var incrementoMese = mesi-(incrementoAnno*12);
	anno=anno+incrementoAnno;
	mese=mese+incrementoMese;
	if (mese>12) {
		mese-=12;
		anno++;
	}
	
	if (giorno>fineMese[mese]) {
		if (anno%4==0&&mese==2&&giorno>28)
			giorno=29;
		else{
			giorno=fineMese[mese];
		}
	}
	
	var dateFinale = new Date(anno,mese-1,giorno);
	var millisFinale = dateFinale.getTime();
	millisFinale=millisFinale-86400000;
	dateFinale = new Date(millisFinale);
	meseFinale=""+(dateFinale.getMonth()+1);
	giornoFinale=""+dateFinale.getDate();
	annoFinale=""+dateFinale.getFullYear();
	if (meseFinale.length==1)
		meseFinale="0"+meseFinale;
	if (giornoFinale.length==1)
		giornoFinale="0"+giornoFinale;
	return giornoFinale+"/"+meseFinale+"/"+annoFinale;
}


function refreshDataAsSumOfDateAndMounth(inizioId,meseId,fineId) {
	var dataDecorrenza=JQ('#'+inizioId).val();
	var durata=JQ('#'+meseId).val();
	
	if (dataDecorrenza!=""){
		if(durata == "") {
			JQ('#'+fineId).val(dataDecorrenza);
		} else {
			var dataScadenza=addMesiToDate(dataDecorrenza,durata);
			if (dataScadenza.indexOf("NaN")==-1)
				JQ('#'+fineId).val(dataScadenza);
			else {
				JQ('#'+fineId).val('');
			}
		}
	}
}

function refreshDataAsSumOfDateAndYear(inizioId,annoId,fineId) {
	var dataDecorrenza=JQ('#'+inizioId).val();
	var durata=JQ('#'+annoId).val();
	
	if (dataDecorrenza!=""){
		if(durata == "") {
			JQ('#'+fineId).val(dataDecorrenza);
		} else {
			var dataScadenza=addMesiToDate(dataDecorrenza,durata*12);
			if (dataScadenza.indexOf("NaN")==-1)
				JQ('#'+fineId).val(dataScadenza);
			else {
				JQ('#'+fineId).val('');
			}
		}
	}
}



function unformatNumber(text) {
	if (text==null) return null;
	var finale = text;
	finale = finale.replace(/\./g,"");
	finale = finale.replace(/,/g,".");
	return finale;
}


function formatNumber(text) {
	var error = false;
	var msg = "OK";
	var finale = "";
	if  (text!=null && text != '' && text!='undefined') {
		finale = text;
		if ("," == finale || "." == finale)
			finale = "0,";		
		else {
			var minusPresent=false;
			var comaPresent=false;
			if (finale.lastIndexOf(".")==finale.length-1)
				finale=finale.substr(0,finale.length-1)+",";

			finale = unformatNumber(finale);

			if (finale.search(/\./)!=-1)
				comaPresent=true;
				
			if (finale.search(/\-/)!=-1)
				minusPresent=true;
			
			var parteIntera;
			var parteDecimale;
			if (comaPresent) {
				var separatore = finale.search(/\./);
				parteIntera=finale.substring(0,separatore);
				parteDecimale=finale.substring(separatore+1, finale.length);
			}
			else {
				parteIntera=finale;
				parteDecimale="";
			}
			
			if (minusPresent){
				parteIntera=parteIntera.substring(1,parteIntera.length);
			}
			
			//elimino gli zeri iniziali di parte intera (pu� iniziare con zero solo se poi � "0,"
			var controllo=true;
			while(controllo) {
				if (parteIntera.charAt(0)==0&&parteIntera.length!=1)
					parteIntera=parteIntera.substring(1,finale.length);
				else
					controllo=false;
				
			}
		
			finale='';
			if (parteIntera.length<4)
				finale = parteIntera;
			else {
				for (i=parteIntera.length-3;i>0;i=i-3) {
					finale = "."+parteIntera.substr(i,3)+finale;
				}
				if (parteIntera.length%3==0)
					finale = parteIntera.substr(0,3)+finale;
				else
					finale = parteIntera.substr(0,parteIntera.length%3)+finale;
			}
			
			if (comaPresent) {
				if (parteDecimale.length>2) 
					parteDecimale=parteDecimale.substr(0,2);
				finale = finale + "," + parteDecimale;
			}
			
			if (minusPresent){
				finale="-"+finale;
			}
		}
	}
	var ritorno=new Object();
	ritorno.errore=error;
	ritorno.msg=msg;
	ritorno.finale=finale;
	return ritorno;
}	

function confirmExit() {
	if (confirmExitVarPassato){
		if (confirmExitVar) {
			if (confirmExitMessage!=null && confirmExitMessage!="")
				return confirmExitMessage;		
		}
	}
}
function removeConfirmExit() {
	confirmExitVar=false;	
	confirmExitVarPassato=true;
}
function addConfirmExit() {
	confirmExitVar=true;	
	confirmExitVarPassato=false;
}
function submitPost(url,buttonName,buttonValue) {
	var form = JQ('<form method="post" action="'+url+'"></form>');
	form.html('<input type="hidden" name="'+buttonName+'" value="'+buttonValue+'" />');
	form.appendTo(JQ('body')).submit();
}



function openForwardMessageDialogue(nextState) {
	JQ("#forwardMessageNextState").val(nextState);
	JQ("#dialogueForwardMessageDiv").dialog({
		modal: true,
		height: 300,
		width: 500
	});
}

function closeForwardMessageDialogueAndSubmit() {
	closeForwardMessageDialogue();
	var message = JQ("#forwardMessageTextarea").val();
	var nextState = JQ("#forwardMessageNextState").val();

	var input = document.createElement("input");
	input.name = "clobMap[forwardMessage_"+nextState+"]";
	input.id = "clobMap__forwardMessage_"+nextState+"__";
	input.type = "hidden";
	input.value = message;
	document.getElementById('wfCommandForm').appendChild(input);
	
	wfFormForward(nextState);
}

function closeForwardMessageDialogue() {
	JQ("#dialogueForwardMessageDiv").dialog('close');
}


function reloadCurrentUrl(){
	var queryString="";
	var prmstr = window.location.search.substr(1);
	var prmarr = prmstr.split ("&");		

	for ( var i = 0; i < prmarr.length; i++) {			
		if (!prmarr[i].match(/^rand=/)){
			queryString+=prmarr[i]+"&";	
		} else {
			queryString+="rand="+Math.random()+"&";
		}
	}		
	if (!queryString.match(/^\?/))
		queryString="?"+queryString;
	
	queryString=queryString.replace(/&$/, "");
	
	if (!queryString.match(/rand=/))
		queryString+="&rand="+Math.random()	
	
	location.href=window.location.protocol+'//'+window.location.host+window.location.pathname+queryString;		
}

function postAjaxCommandForm(url, nodeId, callback){
	var pars=JQ("#"+nodeId+" *").serialize();
	JQ.ajax({
		url: url,
		data: pars,
		contentType: "application/x-www-form-urlencoded;charset=UTF-8",
		type: "POST",
		success: function(data, textStatus, jqXHR) {
			if (getHTTPHeaderValue(jqXHR,"FragmentError")=="1"){				
				var $modal = jQuery(data);				
	            $modal.filter('.modal').modal();
	            $modal.filter('.modal').on('hidden.bs.modal', function(){
	            	$modal.remove();
				});	            
	            JQ("#editAssigned").html($modal);
	            
			} else {
			    JQ('#editAssigned').modal('hide');
			    JQ('.modal-backdrop').remove();
				callback();
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
			alert("errore");
		}
	});	
}
