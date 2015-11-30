<%@ include file="/common/taglib.jsp"%>
<spring:bind path="command.*">
	<c:if test="${not empty status.errorMessages}">
		<c:set var="errorMessage"><fmt:message key="prompt.error" /></c:set>
		<widget:errorLine errorMessage="${errorMessage}" errorMessages="${status.errorMessages}"/>
	</c:if>
</spring:bind>
