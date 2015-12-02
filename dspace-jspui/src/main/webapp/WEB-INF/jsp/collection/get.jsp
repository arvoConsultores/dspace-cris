<%@ include file="/common/taglib.jsp"%>
<c:set var="commandObject" value="${command}" scope="request"/>
<c:set var="modeType" value="display" scope="request"/>
<div class="form-horizontal">
	<widget:text propertyPath="command.metadataFieldPlaceMap[dc_title_1]" allowMultiple="false"/>
</div>