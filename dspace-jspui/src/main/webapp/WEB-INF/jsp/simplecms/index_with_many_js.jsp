<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<head>
<link rel="stylesheet"
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="<spring:url value="/css/verysimplecms.css" />" />
</head>

<body>
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js" ></script>
	<script src="<spring:url value="/javascript/jquery.ui.widget.js" />"></script>
	<script src="<spring:url value="/javascript/jquery.fileupload.js" />"></script>
	<script src="<spring:url value="/javascript/upload.js" />"></script>
	<script type="text/javascript">
		function msgClear() {
			console.log("MessageClear");
		}
		function addMsg(lvl, msg) {
			console.log("MESSAGE FOR USER: ", lvl, msg);
		}
		var shortCallDelete;
		jQuery().ready(
				function() {
					shortCallDelete = prepareUpload('index.json', 'delete.json', '#fileupload', 
							'#progress .progress-bar',
							msgClear, addMsg,
							 'Done!',
							'Unexpected Server ERROR!!');
				});
	</script>


	<!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
	<div class="row fileupload-buttonbar">
		<div class="col-lg-7">
			<!-- The fileinput-button span is used to style the file input field as button -->
			<span class="btn btn-success fileinput-button"> 
				<i class="fa fa-plus"></i> 
				<span>Add files...</span> 
				<input id="fileupload" type="file" name="files[]" multiple />
			</span>
			<% /* 
			<button type="submit" class="btn btn-primary start">
				<i class="fa fa-upload"></i> <span>Start upload</span>
			</button>
			<button type="reset" class="btn btn-warning cancel">
				<i class="fa fa-ban"></i> <span>Cancel
					upload</span>
			</button>
			*/ %>
		</div>
		<!-- The global progress state -->
		<div class="col-lg-5 fileupload-progress">
			<!-- The global progress bar -->
			<div id="progress" class="progress progress-striped active" role="progressbar"
				aria-valuemin="0" aria-valuemax="100">
				<div class="progress-bar progress-bar-success" style="width: 0%;"></div>
			</div>
		</div>
	</div>
	
	<!-- The table listing the files available for upload/download -->
	<table role="presentation" class="table table-striped">
		<tbody id="table_body" class="files">
			<c:forEach items="${files}" var="f" >
				<tr>
					<td>
						<p class="name">${f.fileName}</p>
					</td>
					<td>
						<p class="name">${f.fileSize}</p>
					</td>
					<td>
						<button type="button" class="btn btn-danger delete" 
							onclick="shortCallDelete('${f.fileName}')">
							<i class="fa fa-trash-o"></i> <span>Delete</span>
						</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</form>



</body>
