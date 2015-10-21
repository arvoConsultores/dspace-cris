<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglib.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="org.dspace.app.webui.util.JSPManager" %>
<%@ page import="org.dspace.core.ConfigurationManager" %>
<%@ page import="org.dspace.app.util.Util" %>
<%@ page import="javax.servlet.jsp.jstl.core.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
         <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="<%= request.getContextPath() %>/favicon.ico" type="image/x-icon"/>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/static/css/jquery-ui-1.10.3.custom/redmond/jquery-ui-1.10.3.custom.css" type="text/css" />
        <link rel="stylesheet" href="<%= request.getContextPath() %>/static/css/bootstrap/bootstrap.min.css" type="text/css" />
        <link rel="stylesheet" href="<%= request.getContextPath() %>/static/css/bootstrap/bootstrap-theme.min.css" type="text/css" />
        <link rel="stylesheet" href="<%= request.getContextPath() %>/static/css/bootstrap/dspace-theme.css" type="text/css" />
        <script type='text/javascript' src="<%= request.getContextPath() %>/static/js/jquery/jquery-1.10.2.min.js"></script>
        <script type='text/javascript' src='<%= request.getContextPath() %>/static/js/jquery/jquery-ui-1.10.3.custom.min.js'></script>
        <script type='text/javascript' src='<%= request.getContextPath() %>/static/js/bootstrap/bootstrap.min.js'></script>
        <script type='text/javascript' src='<%= request.getContextPath() %>/static/js/holder.js'></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/utils.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/static/js/choice-support.js"> </script>
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="<%= request.getContextPath() %>/static/js/html5shiv.js"></script>
  <script src="<%= request.getContextPath() %>/static/js/respond.min.js"></script>
<![endif]-->
	<decorator:head/>
    </head>
    
    
    
    
    <%-- HACK: leftmargin, topmargin: for non-CSS compliant Microsoft IE browser --%>
    <%-- HACK: marginwidth, marginheight: for non-CSS compliant Netscape browser --%>
    <body class="undernavigation">
		<a class="sr-only" href="#content">Skip navigation</a>
		<header class="navbar navbar-inverse navbar-fixed-top">    
		</header>
		<main id="content" role="main">
		
			<decorator:body/>
		</main>	
		
		   <%-- Page footer --%>
            <footer class="navbar navbar-inverse navbar-bottom">
            <div id="designedby" class="container text-muted">
            <fmt:message key="jsp.layout.footer-default.theme-by"/> <a href="http://www.cineca.it"><img
                                   src="<%= request.getContextPath() %>/image/logo-cineca-small.png"
                                   alt="Logo CINECA" /></a>
		<div id="footer_feedback" class="pull-right">                                    
                               <p class="text-muted"><fmt:message key="jsp.layout.footer-default.text"/>&nbsp;-
                               <a target="_blank" href="<%= request.getContextPath() %>/feedback"><fmt:message key="jsp.layout.footer-default.feedback"/></a>
                               <a href="<%= request.getContextPath() %>/htmlmap"></a></p>
                               </div>
		</div>
   </footer>
</body>
    
    
</html>
<%--
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
--%>