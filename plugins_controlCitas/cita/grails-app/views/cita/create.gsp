<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainVentanilla">
		<g:set var="entityName" value="${message(code: 'cita.label', default: 'Cita')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>		
		<!-- se pusieron en mainVentanilla referenciados -->
	    <!-- controlCitas/web-app/js/autoCompleteMax.js -->	    		
	</head>
	<body>
		<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">

			<div id="create-cita" class="content scaffold-create cita" role="main">
				<h1><g:message code="default.create.label" args="[entityName]" /></h1>
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<g:hasErrors bean="${cita}">
				<ul class="errors" role="alert">
					<g:eachError bean="${cita}" var="error">
						<div class="alert alert-danger" role="alert">
							<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
						</div>
					</g:eachError>
				</ul>
				</g:hasErrors>
				<g:form url="[resource:cita, action:'save']" >
					<fieldset class="form-horizontal cita-form">
						<g:render template="form"/>
					</fieldset>
					<fieldset class="buttons col-sm-offset-2 cita-buttons">
						<g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
					</fieldset>
				</g:form>

			</div>
		</div>
		<script>
			$(document).ready( setNavBarLista("${entityName}")  );
		</script>		 
	</body>
</html>
