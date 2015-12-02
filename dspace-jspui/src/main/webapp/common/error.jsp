<%@ include file="/common/taglib.jsp"%>
<spring:bind path="command.*">
	<c:if test="${not empty status.errorMessages}">
		<spring:bind path="command">
			<c:set var="errorMessage"><fmt:message key="prompt.error" /></c:set>
			<widget:errorLine errorMessage="${errorMessage}" errorMessages="${status.errorMessages}"/>
			<c:if test="${config:value('notification_jgrowl_active')}">
				<script type="text/javascript">
					JQ(document).ready(function() {
						jGrowlTheme('mono', '<b><fmt:message key="title.jgrowl.error" /></b>', '<fmt:message key="prompt.error" />', '${signWarningImg}');
					});
				</script>
			</c:if>
		</spring:bind>
	</c:if>
</spring:bind>
