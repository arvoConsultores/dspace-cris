<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Profile updated message
  -
  -   password.updated - a Boolean indicating whether the user updated their
  -                      password.
  --%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"
    prefix="fmt" %>

<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page import="org.dspace.eperson.EPerson" %>

<dspace:layout titlekey="jsp.revisionRequest.title">
    <%-- <h1>Profile Updated</h1> --%>
	<h1><fmt:message key="jsp.revisionRequest.mail.send.title"/></h1>
 
	<p class="alert alert-info">

    <fmt:message key="jsp.revisionRequest.mail.send"/>

    </p>

    <%-- <p><a href="<%= request.getContextPath() %>/">Return to DSpace Home</a></p> --%>
	<p><a href="<%= request.getContextPath() %>/"><fmt:message key="jsp.register.general.return-home"/></a></p>
</dspace:layout>
