<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://displaytag.sf.net/el" prefix="display-el" %>


<head>
	<link rel="stylesheet" href="<spring:url value="/elfinder/css/elfinder.css" />" type="text/css" media="screen" title="no title" charset="utf-8">
	<script src="<spring:url value="/elfinder/js/elfinder.min.js" />" type="text/javascript" charset="utf-8"></script>
	<c:if test="${ lang != 'en'}" >
		<script src="<spring:url value="/elfinder/js/i18n/elfinder.${lang}.js" />" type="text/javascript" charset="utf-8"></script>
	</c:if>
	<style>

.ui-icon,
.ui-dialog-titlebar-close {
	display: inline-block;
	font-family: FontAwesome;
	font-style: normal;
	font-weight: normal;
	line-height: 1;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	color: black;
}

.ui-dialog-titlebar-close:before {
	content: "\f00d";
}

.ui-icon-circle-plus:before { 
	content: "\f055";
}

.ui-helper-reset {
	margin: 0;
	padding: 0;
	border: 0;
	outline: 0;
	line-height: 1.3;
	text-decoration: none;
	font-size: 100%;
	list-style: none;
}

.ui-helper-clearfix:before,
.ui-helper-clearfix:after {
	content: "";
	display: table;
	border-collapse: collapse;
}
.ui-helper-clearfix:after {
	clear: both;
}
.ui-helper-clearfix {
	min-height: 0; /* support: IE7 */
}

.ui-dialog {
	overflow: hidden;
	position: absolute;
	top: 0;
	left: 0;
	padding: .2em;
	outline: 0;
}
.ui-dialog .ui-dialog-titlebar {
	padding: .4em 1em;
	position: relative;
}
.ui-dialog .ui-dialog-title {
	float: left;
	margin: .1em 0;
	white-space: nowrap;
	width: 90%;
	overflow: hidden;
	text-overflow: ellipsis;
}
.ui-dialog .ui-dialog-titlebar-close {
	position: absolute;
	right: .3em;
	top: 50%;
	width: 20px;
	margin: -10px 0 0 0;
	padding: 1px;
	height: 20px;
}
.ui-dialog .ui-dialog-content {
	position: relative;
	border: 0;
	padding: .5em 1em;
	background: none;
	overflow: auto;
}
.ui-dialog .ui-dialog-buttonpane {
	text-align: left;
	border-width: 1px 0 0 0;
	background-image: none;
	margin-top: .5em;
	padding: .3em 1em .5em .4em;
}
.ui-dialog .ui-dialog-buttonpane .ui-dialog-buttonset {
	float: right;
}
.ui-dialog .ui-dialog-buttonpane button {
	margin: .5em .4em .5em 0;
	cursor: pointer;
}
.ui-dialog .ui-resizable-se {
	width: 12px;
	height: 12px;
	right: -5px;
	bottom: -5px;
	background-position: 16px 16px;
}
.ui-draggable .ui-dialog-titlebar {
	cursor: move;
}

/* Component containers
----------------------------------*/
.ui-widget {
	font-family: Trebuchet MS,Tahoma,Verdana,Arial,sans-serif;
	font-size: 1.1em;
}
.ui-widget .ui-widget {
	font-size: 1em;
}
.ui-widget input,
.ui-widget select,
.ui-widget textarea,
.ui-widget button {
	/*font-family: Trebuchet MS,Tahoma,Verdana,Arial,sans-serif;*/
	font-size: 1em;
}
.ui-widget-content {
	border: 1px solid #dddddd;
	background: #ffffff;
	color: #333333;
}
.ui-widget-content a {
	color: #333333;
}
.ui-widget-header {
	border: 1px solid #65b688;
	background: #65b688 url("images/ui-bg_gloss-wave_35_f6a828_500x100.png") 50% 50% repeat-x;
	color: #ffffff;
	font-weight: bold;
}
.ui-widget-header a {
	color: #ffffff;
}
	
	</style>
</head>
<c:set var="jqueryCompatibilityMode" scope="request" value="true"/>
<body>
	<script type="text/javascript" charset="utf-8">
		function setSize() {
			var winHeight = jQuery(window).height();
			var startHeight = jQuery('.el-finder-workzone').offset().top;
			var statusbarHeight = jQuery('.el-finder-statusbar').outerHeight();
			
			var siblingsHeight = 50;
			jQuery('#finder ~ div').each(function(idx, el) {
				var elementHeight = jQuery(el).outerHeight();
				siblingsHeight = siblingsHeight + elementHeight;
				console.log('sibling:', el, 'H:', elementHeight);
			});
			
			var workspaceHeight = winHeight - (startHeight + siblingsHeight + statusbarHeight);
			console.log("Workspace H:", workspaceHeight);
			jQuery('.el-finder-nav').height(workspaceHeight);
			jQuery('.el-finder-cwd').height(workspaceHeight);
		}	
		
		jQuery().ready(function() {
			
			var f = jQuery('#finder').elfinder({
				url : '<spring:url value="${connectorUrl}" />',
				lang : '${lang}',
				places: false,
				docked : false,
				toolbar : [
				      			['back', 'reload'],
				      			['mkdir', 'upload'],
				      			['copy', 'paste', 'rm', 'rename'],
				      			['icons', 'list']
				      		],
				contextmenu : {
					'cwd'   : ['reload', 'delim', 'mkdir', 'upload', 'delim', 'paste', 'delim', 'info'],
					'file'  : ['delim', 'copy', 'cut', 'rm', 'rename', 'delim', 'info'],
					'group' : ['select', 'copy', 'cut', 'rm']
				}
			});
			
			//jQuery('.el-finder-statusbar').hide();
			setSize();
			jQuery(window).resize(function() {
				setSize();
			});
		});
	</script>
	<div id="finder" style="position:relative;" >
		
	</div>
</body>
