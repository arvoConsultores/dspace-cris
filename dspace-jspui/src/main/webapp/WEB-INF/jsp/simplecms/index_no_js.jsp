<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://displaytag.sf.net/el" prefix="display-el" %>


<head>
	<% /*
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" />
	 */ %>
</head>

<body>

<!--  SE l'utente può scrivere la risorsa "directory del theme" -->
<!--  Tag auth:autorize -->
<form method="POST" enctype="multipart/form-data" action="index.htm">
	<input type="file" name="file" class="btn btn-primary" > 
	<input type="submit" class="btn btn-primary" value="<fmt:message key='button.upload'/>"><fmt:message key='label.uploadDisclaimer'/>
</form>

<display-el:table name="files" cellspacing="0" cellpadding="0" id="f" class="jtable" requestURI="">
	<display-el:column sortable="false" titleKey="label.fileName" >${f.fileName}</display-el:column>
	<display-el:column sortable="false" titleKey="prompt.delete" style="width: 10%;">
		<form method="POST" enctype="multipart/form-data" action="delete.htm?_form=1" >
			<input type="hidden" name="file" value="${f.fileName}" />
			<input type="submit" value="<fmt:message key='prompt.delete'/>" class="btn btn-primary"/>
		</form>
	</display-el:column>
</display-el:table>

</body>
