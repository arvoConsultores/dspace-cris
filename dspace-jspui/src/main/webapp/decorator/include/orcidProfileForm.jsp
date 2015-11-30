<%@ include file="/common/taglib.jsp"%>
<%@ page import="org.springframework.context.ApplicationContext,org.springframework.web.servlet.support.RequestContextUtils"%>
<%@ page import="it.cilea.core.authorization.service.OrcidHubWorkFlow" %>
<%@ page import="it.cilea.core.configuration.model.OrcidMapping" %>
<%@ page import="it.cilea.core.authorization.service.OrcidHubUtil" %>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
	
	<% 
	WebApplicationContext appCtx = WebApplicationContextUtils.getWebApplicationContext(config.getServletContext());
	OrcidHubWorkFlow orcidHubWorkFlow = (OrcidHubWorkFlow)appCtx.getBean("orcidHubWorkFlow");
	pageContext.setAttribute("orcidHubWorkFlow", orcidHubWorkFlow);
		
	if( orcidHubWorkFlow.showOrcidPopupUserDecisionProfileRm(request)){
	
	String orcidWf = orcidHubWorkFlow.showOrcidPopupUserDecisionInfoMsgProfileRm(request); 
	pageContext.setAttribute("orcidWf", orcidWf);
	
	String orcidWfForceNoToken = orcidHubWorkFlow.showOPopUserDecInfoMsgProfRmForceHubNoToken(request); 
	pageContext.setAttribute("orcidWfForceHubNoToken", orcidWfForceNoToken);
	
	String orcidWfForceToken = orcidHubWorkFlow.showOPopUserDecInfoMsgProfRmForceHubToken(request); 
	pageContext.setAttribute("orcidWfForceHubToken", orcidWfForceToken);
	

	%>
	
	<widget:textCore modeType="display" inputValue="${orcidWf}" />
										 		
	<c:if test="${ command.stringMap['ORCID'] != null}">	
	
	<p class="form-control-static">
	<spring:message code="label.ORCID.popup.msgOrcidUserDecisionInfoMsgProfileRmAuthInfo" />
	
	<c:if test="${ command.stringMap['ORCID_ACCESS_TOKEN'] == null }">
	
		<b><spring:message code="label.no" /></b>
	
		<c:if test="${ command.stringMap['ORCID_APPS'] != null }">
		<br /><spring:message code="label.ORCID.popup.msgOrcidUserDecisionInfoMsgProfileRmForceTokenAuthAppList" />: 
		${command.stringMap['ORCID_APPS']}
		</c:if>
		
		<widget:textCore modeType="display" inputValue="${orcidWfForceHubNoToken}" />
		
	</c:if>		
	
	<c:if test="${ command.stringMap['ORCID_ACCESS_TOKEN'] != null }">
	
		<b><spring:message code="label.yes" /></b>
	
		<c:if test="${ command.stringMap['ORCID_APPS'] != null }">
		<br /><spring:message code="label.ORCID.popup.msgOrcidUserDecisionInfoMsgProfileRmForceTokenAuthAppList" />: 
		${command.stringMap['ORCID_APPS']}
		</c:if>
		
		<widget:textCore modeType="display" inputValue="${orcidWfForceHubToken}" />
	
	</c:if>
	</p>
	<widget:textCore modeType="display" inputValue="${orcidWfForceHub}" />
	
	
	</c:if>
	
<% } %> 