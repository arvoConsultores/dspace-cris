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
</script>