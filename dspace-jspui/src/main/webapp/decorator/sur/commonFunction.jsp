<%@ include file="/common/taglib.jsp"%>

<cineca-authz:authentication property="principal" var="userDetail"/> 
	<script type="text/javascript">
		var nRetry=1;
		function initializeProfileImages(){
			<c:if test="${not empty userDetail.personId}">
			if($.cookie("iris-inter-module-login")=="true"||nRetry>=20){				
				var personPicture = "/${RM_MODULE_NAME}/person/picture/get.fragment?personId="+${userDetail.personId}+"&random="+Math.random();
				var personPictureForm = "/${RM_MODULE_NAME}/person/profile/form.htm?personId="+${userDetail.personId}+"&random="+Math.random();
				$("#westProfileImgSmall").attr("src", personPicture);
				$("#westProfileImg").attr("src", personPicture);
				$("#westProfileImg2").attr("href", personPictureForm);
				$("#northProfileImgSmall").attr("src", personPicture);
			} else {
				nRetry++;
				window.setTimeout("initializeProfileImages()",500);
			}
			</c:if>	
		}		
		$(initializeProfileImages);

		var uploader;
		var authorizationLoginAsModuleArray = [ ${RELOAD_MODULE_LIST}];
		var authorizationLoginAsModuleMap=new Object();
		
		function initPhotoUploader(_personId){
			//===== Pluploader (multiple file uploader) =====//
			uploader=JQ(".multiple-uploader").pluploadQueue({
				multi_selection: false,
			    runtimes : 'html5, html4',
			    url : '/${RM_MODULE_NAME}/person/blob/save.json',
			    chunk_size : '1mb',
			    unique_names : true,
			    filters : {
			        max_file_size : '1mb',
			        mime_types: [
			            {title : "Image files", extensions : "jpg,gif,png"},
			        ]
			    },
			    resize : {width : 320, height : 240, quality : 90},
			    multipart_params: {
		    		personId: _personId,
		    		discriminator:'picture'
		    	}
			});
		}
		
		JQ(function() {
			jQuery.each(authorizationLoginAsModuleArray, function(index, value) { 
				authorizationLoginAsModuleMap[value]=false;
			});
		});
		
		
		// ===== GESTIONE UPLOAD FOTO ===== //
		function showEditPhoto(_personId) {
			initPhotoUploader(_personId);
			JQ('#editPhoto-div').modal();
			JQ('#editPhoto-div').on('hidden.bs.modal', function () {
				 reloadPhoto(_personId);
		    	$('.multiple-uploader').unbind();
		    	initPhotoUploader(_personId);
			})
			
		}
		
		function deletePhoto(_personId) {
			JQ.ajax({
				url: "<c:url value="/person/blob/delete.json"/>?personId="+_personId+"&discriminator=picture",
				dataType: "text",		
				contentType: "application/x-www-form-urlencoded;charset=UTF-8",													
				success: function(data,extStatus, errorThrown) {
					reloadPhoto(_personId);
				},
				error: function(data,extStatus, errorThrown) {
					alert('errore');
				}
			});
		}
		
		function reloadPhoto(_personId) {
			var d = new Date();
	    	JQ("#profileImg").attr("src", "/${RM_MODULE_NAME}/person/picture/get.fragment?personId="+_personId+"&time="+d.getTime());
	    	JQ("#westProfileImg").attr("src", "/${RM_MODULE_NAME}/person/picture/get.fragment?personId="+_personId+"&time="+d.getTime());
	    	JQ("#westProfileImgSmall").attr("src", "/${RM_MODULE_NAME}/person/picture/get.fragment?personId="+_personId+"&time="+d.getTime());
	    	JQ("#northProfileImgSmall").attr("src", "/${RM_MODULE_NAME}/person/picture/get.fragment?personId="+_personId+"&time="+d.getTime());
		}
		
		
		
		function showAbout() {
			   var url = "/${MODULE_NAME}/sur/about.modal";
			   url = url.replace('//sur','/sur');
			   url = url.replace('/null/sur','/sur');
			jQuery.ajax({
				url: url,
				type: 'GET',
				success: function(data) {
	                var $modal = jQuery(data);
					jQuery('body').append($modal);
	                $modal.filter('.modal').modal();
	                $modal.filter('.modal').on('hidden.bs.modal', function(){
	                	$modal.remove();
					});
				}
			});
		}
		
		function showCookies() {
			 var url = "/${MODULE_NAME}/sur/aboutCookies.modal";
			   url = url.replace('//sur','/sur');
			   url = url.replace('/null/sur','/sur');
			jQuery.ajax({
				url: url,
				type: 'GET',
				success: function(data) {
	                var $modal = jQuery(data);
					jQuery('body').append($modal);
	                $modal.filter('.modal').modal();
	                $modal.filter('.modal').on('hidden.bs.modal', function(){
	                	$modal.remove();
					});
				}
			});
		}
		
		function showPrivacyInfo() {
			var url = "/${MODULE_NAME}/sur/aboutPrivacyInfo.modal";
			   url = url.replace('//sur','/sur');
			   url = url.replace('/null/sur','/sur');
			jQuery.ajax({
				url: url,
				type: 'GET',
				success: function(data) {
	                var $modal = jQuery(data);
					jQuery('body').append($modal);
	                $modal.filter('.modal').modal();
	                $modal.filter('.modal').on('hidden.bs.modal', function(){
	                	$modal.remove();
					});
				}
			});
		}		
		
		
		// ===== GESTIONE DEI BOOKMARK ===== //
		function openBookmarkDialogue() {
			jQuery.ajax({
				url: '<c:url value="/bookmark/root/get.fragment"/>',
				type: 'GET',
				beforeSend: function(jqXHR, settings){
					jQuery('#dialogueBookmarkDiv').html(""); 
				},
				success: function(data) {
					jQuery('#dialogueBookmarkDiv').html(data);
					jQuery('#dialogueBookmarkDiv').modal();
				}
			});
		}
	<%--	function submitBoomarkForm(){
			jQuery.ajax({
				url:"<c:url value="/manager/bookmark/update.json"/>",
				data:
				{
					todo:'create',
					parentId:'${sessionScope.rootBookmarkId}',
					index:'0',
					title:jQuery("#bookmarkName").val(),
					type:'bookmark'
				},
				dataType: 'text',
				sync: true,
				success: function(data) {
					jQuery('#dialogueBookmarkDiv').modal('hide')
				}
			});
		}
		--%>
		// ===== GESTIONE DEI login as ===== //
		function showLoginAs() {
			jQuery('#loginAs-div').modal();
		}
		function loginAs() {
			jQuery('body').append('<div class="overlay"><div class="opacity"></div><i class="icon-spinner2 spin"></i></div>');
			jQuery('.overlay').fadeIn(150);
			jQuery.each(authorizationLoginAsModuleMap, function(module, value) {
				jQuery.ajax({
					url: ((module.substring(0, 1) == "/") ? "" : "/") +module+"/authorization/loginAs/module.fragment",
					dataType: "text",		
					contentType: "application/x-www-form-urlencoded;charset=UTF-8",													
					data: {
						username: jQuery('#authLoginAs').val(),
						RAND: Math.random(9999)
					},
					success: function(data,extStatus, errorThrown) {
						authorizationLoginAsModuleMap[module]=true;
					},
					error: function(data,extStatus, errorThrown) {
					}
				});
			});
			checkModuleCalls(authorizationLoginAsModuleMap);
			window.setTimeout("reloadCurrentUrl();",10000);
		}
		</script>	
		<% if (it.cilea.core.authorization.AuthorizationConstant.RESOURCE_MAP.containsKey("/authorization/loginAs/module.fragment")) { %>
		<authz:authorize url="/authorization/loginAs/module.fragment">
			<div class="modal fade" id="loginAs-div" tabindex="-1" role="dialog" aria-labelledby="loginAsLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="loginAsLabel"><fmt:message key="title.loginAs"/></h4>
						</div>
						<div class="modal-body with-padding">
							<widget:label labelKey="label.username"/>
							<widget:textCore inputId="authLoginAs" inputName="authLoginAs" autocompleteUrl="/${RM_MODULE_NAME}/user/selectable/displayAsIdentifier/widgetSearch.json" autocompleteInputValue=""
								autocompleteInputName="authLoginAsUsername" autocompleteData="posting: '1', username: request.term, sort: 'user.username'" cssClass="half" modeType="enabled"/>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="button.undo"/></button>
							<button type="button" class="btn btn-primary" onclick="loginAs();"><fmt:message key="authLoginAs.button"/></button>
						</div>
					</div>
				</div>
			</div>
		</authz:authorize>
		<% } %>
		
		<div class="modal fade" id="dialogueBookmarkDiv" tabindex="-1" role="dialog" aria-labelledby="boomarkLabel" aria-hidden="true">
		</div>
		
		
		<div class="modal fade" id="editPhoto-div" tabindex="-1" role="dialog" aria-labelledby="editPhotoLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="editPhotoLabel"><fmt:message key="title.editPhoto"/></h4>
					</div>
					<div class="modal-body with-padding">
						<div class="multiple-uploader" >
							
						</div>
					</div>
				</div>
			</div>
		</div>
