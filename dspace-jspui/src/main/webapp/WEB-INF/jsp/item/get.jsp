<%@ include file="/common/taglib.jsp"%>
<c:set var="commandObject" value="${command}" scope="request"/>
<c:set var="modeType" value="display" scope="request"/>
<div class="form-horizontal">
	<widget:text propertyPath="command.metadataFieldPlaceMap[dc_title_1]" allowMultiple="false"/>
	<widget:text propertyPath="command.metadataFieldPlaceMap[dc_format_medium_1]" allowMultiple="false" labelKey="label.format.medium"/>
	<widget:text propertyPath="command.metadataFieldPlaceMap[dc_title_alternative_1]" allowMultiple="false" labelKey="label.title_alternative"/>
	<widget:text propertyPath="command.metadataFieldPlaceMap[dc_subject_classification]" allowMultiple="true" labelKey="label.subject.classification"/>
	<widget:text propertyPath="command.metadataFieldPlaceMap[dc_type]" allowMultiple="false" labelKey="label.type"/>
</div>
