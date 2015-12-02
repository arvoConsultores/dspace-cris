<%@ include file="/common/taglib.jsp"%>
<%@ include file="/common/taglib.jsp"%>
<c:set var="commandObject" value="${command}" scope="request"/>
<c:set var="modeType" value="display" scope="request"/>
<div class="form-horizontal">
	<widget:text propertyPath="command.metadataFieldPlaceMap[dc_title_1]" allowMultiple="false"/>
	<widget:text propertyPath="command.metadataFieldPlaceMap[dc_identifier_issn]" allowMultiple="true"/>
	<widget:text propertyPath="command.metadataFieldPlaceMap[dc_subject_other]" allowMultiple="true"/>
</div>
<%--
<dspace:item item="${command}"  style="default" />
--%>