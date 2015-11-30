<%@ include file="/common/taglib.jsp"%>
<div class="clearfix">
	<p>&nbsp;</p><p>&nbsp;</p>
</div>
<div class="footer clearfix">
	<div class="pull-left">
		<fmt:message key="layout.south.left"/>
	</div>
	<div class="pull-right icons-group">
		<i18n:message key="layout.south.right"/>
		<fmt:formatDate var="currentYear" value="<%=new java.util.Date()%>" pattern="yyyy"/>
		<fmt:message key="layout.south.right.date" var="southMessage"/>
		${fn:replace(southMessage,'{0}',currentYear)}
	</div>
</div>