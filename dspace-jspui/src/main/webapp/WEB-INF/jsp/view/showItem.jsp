<%@ include file="/common/taglib.jsp"%>
<c:set var="currentViewBuilder" value="${view:get(cinecaRealViewName)}"/>
<c:set var="commandObject" value="${command}" scope="request" />
<c:set var="modeType" value="display" scope="request"/>
<title><fmt:message key="${currentViewBuilder.titleKey}"/></title>
<div class="page-header"><div class="page-title"><h3><fmt:message key="${currentViewBuilder.titleKey}"/></h3></div></div>
<div class="form-horizontal">
	<c:forEach items="${command.metadataMap['12']}" var="aaa">
		${aaa }
	</c:forEach>
	
<%--
	<view:viewBuilder identifier="${cinecaRealViewName}"/>
	 --%>
</div>