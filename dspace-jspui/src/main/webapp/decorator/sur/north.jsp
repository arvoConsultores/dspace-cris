<%@ include file="/common/taglib.jsp"%>
<%@page import="it.cilea.core.util.MessageUtilConstant"%>
<%@page import="it.cilea.core.i18n.conf.CileaMessageSource"%>

<cineca-authz:authentication property="principal" var="userDetail"/> 

<%
CileaMessageSource source = (CileaMessageSource) MessageUtilConstant.messageUtil.getMessageSource();
if(source != null && source.isCurrentUserAdministrative()){
%>	
	<div id="jGrowlCustomMessage" class="panel panel-default hidden">
		<p><fmt:message key="18n-noadministrative.i18n-vision.message" /></p>
		<button class="btn btn-default" type="button" onclick="i18nAdministrativeStop();">
			<fmt:message key="18n-noadministrative.i18n-vision.button" />
		</button>
	</div>
	<script type="text/javascript">
		JQ(document).ready(function() {
			clone =$('#jGrowlCustomMessage').clone(true).removeClass('hidden');
			$.jGrowl(clone.html(), { life: 20000, theme: 'growl-warning', header: '<fmt:message key="18n-noadministrative.i18n-vision.header" />' });
		});
	</script>
<%}%>


<!-- Navbar -->
	<div class="navbar navbar-inverse" role="navigation">
		<div class="navbar-header">
			<a class="navbar-brand" href="${IR_FULL_PATH}">
				<img src="/${SR_MODULE_NAME}/cineca/images/interface/logo_iris_small_narrowed.png" alt="IRIS logo">
				${webapp.mailTitle}
			</a>
			<c:if test="${showNavButtons}">
				<c:if test="${not empty userDetail}">
					<a class="sidebar-toggle" title="<fmt:message key="jsp.navbar.open-close"/>"><i class="icon-paragraph-justify2"></i></a>
				</c:if>
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-icons">
					<span class="sr-only">Toggle right icons</span><i class="icon-grid"></i>
				</button>
				<c:if test="${not empty userDetail}">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-menu">
						<span class="sr-only">Toggle menu</span><i class="icon-paragraph-justify2"></i>
					</button>
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar">
						<span class="sr-only">Toggle sidebar</span><i class="icon-indent-decrease"></i>
					</button>
				</c:if>
			</c:if>
		</div>
		<c:if test="${showTopMenu}">
			<div class="nav navbar-form navbar-left collapse" id="navbar-menu">
				<menu:navbarTopMenu item="${identifierTreeMap['/top.menu']}"/>
			</div>
			<%-- USATO PER IMPORTARE MENU DI DSPACE inizio--%>
			<ul class="nav navbar-nav collapse hide" id="ir-navbar-menu"></ul>
			<%-- USATO PER IMPORTARE MENU DI DSPACE fine--%>
		</c:if>
		<ul class="nav navbar-nav navbar-right collapse" id="navbar-icons">
			<c:if test="${empty userDetail}">
				<li>
