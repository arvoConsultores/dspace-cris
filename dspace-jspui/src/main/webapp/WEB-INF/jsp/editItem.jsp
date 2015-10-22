<%@ include file="/common/taglib.jsp"%>

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

<input type="text" name="metadataFieldPlaceMap[dc_title][1]" value="ciao"/>
<br/>
<input type="text" name="metadataFieldPlaceMap[dc_title][2]" value="ciao2"/>
<br/>


<input type="submit" value="submit" name="submit"/>
</form>