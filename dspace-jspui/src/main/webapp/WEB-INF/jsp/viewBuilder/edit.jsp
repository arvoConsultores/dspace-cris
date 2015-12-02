<%@ include file="/common/taglib.jsp"%>
<c:set var="currentViewBuilder" value="${view:get(cinecaRealViewName)}"/>
<c:set var="commandObject" value="${command}" scope="request" />
<c:url value="${actionUrl}" var="actionUrl"/>
<title><fmt:message key="${currentViewBuilder.titleKey}"/></title>
<div class="page-header"><div class="page-title"><h3><fmt:message key="${currentViewBuilder.titleKey}"/></h3></div></div>
<div class="form-horizontal">
	<spring:bind path="command.*">
		<c:if test="${not empty status.errorMessages}">
			<spring:bind path="command">
				<c:set var="errorMessage"><fmt:message key="prompt.error" /></c:set>
				<widget:errorLine errorMessage="${errorMessage}" errorMessages="${status.errorMessages}"/>
				<c:if test="${config:value('notification_jgrowl_active')}">
					<script type="text/javascript">
						JQ(document).ready(function() {
							jGrowlTheme('mono', '<b>SURplus</b>', '<fmt:message key="prompt.error" />', '${signWarningImg}');
						});
					</script>
				</c:if>
			</spring:bind>
		</c:if>
	</spring:bind>
	<form:form action="${actionUrl}">
		<input type="hidden" name="_form" value="1">
		<view:viewBuilder identifier="${cinecaRealViewName}"/>
		<div class="form-actions text-right">
			<input type="button" value="<fmt:message key="button.undo"/>" class="btn btn-default" onclick="navigationBack();"/>
			<input type="submit" value="<fmt:message key="button.save"/>" class="btn btn-primary"/>
		</div>
	</form:form>
<script type="text/javascript">
function removeWidgetMultiple(inputId) {
	$('#'+inputId).val('');
	$('#'+inputId+'_line').hide();
}
</script>
</div>