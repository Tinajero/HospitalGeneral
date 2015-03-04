<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainAdmin">
		<g:set var="entityName" value="${message(code: 'usuario.label', default: 'Usuario')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		
	</head>
	<body>
	<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">
		<div id="create-usuario" class="content scaffold-create" role="main">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			<div class="row">
				<g:if test="${flash.message}">
					<div class="message" role="status">${flash.message}</div>
				</g:if>
				<g:hasErrors bean="${usuarioInstance}">
				<ul class="alert alert-danger col-md-8" role="alert">
					<g:eachError bean="${usuarioInstance}" var="error">
					<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
					</g:eachError>
				</ul>
				</g:hasErrors>
			</div>
			<g:form url="[resource:usuarioInstance, action:'save']" data-toggle="validator" >
				<fieldset class="form-horizontal" >
					<g:render template="form" />
				</fieldset>
				<fieldset class="buttons col-sm-offset-2">
					<g:submitButton name="create" class="btn btn-default" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
		</div>
		<script>
			$(document).ready( setNavBarLista("${entityName}")  );
		</script>
	</body>
</html>
