<%@ include file="/common/taglib.jsp"%>
<cineca-authz:authentication property="principal" var="userDetail"/> 
<div class="sidebar collapse">
	<div class="sidebar-content">
		<c:if test="${not empty userDetail}">
			<div class="user-menu dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown">
					<img src="/${SR_MODULE_NAME}/londinium/images/interface/spinner.png" alt="" id="westProfileImgSmall">
					<div class="user-info">
						${userDetail.firstName}&nbsp;${userDetail.lastName}
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
							<h6>${userDetail.firstName}&nbsp;${userDetail.lastName}</h6>
						</div>
					</div>
				</div>
			</div>
		</c:if>
		<menu:navbarMenu item="${identifierTreeMap['/module.menu']}" divId="sidebar" top="false"></menu:navbarMenu>
	</div>
</div>