<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/common/taglib.jsp"%>
<cineca-authz:authentication property="principal" var="userDetail"/>

<c:choose>
	<c:when test="${not empty userDetail}">
		<script type="text/javascript">
			var authenticatedPersonId="${userDetail.personId}";
			var authenticatedUser=true;
		</script>
	</c:when>
	<c:otherwise>
		<script type="text/javascript">
			var authenticatedPersonId="";
			var authenticatedUser=false;
		</script>
	</c:otherwise>
</c:choose>
		
<script type="text/javascript">
	var forceLoginModuleArray = [${RELOAD_MODULE_LIST}];			
	var forceLogindModuleMap=new Object();
	$.each(forceLoginModuleArray, function(index, value) {				
		forceLogindModuleMap[value]=false;
	});		

	window.setInterval(function(){
		$.each(forceLogindModuleMap, function(module, value) {
			var url="/"+module+"/alive.json";
			url+='?rnd='+Math.random(9999);
			JQ.ajax({
				url: url,
				type: 'GET',
				dataType: 'json',
				success: function(data) {
				}
			});
		});
	}, 1200000);

	function disableUserInteraction() {
		$('body').append('<div class="overlay"><div class="opacity"></div><i class="icon-spinner2 spin"></i></div>');
		$('.overlay').fadeIn(150);
	}
	
	function enableUserInteraction() {
		initializeProfileImages();
		$('.overlay').remove();
		$.cookie("iris-inter-module-login", "true", { path: "/" });
	}
	
	$(function() {		 
		if(!$.cookie("iris-inter-module-login") && authenticatedUser){
			disableUserInteraction();				
			$.each(forceLogindModuleMap, function(module, value) {
				var img = new Image();
			    img.src = (module.match("^/")?"":"/") + module + "/img/pixel_for_cas_login.gif?random="+Math.random();
			    img.onload = (function(){
			    	forceLogindModuleMap[module]=true;
	            });					
			    img.onerror = (function(){
			    	//alert(module + " NOT loaded");
	            });
			});
			checkModuleCalls(forceLogindModuleMap, enableUserInteraction);
			window.setTimeout("enableUserInteraction()",10000);
		}
	});
</script>