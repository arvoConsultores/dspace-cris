<%@ include file="/common/taglib.jsp"%>
<div class="breadcrumb-line">
	<form name="breadCrumbsForm" id="breadCrumbsForm" method="post">
		<ul class="breadcrumb">
		<c:forEach items="${hashBreadCrumbList}" var="breadCrumb">
			<li><c:if test="${breadCrumb.method=='POST'}">
					<c:set var="action">onclick="javascript:invia('<c:url
							value="${breadCrumb.url}?breadCrumbId=${breadCrumb.position}&${breadCrumb.queryString}" />')"</c:set>
				</c:if> <c:if test="${breadCrumb.method=='GET'}">
					<c:set var="action">href="<c:url
							value="${breadCrumb.url}?breadCrumbId=${breadCrumb.position}&${breadCrumb.queryString}" />"</c:set>
				</c:if> <a ${action}><fmt:message key="breadcrumbs.${breadCrumb.tag}" /></a>
			</li>
		</c:forEach>
		</ul>
	</form>
	<div class="visible-xs breadcrumb-toggle">
		<a class="btn btn-link btn-lg btn-icon" data-toggle="collapse"
			data-target=".breadcrumb-buttons"><i class="icon-menu2"></i></a>
	</div>
	<ul class="breadcrumb-buttons collapse">
		<li class="language dropdown">
			<c:set var="currentLocale"><%= org.springframework.web.servlet.support.RequestContextUtils.getLocale(request).getLanguage()%></c:set>
			<a class="dropdown-toggle" data-toggle="dropdown">
				<img src="/${SR_MODULE_NAME}/cineca/images/flag/flag_${currentLocale}.png" alt="<fmt:message key="flag.${currentLocale}"/>" title="<fmt:message key="flag.${currentLocale}"/>"/> <span><fmt:message key="flag.${currentLocale}"/></span> <b class="caret"></b>
			</a>
			<ul class="dropdown-menu dropdown-menu-right icons-right">
				<li><a href="javascript:changeLanguage('${I18N_BASE}');" ><img src="/${SR_MODULE_NAME}/cineca/images/flag/flag_${I18N_BASE}.png" alt="<fmt:message key="flag.${I18N_BASE}"/>" title="<fmt:message key="flag.${I18N_BASE}"/>"/><fmt:message key="flag.${I18N_BASE}"/></a></li>
				<c:forEach items="${fn:split(I18N_LIST,',')}" var="language">
					<li><a href="javascript:changeLanguage('${language}');" ><img src="/${SR_MODULE_NAME}/cineca/images/flag/flag_${language}.png" alt="<fmt:message key="flag.${language}"/>" title="<fmt:message key="flag.${language}"/>"/><fmt:message key="flag.${language}"/></a></li>
				</c:forEach>
			</ul>
		</li>
	</ul>
</div>