<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/common/taglib.jsp"%>
<c:set var="commandObject" value="${command}" scope="request"/>
<div class="form-horizontal">

<form action="/jspui/item/form.htm" method="post">
<div class="line form-group">
<input type="hidden" name="itemId" value="${command.ID}"/>
</div>
<%--
<br/>
<input type="text" name="metadataFieldPlaceMap[dc_identifier_uri][1]" value="${command.metadataFieldPlaceMap['dc_identifier_uri']['1']}"/>
<br/>
<br/>
<input type="text" name="metadataFieldPlaceMap[dc_description_provenance][2]" value="${command.metadataFieldPlaceMap['dc_description_provenance']['2']}"/>
<br/>
<input type="text" name="metadataFieldPlaceMap[dc_description_provenance][3]" value="${command.metadataFieldPlaceMap['dc_description_provenance']['3']}"/>
<br/>

<input type="text" name="metadataFieldPlaceMap[dc_title][1]" value="${command.metadataFieldPlaceMap['dc_title']['1']}"/>
<br/>
<input type="text" name="metadataFieldPlaceMap[dc_title][2]" value="${command.metadataFieldPlaceMap['dc_title']['2']}"/>
<br/>

--%>
<widget:text propertyPath="command.metadataFieldPlaceMap[dc_identifier_issn]" allowMultiple="true"/>
<widget:text propertyPath="command.metadataFieldPlaceMap[dc_subject_other]" allowMultiple="true"/>
<%--
<widget:text propertyPath="command.metadataFieldPlaceMap[dc_identifier_issn_2]"/>
	
	command.metadataFieldPlaceMap[dc_identifier_issn]
	<spring:bind path="command.metadataFieldPlaceMap">
		<c:set var="mappa" value="${status.value}" scope="request"/>
	</spring:bind>
	
	<%
	java.util.Map<String,Object> mappa=(java.util.Map<String,Object>)request.getAttribute("mappa");
	java.util.Map<String,Object> newMap = mappa.getClass().newInstance();
	String discriminator="dc_identifier_issn";
	for (String string : mappa.keySet()) {
		if (StringUtils.startsWith(string, discriminator + "_")
				&& StringUtils.containsNone(StringUtils.substringAfter(string, discriminator + "_"), "_")) 
			newMap.put(string, mappa.get(string));
	}
	request.setAttribute("newpMap",newMap);
	%>
	
	
	<c:forEach items="${newpMap}" var="single">
		<widget:text propertyPath="command.metadataFieldPlaceMap[${single.key}]"/>
	</c:forEach>


 --%>
<div class="form-actions text-right">
			<input type="button" value="<fmt:message key="button.undo"/>" class="btn btn-default" onclick="navigationBack();"/>
			<input type="submit" value="<fmt:message key="button.save"/>" class="btn btn-primary"/>
		</div>
</form>
</div>