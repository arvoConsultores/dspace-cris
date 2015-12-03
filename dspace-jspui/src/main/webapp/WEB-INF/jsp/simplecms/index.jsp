<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://displaytag.sf.net/el" prefix="display-el" %>


<head>
</head>

<body>

<!--  SE l'utente può scrivere la risorsa "directory del theme" -->
<!--  Tag auth:autorize -->
<form method="POST" enctype="multipart/form-data" action="index.htm">
	<input type="file" name="file" class="btn btn-primary" > 
	<input type="submit" class="btn btn-primary" value="<fmt:message key='button.upload'/>"><fmt:message key='label.uploadDisclaimer'/>
</form>

<display-el:table name="files" cellspacing="0" cellpadding="0" id="f" class="jtable" requestURI="">
	<display-el:column sortable="false" titleKey="label.fileName" >
		<c:if test="${f.directory}">
			<a href="${f.fileName}/index.htm">
				<span>${f.fileName}</span>
			</a>
		</c:if>
		<c:if test="${! f.directory }">
			<span>${f.fileName}</span>
		</c:if>
	</display-el:column>
	<display-el:column sortable="false" titleKey="label.fileSize" >
		<span>${f.fileSize}</span>
	</display-el:column>
	<display-el:column sortable="false" titleKey="prompt.delete" style="width: 10%;">
		<c:if test="${! f.directory }">
			<form method="POST" enctype="multipart/form-data" action="delete.htm?_form=1" >
				<input type="hidden" name="file" value="${f.fileName}" />
				<input type="submit" value="<fmt:message key='prompt.delete'/>" class="btn btn-primary"/>
			</form>
		</c:if>
	</display-el:column>
</display-el:table>

</body>
