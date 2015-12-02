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
	<%@ include file="/common/javascript.jsp"%>
	
	<c:set var="pageTitle"><sitemesh:write property='title'/></c:set>
	<c:if test="${empty pageTitle}"><c:set var="pageTitle"><widget:title/></c:set></c:if>
	<c:if test="${fn:contains(pageTitle,'???')}"><c:set var="pageTitle"><fmt:message key="title.default"/></c:set></c:if>
	<title>${pageTitle}</title>
	<sitemesh:write property='head'/>
</head>
<body class="sidebar-wide">
	<c:set var="showNavButtons" value="${true}" scope="request"/>
	<c:set var="showTopMenu" value="${true}" scope="request"/>
	<c:set var="showBookmark" value="${true}" scope="request"/>
	<c:set var="showLoginAs" value="${true}" scope="request"/>
	<c:set var="showAuthorityList" value="${true}" scope="request"/>
	<c:set var="showMyMenu" value="${true}" scope="request"/>
	<c:set var="showPrint" value="${true}" scope="request"/>
	<c:set var="showNote" value="${true}" scope="request"/>
	<%@ include file="/decorator/include/north.jsp"%>
	<div class="page-container">
		<%@ include file="/decorator/include/west.jsp"%>
		<div class="page-content">
			<%@ include file="/common/breadcrumb.jsp"%>
			<%@ include file="/common/message.jsp" %>
			<sitemesh:write property='body' />
			<%@ include file="/decorator/include/south.jsp"%>
		</div>
	</div>
	<%@ include file="/decorator/include/commonFunction.jsp"%>
</body>
</html>