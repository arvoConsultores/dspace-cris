<%@ include file="/common/taglib.jsp"%>
<c:set var="commandObject" value="${command}" scope="request"/>

<form action="/jspui/item/form.htm" method="post">
<input type="text" name="itemId" value="${command.ID}"/>
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


<widget:text propertyPath="command.metadataFieldPlaceMap[dc_identifier_issn]['1']"/>


<input type="submit" value="submit" name="submit"/>
</form>