<%-- 					<button class="btn btn-primary navbar-btn" type="button" onclick="window.location.href='${IR_FULL_PATH}/mydspace"><i class="fa fa-key"></i>&nbsp;<fmt:message key="login"/></button> --%>
					<a href="${IR_FULL_PATH}/mydspace">
						<span><i class="fa fa-key"></i>&nbsp;<fmt:message key="button.login"/></span>
					</a>
				</li>
			</c:if>
			<c:if test="${showBookmark && not empty userDetail && config:value('it.cineca.configuration.bookmark.visibility')=='true'}">
				<li>
					<a onclick="openBookmarkDialogue();">
						<span><i class="fa fa-bookmark"></i></span>
					</a>
				</li>
			</c:if>
			<c:if test="${not empty sessionScope.login_as_activated && sessionScope.login_as_activated && showLoginAs}">
				<li class="user dropdown">
					<a onclick="loginAsEnd();">
						<span><fmt:message key="loginAs.end"/></span>
					</a>
				</li>
				<script type="text/javascript">
					var authorizationLoginAsEndModuleArray = [ ${RELOAD_MODULE_LIST}];
					var authorizationLoginAsEndModuleMap=new Object();
					$.each(authorizationLoginAsEndModuleArray, function(index, value) { 
						authorizationLoginAsEndModuleMap[value]=false;
					});
					function loginAsEnd() {
						$('body').append('<div class="overlay"><div class="opacity"></div><i class="icon-spinner2 spin"></i></div>');
						$('.overlay').fadeIn(150);
						$.each(authorizationLoginAsEndModuleMap, function(module, value) { 
							$.ajax({
								url: ((module.substring(0, 1) == "/") ? "" : "/") +module+"/authorization/loginAsEnd/module.fragment",
								dataType: "text",		
								contentType: "application/x-www-form-urlencoded;charset=UTF-8",			
								data: {
									RAND: Math.random(9999)
								},
								success: function(data,extStatus, errorThrown) {
									authorizationLoginAsEndModuleMap[module]=true;
								},
								error: function(data,extStatus, errorThrown) {
								}
							});
						});
						checkModuleCalls(authorizationLoginAsEndModuleMap);
						window.setTimeout("reloadCurrentUrl();",10000);
					}
				</script>
			</c:if>
			<c:if test="${not empty userDetail && fn:length(userDetail.authorityList)>1 && showAuthorityList}">
				<li class="user dropdown">
					<a class="dropdown-toggle" data-toggle="dropdown">
						<span>
							<c:forEach items="${userDetail.authorityList}" var="authority">
								<c:if test="${authority.identifier==userDetail.currentAuthorityIdentifier}">
									<fmt:message key="prompt.authority.current"/>${authority.displayValue}
								</c:if>
							</c:forEach>
						</span><i class="caret"></i>
					</a>
					<ul class="dropdown-menu dropdown-menu-right icons-right">
						<c:forEach items="${userDetail.authorityList}" var="authority">
							<c:if test="${authority.identifier!=userDetail.currentAuthorityIdentifier}">
								<li><a onclick="authorityIdentifierChanged('${authority.identifier}');"><fmt:message key="prompt.authority.switch"/> ${authority.displayValue}</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</li>
				<script type="text/javascript">
					var authorizationChangeRoleModuleArray = [${RELOAD_MODULE_LIST}];
					var authorizationChangeRoleModuleMap=new Object();
					$.each(authorizationChangeRoleModuleArray, function(index, value) { 
						authorizationChangeRoleModuleMap[value]=false;
					});
					function authorityIdentifierChanged(authorityIdentifier) {
						$('body').append('<div class="overlay"><div class="opacity"></div><i class="icon-spinner2 spin"></i></div>');
						$('.overlay').fadeIn(150);
						$.each(authorizationChangeRoleModuleMap, function(module, value) {
							$.ajax({
								url: ((module.substring(0, 1) == "/") ? "" : "/") +module+"/authorization/changeRole/module.fragment",
								dataType: "text",		
								contentType: "application/x-www-form-urlencoded;charset=UTF-8",													
								data: {
									authorityIdentifier: authorityIdentifier,
									RAND: Math.random(9999)
								},
								success: function(data,extStatus, errorThrown) {
									authorizationChangeRoleModuleMap[module]=true;
								},
								error: function(data,extStatus, errorThrown) {
								}
							});
						});
						checkModuleCalls(authorizationChangeRoleModuleMap);
						window.setTimeout("reloadCurrentUrl();",10000);
					}
				</script>
			</c:if>
			<c:if test="${not empty userDetail && showMyMenu }">
				<li class="user dropdown"><a class="dropdown-toggle" data-toggle="dropdown">				
					<img src="/${SR_MODULE_NAME}/londinium/images/interface/spinner.png" alt="" id="northProfileImgSmall"><span>${userDetail.firstName}&nbsp;${userDetail.lastName}</span><i class="caret"></i></a>
					<menu:navbarMenu top="true" item="${identifierTreeMap['/my.menu']}" cssReplace="dropdown-menu dropdown-menu-right icons-right" />
				</li>
			</c:if>
		</ul>
	</div>
	
