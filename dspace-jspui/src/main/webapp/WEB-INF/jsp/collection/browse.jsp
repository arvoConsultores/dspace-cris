<%@ include file="/common/taglib.jsp"%>
<div class="form-horizontal">
<display:table list="${collections}" class="jtable" cellspacing="0" cellpadding="0" id="collection">
	<display:column property="ID" style="width: 30%;"/>
	<display:column property="metadataFieldPlaceMap.dc_title_1" titleKey="label.title" style="width: 60%;"/>
	<display:column titleKey="label.operations" style="width: 10%;">
		<a href="<c:url value="/collection/get.htm?collectionId=${collection.ID}"/>">
			<i class="fa fa-search-plus" title="<fmt:message key="prompt.detail"/>"  style="cursor:pointer"></i>&nbsp;&nbsp;
		</a>
		<a href="<c:url value="/item/collection/list.htm?collectionId=${collection.ID}"/>">
			<i class="fa fa-list" title="<fmt:message key="prompt.item.list"/>"  style="cursor:pointer"></i>&nbsp;&nbsp;
		</a>
	</display:column>
</display:table>
</div>