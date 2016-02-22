<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Profile editing page
  -
  - Attributes to pass in:
  -
  -   eperson          - the EPerson who's editing their profile
  -   missing.fields   - if a Boolean true, the user hasn't entered enough
  -                      information on the form during a previous attempt
  -   password.problem - if a Boolean true, there's a problem with password
  --%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"
    prefix="fmt" %>
    

<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>

<%@ page import="org.dspace.eperson.EPerson, org.dspace.core.ConfigurationManager" %>
<%@ page import="org.dspace.core.Utils" %>

<%
    EPerson eperson = (EPerson) request.getAttribute("eperson");

	boolean email=false;

	boolean missingFields = (request.getAttribute("missing.fields") != null && ((Boolean)request.getAttribute("missing.fields")).booleanValue());
    boolean mailIncorrecto = (request.getAttribute("mail.incorrecto") != null && ((Boolean)request.getAttribute("mail.incorrecto")).booleanValue());
    boolean mailProhibido = (request.getAttribute("mail.prohibido") != null && ((Boolean)request.getAttribute("mail.prohibido")).booleanValue());

    //attr = (Boolean) request.getAttribute("email.problem");
    String handle=request.getParameter("handle");
%>

<dspace:layout style="submission" titlekey="jsp.juicioRequest.title" nocache="true">

    <%-- <h1>Edit Your Profile</h1> --%>
	<h1><fmt:message key="jsp.juicioRequest.title"/>
	<!--<dspace:popup page="<%= LocaleSupport.getLocalizedMessage(pageContext, \"help.index\") + \"#editprofile\"%>"><fmt:message key="jsp.morehelp"/></dspace:popup>-->
	</h1>
    
<%
    if (missingFields)
    {
%>
    <%-- <p><strong>Please fill out all of the required fields.</strong></p> --%>
	<p class="alert alert-info"><fmt:message key="jsp.juicioRequest.missing.email"/></p>
<%
    }

    if (mailIncorrecto)
    {
%>
    <%-- <p><strong>The passwords you enter below must match, and need to be at
    least 6 characters long.</strong></p> --%>
	<p class="alert alert-warning"><fmt:message key="jsp.juicioRequest.error.email"/></p>
<%
    }

    if (mailProhibido)
    {
%>
    <%-- <p><strong>The passwords you enter below must match, and need to be at
    least 6 characters long.</strong></p> --%>
	<p class="alert alert-warning"><fmt:message key="jsp.juicioRequest.forbiden.email"/></p>
<%
    }
%>

	<div class="alert alert-info"><fmt:message key="jsp.juicioRequest.info3"/></div>
    
    <form class="form-horizontal" action="<%= request.getContextPath() %>/juzgarRequest" method="post">
		<input type="hidden" name="handle" value="<%= handle%>" />
       

        <%-- <p><strong>Optionally</strong>, you can choose a new password and enter it into the box below, and confirm it by typing it
        again into the second box for verification.  It should be at least six characters long.</p> --%>
		<p class="alert"><fmt:message key="jsp.juicioRequest.info5"/></p>
			<div class="form-group">
			<%-- <td align="right" class="standard"><label for="tpassword"><strong>New Password:</strong></label></td> --%>
			<label class="col-md-offset-3 col-md-2 control-label" for="email"><fmt:message
					key="jsp.juicioRequest.email.field" /></label>
			<div class="col-md-3">
				<input class="form-control" type="text" name="email" id="email" />
			</div>
		</div>

	<div class="col-md-offset-5">
       <%-- <p align="center"><input type="submit" name="submit" value="Update Profile"></p> --%>
	   <input class="btn btn-success col-md-4" type="submit" name="submit" value="<fmt:message key="jsp.revisionRequest.request.button"/>" />
	 </div>
    </form>
</dspace:layout>
