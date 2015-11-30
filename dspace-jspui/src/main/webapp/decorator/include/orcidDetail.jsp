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
	%>
	
	<% 
	if( orcidHubWorkFlow.showOrcidPopupUserDecisionProfileRm(request)){ %>
	<% String orcidWf = orcidHubWorkFlow.showOrcidPopupUserDecisionInfoMsgProfileRm(request); 
	pageContext.setAttribute("orcidWf", orcidWf);
	%>
	<widget:textCore modeType="display" inputValue="${orcidWf}" />
	
	<c:if test="${ command.stringMap['ORCID'] != null}">	
	<spring:message code="label.ORCID.popup.msgOrcidUserDecisionInfoMsgProfileRmAuthInfo" />
	<c:if test="${ command.stringMap['ORCID_ACCESS_TOKEN'] == null }">
	<b><spring:message code="label.no" /></b>
	</c:if>		
	<c:if test="${ command.stringMap['ORCID_ACCESS_TOKEN'] != null }">
	<b><spring:message code="label.yes" /></b>
	</c:if>
	</c:if>
	
	<% } %> 