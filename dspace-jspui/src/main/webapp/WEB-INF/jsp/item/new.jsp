<%@ include file="/common/taglib.jsp"%>
<c:set var="commandObject" value="${command}" scope="request"/>
<div class="form-horizontal">
<form action="/jspui/item/new.htm" method="post">
	<c:set var="labelHtml"><widget:label labelKey="label.collection"/></c:set>
	<c:set var="contentHtml"><widget:selectCore inputName="collectionId" collection="${collectionList}" modeType="enabled"/></c:set>
	<widget:line content="${contentHtml}" label="${labelHtml}" inputId="collectionId"/>
	<div class="form-actions text-right">
		<input type="button" value="<fmt:message key="button.undo"/>" class="btn btn-default" onclick="navigationBack();"/>
		<input type="submit" value="<fmt:message key="button.save"/>" class="btn btn-primary"/>
	</div>
</form>
</div>