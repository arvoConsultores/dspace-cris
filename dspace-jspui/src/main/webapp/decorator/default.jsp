<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
	<% org.springframework.context.i18n.LocaleContextHolder.setLocale(pageContext.getResponse().getLocale()); %>
	<%@ page trimDirectiveWhitespaces="true" %>
	<%session.setMaxInactiveInterval(240 * 60);%>
	<%@ include file="/common/taglib.jsp"%>
    <link rel="shortcut icon"  href="/${SR_MODULE_NAME}/cineca/ico/favicon.ico" />
	<link href="/${SR_MODULE_NAME}/londinium/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="/${SR_MODULE_NAME}/londinium/css/londinium-theme.css" rel="stylesheet" type="text/css">
	<link href="/${SR_MODULE_NAME}/londinium/css/styles.css" rel="stylesheet" type="text/css">
	<link href="/${SR_MODULE_NAME}/londinium/css/icons.css" rel="stylesheet" type="text/css">
	<link href="/${SR_MODULE_NAME}/font-awesome/css/font-awesome.min.css" rel="stylesheet">
	<link href="/${SR_MODULE_NAME}/jstree/themes/default/style.min.css" rel="stylesheet"/>
	
	<link href="/${SR_MODULE_NAME}/cineca/css/cineca.css" rel="stylesheet" type="text/css">
	<c:set var="jqueryCompatibilityMode"><decorator:getProperty property="body.jqueryCompatibilityMode" /></c:set>
	
	<c:set var="pageTitle"><decorator:title/></c:set>
	<c:if test="${empty pageTitle}"><c:set var="pageTitle"><widget:title/></c:set></c:if>
	<c:if test="${fn:contains(pageTitle,'???')}"><% org.slf4j.LoggerFactory.getLogger(this.getClass()).info("etichetta title mancante: "+pageContext.getAttribute("pageTitle")); %><c:set var="pageTitle"><fmt:message key="title.default"/></c:set></c:if>
	<title>${pageTitle}</title>
	<decorator:head/>
	<%@ page import="it.cilea.core.configuration.util.ConfigurationUtil"%>
</head>
<body class="sidebar-wide">
	<!-- Page container -->
	<div class="page-container">
		<!-- Page content -->
		<div class="page-content">
			<p></p>
			<!-- Breadcrumbs line -->
			<!-- /breadcrumbs line -->aaa
			<decorator:body />
			<!-- Footer -->
			<!-- /footer -->
		</div>
		<!-- /page content -->
	</div>
	<!-- /content -->
	
</body>
</html>