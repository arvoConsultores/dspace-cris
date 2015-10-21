<%@page import="java.net.URLDecoder"%>
<%@ include file="/common/taglib.jsp"%>
<cineca-authz:authentication property="principal" var="userDetail"/> 
<div class="sidebar collapse">
	<div class="sidebar-content">
		<c:if test="${not empty userDetail}">
			<!-- User dropdown -->
			<div class="user-menu dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown">
					<img src="/${SR_MODULE_NAME}/londinium/images/interface/spinner.png" alt="" id="westProfileImgSmall">
					<div class="user-info">
						${userDetail.firstName}&nbsp;${userDetail.lastName}<%-- <span>Web Developer</span> --%>
					</div>
				</a>
				<div class="popup dropdown-menu dropdown-menu-right">
					<div class="thumbnail">
						<div class="thumb">
							<img alt="" src="/${SR_MODULE_NAME}/londinium/images/interface/spinner.png" id="westProfileImg">
							<authz:authorize access="hasPermission('/person/profile/form.htm','currentRole')" >
							<div class="thumb-options">
								<span>
									<a href="/${SR_MODULE_NAME}/londinium/images/interface/spinner.png" class="btn btn-icon btn-success" id="westProfileImg2"><i class="icon-pencil"></i></a>
								</span>
							</div>
							</authz:authorize>
						</div>
						<div class="caption text-center">
							<h6>${userDetail.firstName}&nbsp;${userDetail.lastName}<%-- <small>Front end developer</small> --%></h6>
						</div>
					</div>
					<%--
					<ul class="list-group">
						<li class="list-group-item"><i
							class="icon-pencil3 text-muted"></i> My posts <span
							class="label label-success">289</span></li>
						<li class="list-group-item"><i
							class="icon-people text-muted"></i> Users online <span
							class="label label-danger">892</span></li>
						<li class="list-group-item"><i
							class="icon-stats2 text-muted"></i> Reports <span
							class="label label-primary">92</span></li>
						<li class="list-group-item"><i class="icon-stack text-muted"></i>
							Balance
							<h5 class="pull-right text-danger">$45.389</h5></li>
					</ul>
					 --%>
				</div>
			</div>
			<!-- /user dropdown -->
			<!-- Main navigation -->
			<menu:navbarMenu item="${identifierTreeMap['/module.menu']}" divId="sidebar" top="false"></menu:navbarMenu>
			<!-- /main navigation -->
		</c:if>
	</div>
	<%--
	<img class="center-block" src="/${SR_MODULE_NAME}/cineca/images/interface/logo_iris_small.png" alt="Londinium">
	 --%>
</div>