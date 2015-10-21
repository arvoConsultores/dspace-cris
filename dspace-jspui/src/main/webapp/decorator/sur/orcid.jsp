<%@ include file="/common/taglib.jsp"%>
<%@ page import="it.cilea.core.authorization.service.OrcidHubWorkFlow" %>
<%@ page import="it.cilea.core.configuration.model.OrcidMapping" %>
<%@ page import="it.cilea.core.authorization.service.OrcidHubUtil" %> 
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<% 
WebApplicationContext appCtx = WebApplicationContextUtils.getWebApplicationContext(config.getServletContext());
OrcidHubWorkFlow orcidHubWorkFlow = (OrcidHubWorkFlow)appCtx.getBean("orcidHubWorkFlow");
pageContext.setAttribute("orcidHubWorkFlow", orcidHubWorkFlow);
%>


<% orcidHubWorkFlow.refreshIfNeeded(request); %>
<% if( OrcidHubUtil.showOrcidPopupUserDecision(request)){ %>
	<script type="text/javascript">
		function showOrcidInfo() { 
		 var url = "/${MODULE_NAME}/sur/aboutOrcidModalInfo.modal?refer="+"<%= OrcidHubUtil.referUrlEncoded(request) %>";
		   url = url.replace('//sur','/sur');
		   url = url.replace('/null/sur','/sur');
			jQuery.ajax({
				url: url,
				type: 'GET',
				success: function(data) {
	                var $modal = jQuery(data);
					jQuery('body').append($modal);
	                $modal.filter('.modal').modal();
	                $modal.filter('.modal').on('hidden.bs.modal', function(){
	                $modal.remove();
					});
				}
			});
		}
	$( document ).ready( showOrcidInfo );
	</script> 
	<% } %>	
	<% if( OrcidHubUtil.showOrcidPopupNotification() ){ %>
	<script type="text/javascript">
	$.jGrowl('<%= orcidHubWorkFlow.showOrcidPopupNotificationInfoMsg(request)%>', { 
		header: '<fmt:message key="label.ORCID.popup.header" />',
		sticky: true, 
		<%= OrcidHubUtil.showOrcidPopupNotificationTheme()%>
		beforeOpen: function(e,m,o){
	        $(e).width( $( window ).width()-50+"px");
	   },
	   beforeClose: function(e,m) {
		   var url = "<%= OrcidHubUtil.notificationReadFromUserUrl(request) %>";
		   url = url.replace('//sur','/sur');
		   url = url.replace('/null/sur','/sur');
		   JQ.ajax({
				url: url,
				dataType: "text",		
				contentType: "application/x-www-form-urlencoded;charset=UTF-8",													
			});
	   }
	});
	</script> 
	
	<script type="text/javascript">
	
	  $( document ).ready(function() {
		  
		  setTimeout(refreshorcid, 3000);
		  
		  function refreshorcid(){  
		  
			    $.ajax({
		            url: "<%= OrcidHubUtil.checkStatus() %>",
		            async: true,
		            dataType: 'json',
		            success: function(data) {
		            var action = data.action;
	            	var actionurl = data.url;
	            	var actiontext = data.text;
	            	
	            	if ( (action=='show')  || (action=='show-growl-warning') || (action=='show-growl-success') ) {
		                   
	            	var theme_growl = 'default';
	            	if(action=='show-growl-warning'){
	            		theme_growl = 'growl-warning'
	            	}
	            	if(action=='show-growl-success'){
	            		theme_growl = 'growl-success'
	            	}
	            		
	            		
   		         	$.jGrowl(   actiontext , { 
   		     		header: '<fmt:message key="label.ORCID.popup.header" />',
   		     		sticky: true, 
   		     		theme: theme_growl,
   		     		beforeOpen: function(e,m,o){
   		     	        $(e).width( $( window ).width()-50+"px");
   		     	   	},
   		     	   	beforeClose: function(e,m) {
   		     		   var url = actionurl;
   		     		   url = url.replace('//sur','/sur');
   		     		   url = url.replace('/null/sur','/sur');
   		     		   JQ.ajax({
   		     				url: url,
   		     				dataType: "text",		
   		     				contentType: "application/x-www-form-urlencoded;charset=UTF-8",													
   		     			});
   		     	   	}
   		     		});
   		         	
   		         	
   		         	
   		         	
   		         	
   		         	
   		                
   		                } else {
   		                	
   		                 if (action == 'stop') {
   		                 }else{
   		                	 if (action == 'reschedule') {
   			                    setTimeout(refreshorcid, 5000);	 
   		                	 }
   		                 }

		                }
		            }
		        });
			    
	  }
			
		  });
	
	</script> 
	
	<% } %>	
