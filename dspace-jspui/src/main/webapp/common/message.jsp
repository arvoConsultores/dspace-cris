<%@ include file="/common/taglib.jsp"%>
<div class="row">
<c:if test="${not empty errors}"><%-- Error Messages --%>
	<widget:errorLine errorMessages="${errors}"/>
	<c:if test="${config:value('notification_jgrowl_active')}">
		<script type="text/javascript">
			JQ(document).ready(function() {
				jGrowlTheme('mono', '<b>Surplus</b>', '<fmt:message key="prompt.error" />', '${signWarningImg}');
			});
		</script>
	</c:if>
	<c:remove var="errors"/>
</c:if>
<c:if test="${not empty messages}"><%-- Success Messages --%>
	<widget:infoLine infoMessages="${messages}"/>
	<c:if test="${config:value('notification_jgrowl_active')}">
		<!-- growl -->
		<script type="text/javascript">
			JQ(document).ready(function() {
			<c:forEach items="${messages}" var="infoMessage">
				jGrowlTheme('mono', '<b>Surplus</b>', '${infoMessage}', '${checkImg}');
			</c:forEach>
			});
		</script>
	</c:if>
	<c:remove var="messages" scope="session"/>
</c:if>
</div>