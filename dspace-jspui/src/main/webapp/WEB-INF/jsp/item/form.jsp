<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/common/taglib.jsp"%>
<c:set var="commandObject" value="${command}" scope="request"/>
<div class="form-horizontal">

<form action="/jspui/item/form.htm" method="post">
<div class="line form-group">
<input type="hidden" name="itemId" value="${command.ID}"/>
</div>
	<widget:text propertyPath="command.metadataFieldPlaceMap[dc_title_1]" allowMultiple="false"/>
	<widget:text propertyPath="command.metadataFieldPlaceMap[dc_format_medium_1]" allowMultiple="false" labelKey="label.format.medium"/>
	<widget:text propertyPath="command.metadataFieldPlaceMap[dc_title_alternative_1]" allowMultiple="false" labelKey="label.title_alternative"/>
	<widget:text propertyPath="command.metadataFieldPlaceMap[dc_subject_classification]" allowMultiple="true" labelKey="label.subject.classification"/>



<script type="text/javascript">
function removeWidgetMultiple(inputId) {
	$('#'+inputId).val('');
	$('#'+inputId+'_line').hide();
}

function ciao(prefix,url) {
	var lastId=$('.'+prefix+'_').last().attr('id');
	nextId=Number(lastId.replace(prefix,'').replace('__',''))+1;
	$.ajax({
		url: url+'&multipleIndexToShow='+nextId,
		contentType: "application/x-www-form-urlencoded;charset=UTF-8",
		type: "POST",
		success: function(data, textStatus, jqXHR) {
			$('#'+lastId+'_line').after(data);
		},
		error: function(jqXHR, textStatus, errorThrown) {
			alert('error');
		}
	});
	

}
</script>

<div class="form-actions text-right">
			<input type="button" value="<fmt:message key="button.undo"/>" class="btn btn-default" onclick="navigationBack();"/>
			<input type="submit" value="<fmt:message key="button.save"/>" class="btn btn-primary"/>
		</div>
</form>
</div>