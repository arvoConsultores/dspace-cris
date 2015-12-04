<%@ include file="/common/taglib.jsp"%>

<%@ include file="/decorator/include/alive.jsp"%>
<script type="text/javascript">
function removeWidgetMultiple(inputId) {
	$('#'+inputId).val('');
	$('#'+inputId+'_line').hide();
}
</script>
<cineca-authz:authentication property="principal" var="userDetail"/> 
	<script type="text/javascript">
		
		
		function showAbout() {
			   var url = "<c:url value="/about.modal"/>";
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
		
		</script>	
		
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
		