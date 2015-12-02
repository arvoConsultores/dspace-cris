<%@ include file="/common/taglib.jsp"%>	
	<script type="text/javascript" src="/${SR_MODULE_NAME}/jquery/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/jquery/js/ui-1.10.4/jquery-ui.min.js"></script>
	
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/charts/sparkline.min.js"></script>
	
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/forms/uniform.min.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/forms/select2.min.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/forms/inputmask.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/forms/autosize.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/forms/inputlimit.min.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/forms/listbox.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/forms/multiselect.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/forms/validate.min.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/forms/tags.min.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/forms/switch.min.js"></script>
	
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/forms/uploader/plupload.full.min.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/forms/uploader/plupload.queue.min.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/plupload/js/langs/it.js"></script>
	
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/forms/wysihtml5/wysihtml5.min.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/forms/wysihtml5/toolbar.js"></script>
	
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/interface/daterangepicker.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/interface/fancybox.min.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/interface/moment.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/interface/jgrowl.min.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/interface/datatables.min.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/interface/colorpicker.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/interface/fullcalendar.min.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/interface/timepicker.min.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/plugins/interface/collapsible.min.js"></script>
	
	<script type="text/javascript" src="/${SR_MODULE_NAME}/londinium/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/cineca/js/application.js?irisVersion=${IRIS_VERSION}"></script>

	<script type="text/javascript" src="/${SR_MODULE_NAME}/jstree/jstree.min.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/jquery/js/jquery.fileDownload.1.4.4.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/jquery/js/jquery.displaytag-ajax-1.2.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/jquery/js/jquery-ui-timepicker-addon.1.0.1.js.js"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/jquery/js/jquery.cookie.js"></script>
	<!-- number con autonumeric -->
	<script type="text/javascript" src="/${SR_MODULE_NAME}/jquery/js/autoNumeric-1.7.5.js" charset="utf-8"></script>
	<!-- jquery calendar it -->
	<script type="text/javascript" src="/${SR_MODULE_NAME}/jquery/js/jquery.ui.datepicker-<%= org.springframework.web.servlet.support.RequestContextUtils.getLocale(request).getLanguage()%>.latest.js" charset="utf-8"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/ckeditor_latest/ckeditor.js"></script>

	<!-- CINECA -->
	<script type="text/javascript">
		var menuReloadModuleArray = [${RELOAD_MODULE_LIST}];
		var menuReloadModuleMap=new Object();
		$.each(menuReloadModuleArray, function(index, value) { 
			menuReloadModuleMap[value]=false;
		});
		function reloadMenuContext() {
			$('body').append('<div class="overlay"><div class="opacity"></div><i class="icon-spinner2 spin"></i></div>');
			$('.overlay').fadeIn(150);
			$.each(menuReloadModuleMap, function(module, value) { 
				$.ajax({
					url: ((module.substring(0, 1) == "/") ? "" : "/") +module+"/menu/reload.fragment",
					dataType: "text",		
					contentType: "application/x-www-form-urlencoded;charset=UTF-8",													
					data: {
						RAND: Math.random(9999)
					},
					success: function(data,extStatus, errorThrown) {
						menuReloadModuleMap[module]=true;
					},
					error: function(data,extStatus, errorThrown) {
					}
				});
			});
			checkModuleCalls(menuReloadModuleMap);
			window.setTimeout("location.reload();",2000);
		}
	</script>
	<script type="text/javascript">
		var i18nReloadModuleArray = [${RELOAD_MODULE_LIST}];
		var i18nReloadModuleMap=new Object();
		$.each(i18nReloadModuleArray, function(index, value) { 
			i18nReloadModuleMap[value]=false;
		});
		function reloadI18n() {
			$('body').append('<div class="overlay"><div class="opacity"></div><i class="icon-spinner2 spin"></i></div>');
			$('.overlay').fadeIn(150);
			$.each(i18nReloadModuleMap, function(module, value) { 
				$.ajax({
					url: ((module.substring(0, 1) == "/") ? "" : "/") +module+"/i18n/reload.fragment",
					dataType: "text",		
					contentType: "application/x-www-form-urlencoded;charset=UTF-8",													
					data: {
						RAND: Math.random(9999)
					},
					success: function(data,extStatus, errorThrown) {
						i18nReloadModuleMap[module]=true;
					},
					error: function(data,extStatus, errorThrown) {
					}
				});
			});
			checkModuleCalls(i18nReloadModuleMap);
			window.setTimeout("location.reload();",2000);
		}
		function i18nAdministrativeStart() {
			$('body').append('<div class="overlay"><div class="opacity"></div><i class="icon-spinner2 spin"></i></div>');
			$('.overlay').fadeIn(150);
			$.each(i18nReloadModuleMap, function(module, value) { 
				$.ajax({
					url: ((module.substring(0, 1) == "/") ? "" : "/") +module+"/i18n/administrative/start.fragment",
					dataType: "text",		
					contentType: "application/x-www-form-urlencoded;charset=UTF-8",													
					data: {
						RAND: Math.random(9999)
					},
					success: function(data,extStatus, errorThrown) {
						i18nReloadModuleMap[module]=true;
					},
					error: function(data,extStatus, errorThrown) {
					}
				});
			});
			checkModuleCalls(i18nReloadModuleMap);
			window.setTimeout("location.reload();",2000);
		}
		function i18nAdministrativeStop() {
			$('body').append('<div class="overlay"><div class="opacity"></div><i class="icon-spinner2 spin"></i></div>');
			$('.overlay').fadeIn(150);
			$.each(i18nReloadModuleMap, function(module, value) { 
				$.ajax({
					url: ((module.substring(0, 1) == "/") ? "" : "/") +module+"/i18n/administrative/stop.fragment",
					dataType: "text",		
					contentType: "application/x-www-form-urlencoded;charset=UTF-8",													
					data: {
						RAND: Math.random(9999)
					},
					success: function(data,extStatus, errorThrown) {
						i18nReloadModuleMap[module]=true;
					},
					error: function(data,extStatus, errorThrown) {
					}
				});
			});
			checkModuleCalls(i18nReloadModuleMap);
			window.setTimeout("location.reload();",2000);
		}
	</script>
	<script type="text/javascript">
		var authorizationReloadModuleArray = [${RELOAD_MODULE_LIST}];
		var authorizationReloadModuleMap=new Object();
		$.each(authorizationReloadModuleArray, function(index, value) { 
			authorizationReloadModuleMap[value]=false;
		});
		function reloadAuthorizationContext() {
			$('body').append('<div class="overlay"><div class="opacity"></div><i class="icon-spinner2 spin"></i></div>');
			$('.overlay').fadeIn(150);
			$.each(authorizationReloadModuleMap, function(module, value) { 
				$.ajax({
					url: ((module.substring(0, 1) == "/") ? "" : "/") +module+"/authorization/reload.fragment",
					dataType: "text",		
					contentType: "application/x-www-form-urlencoded;charset=UTF-8",													
					data: {
						RAND: Math.random(9999)
					},
					success: function(data,extStatus, errorThrown) {
						authorizationReloadModuleMap[module]=true;
					},
					error: function(data,extStatus, errorThrown) {
					}
				});
			});
			checkModuleCalls(authorizationReloadModuleMap);
			window.setTimeout("location.reload();",2000);
		}
	</script>
	<script type="text/javascript">
		var configurationReloadModuleArray = [${RELOAD_MODULE_LIST}];
		var configurationReloadModuleMap=new Object();
		$.each(configurationReloadModuleArray, function(index, value) { 
			configurationReloadModuleMap[value]=false;
		});
		function reloadConfigurationContext() {
			$('body').append('<div class="overlay"><div class="opacity"></div><i class="icon-spinner2 spin"></i></div>');
			$('.overlay').fadeIn(150);
			$.each(configurationReloadModuleMap, function(module, value) { 
				$.ajax({
					url: ((module.substring(0, 1) == "/") ? "" : "/") +module+"/configuration/reload.fragment",
					dataType: "text",		
					contentType: "application/x-www-form-urlencoded;charset=UTF-8",													
					data: {
						RAND: Math.random(9999)
					},
					success: function(data,extStatus, errorThrown) {
						configurationReloadModuleMap[module]=true;
					},
					error: function(data,extStatus, errorThrown) {
					}
				});
			});
			checkModuleCalls(configurationReloadModuleMap);
			window.setTimeout("location.reload();",2000);
		}
	</script>
	<script type="text/javascript">
		var languageChangeArray = [ ${RELOAD_LANGUAGE_MODULE_LIST}];
		var languageChangeMap=new Object();
		$.each(languageChangeArray, function(index, value) { 
			languageChangeMap[value]=false;
		});
		function changeLanguage(language) {
			$('body').append('<div class="overlay"><div class="opacity"></div><i class="icon-spinner2 spin"></i></div>');
			$('.overlay').fadeIn(150);
			$.each(languageChangeMap, function(module, value) { 
				$.ajax({
					url: ((module.substring(0, 1) == "/") ? "" : "/") +module+"/language/change.fragment",
					dataType: "text",		
					contentType: "application/x-www-form-urlencoded;charset=UTF-8",													
					data: {
						changeLocale: language,
						RAND: Math.random(9999)
					},
					success: function(data,extStatus, errorThrown) {
						languageChangeMap[module]=true;
					},
					error: function(data,extStatus, errorThrown) {
					}
				});
			});
			checkModuleCalls(languageChangeMap);
			window.setTimeout("location.reload();",2000);
		}
	</script>
	<script type="text/javascript">
		var moduleNames = new Object();
		moduleNames['ap'] = '${AP_MODULE_NAME}';
		moduleNames['rm'] = '${GA_MODULE_NAME}';
		moduleNames['ma'] = '${MA_MODULE_NAME}';
	</script>
	<script>
	var JQ = $;
	var j = $;
	</script>
	<script type="text/javascript">
	<%-- IRIS-1244 solve problem of auto-close the modal when change month/year in calendar
	http://stackoverflow.com/questions/22405259/use-jquery-datepicker-in-bootstrap-3-modal/22501477#22501477
	--%>
	var enforceModalFocusFn = $.fn.modal.Constructor.prototype.enforceFocus;
	$.fn.modal.Constructor.prototype.enforceFocus = function() {};
	</script>
	
	<script type="text/javascript" src="/${SR_MODULE_NAME}/cineca/js/cilea.js?irisVersion=${IRIS_VERSION}"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/cineca/js/bookmark.js?irisVersion=${IRIS_VERSION}"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/cineca/js/fragment.js?irisVersion=${IRIS_VERSION}"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/cineca/js/print.js?irisVersion=${IRIS_VERSION}"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/cineca/js/widget.js?irisVersion=${IRIS_VERSION}"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/cineca/js/layout.js?irisVersion=${IRIS_VERSION}"></script>
