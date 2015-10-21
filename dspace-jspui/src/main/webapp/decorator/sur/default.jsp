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
	<%@ page import="it.cilea.core.cookie.CookieUtil"%>
	<%@ page import="it.cilea.core.cookie.COOKIEMapping"%>
    <link rel="shortcut icon"  href="/${SR_MODULE_NAME}/cineca/ico/favicon.ico" />
	<link href="/${SR_MODULE_NAME}/londinium/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="/${SR_MODULE_NAME}/londinium/css/londinium-theme.css" rel="stylesheet" type="text/css">
	<link href="/${SR_MODULE_NAME}/londinium/css/styles.css" rel="stylesheet" type="text/css">
	<link href="/${SR_MODULE_NAME}/londinium/css/icons.css" rel="stylesheet" type="text/css">
	<link href="/${SR_MODULE_NAME}/font-awesome/css/font-awesome.min.css" rel="stylesheet">
	<link href="/${SR_MODULE_NAME}/jstree/themes/default/style.min.css" rel="stylesheet"/>
	
	<link href="/${SR_MODULE_NAME}/cineca/css/cineca.css" rel="stylesheet" type="text/css">
	<c:set var="jqueryCompatibilityMode"><decorator:getProperty property="body.jqueryCompatibilityMode" /></c:set>
	<%@ include file="/common/javascript.jsp"%>
	
	<c:set var="pageTitle"><decorator:title/></c:set>
	<c:if test="${empty pageTitle}"><c:set var="pageTitle"><widget:title/></c:set></c:if>
	<c:if test="${fn:contains(pageTitle,'???')}"><% org.slf4j.LoggerFactory.getLogger(this.getClass()).info("etichetta title mancante: "+pageContext.getAttribute("pageTitle")); %><c:set var="pageTitle"><fmt:message key="title.default"/></c:set></c:if>
	<title>${pageTitle}</title>
	<decorator:head/>
	<%@ page import="it.cilea.core.configuration.util.ConfigurationUtil"%>
	<% if (!("1".equals(ConfigurationUtil.getConfigValue("it.cilea.core.cookie.service.disabled")))) { %>
	<% if (!CookieUtil.isReadAndConfirm(request,response )){ %>
	<script type="text/javascript">
	$.jGrowl('<fmt:message key="label.iris.cookie.info2" />', { 
		header: '<fmt:message key="label.iris.cookie.info" />',
		sticky: true, 
		position: 'bottom-right' ,
		beforeOpen: function(e,m,o){
	        $(e).width( $( window ).width()-50+"px");
	   },
	   beforeClose: function(e,m) {
		   var url = "/${MODULE_NAME}/authorization/changeCookieUserSettings.htm?type=readAndConfirm&value=1";
		   url = url.replace('//sur','/sur');
		   url = url.replace('/null/sur','/sur');
		   JQ.ajax({
				url: url,
				dataType: "text",		
				contentType: "application/x-www-form-urlencoded;charset=UTF-8",													
			});
	   }
	});
	</script> 
	<% } %>
	<% } %>
	<%@ include file="/decorator/include/orcid.jsp"%>	
</head>
<body class="sidebar-wide">
	<!-- Navbar -->
	<c:set var="showNavButtons" value="${true}" scope="request"/>
	<c:set var="showTopMenu" value="${true}" scope="request"/>
	<c:set var="showBookmark" value="${true}" scope="request"/>
	<c:set var="showLoginAs" value="${true}" scope="request"/>
	<c:set var="showAuthorityList" value="${true}" scope="request"/>
	<c:set var="showMyMenu" value="${true}" scope="request"/>
	<%--
	<c:set var="showPrint" value="${true}" scope="request"/>
	<c:set var="showNote" value="${true}" scope="request"/>
	--%>
	<%@ include file="/decorator/include/north.jsp"%>
	<!-- /navbar -->
	<!-- Page container -->
	<div class="page-container">
		<!-- Sidebar -->
		<%@ include file="/decorator/include/west.jsp"%>
		<!-- /sidebar -->
		<!-- Page content -->
		<div class="page-content">
			<p></p>
			<!-- Breadcrumbs line -->
			<%@ include file="/common/breadcrumb.jsp"%>
			<%@ include file="/common/message.jsp" %>
			<!-- /breadcrumbs line -->
			<decorator:body />
			<!-- Footer -->
			<%@ include file="/decorator/include/south.jsp"%>
			<!-- /footer -->
		</div>
		<!-- /page content -->
	</div>
	<!-- /content -->
	<%@ include file="/decorator/include/alive.jsp"%>
	
	<%@ include file="/decorator/include/commonFunction.jsp"%>
	
</body>
</html>