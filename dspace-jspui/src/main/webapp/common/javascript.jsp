<%@ include file="/common/taglib.jsp"%>	
	<c:if test="${empty jqueryCompatibilityMode}"><c:set var="jqueryVersion" value="1.11.0" /></c:if>
	<c:if test="${not empty jqueryCompatibilityMode}"><c:set var="jqueryVersion" value="1.8.3" /></c:if>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/jquery/js/jquery-${jqueryVersion}.min.js"></script>
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
	<script type="text/javascript" src="/${SR_MODULE_NAME}/cineca/js/application.js?irisVersion=${FRAMEWORK_VERSION}"></script>

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
	
	<script type="text/javascript" src="/${SR_MODULE_NAME}/cineca/js/cilea.js?irisVersion=${FRAMEWORK_VERSION}"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/cineca/js/bookmark.js?irisVersion=${FRAMEWORK_VERSION}"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/cineca/js/fragment.js?irisVersion=${FRAMEWORK_VERSION}"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/cineca/js/print.js?irisVersion=${FRAMEWORK_VERSION}"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/cineca/js/widget.js?irisVersion=${FRAMEWORK_VERSION}"></script>
	<script type="text/javascript" src="/${SR_MODULE_NAME}/cineca/js/layout.js?irisVersion=${FRAMEWORK_VERSION}"></script>
