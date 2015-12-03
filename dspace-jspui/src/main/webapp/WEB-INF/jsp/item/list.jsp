<%@ include file="/common/taglib.jsp"%>
<title><widget:title titleKey="title.item.search"/></title>

<div class="form-horizontal">
	<display:table name="iterator" cellspacing="0" cellpadding="0" requestURI="" class="jtable" export="true" id="item">
		<display:column property="ID" titleKey="label.id" sortable="true" style="width:20%;" sortProperty="item.ID"/>		
		<display:column property="metadataFieldPlaceMap.dc_title_1" style="width:70%;" titleKey="label.title"/>		
		<display:column titleKey="label.operations" sortable="false" style="width:10%;" media="html">
			<a href="<c:url value="/item/form.htm?itemId=${item.ID}"/>">
				<i class="fa fa-pencil" title="<fmt:message key="prompt.edit"/>"  style="cursor:pointer"></i>&nbsp;&nbsp;
			</a>
			<a href="<c:url value="/item/get.htm?itemId=${item.ID}"/>">
				<i class="fa fa-search-plus" title="<fmt:message key="prompt.detail"/>"  style="cursor:pointer"></i>&nbsp;&nbsp;
			</a>
		</display:column>
	</display:table>
</div>
