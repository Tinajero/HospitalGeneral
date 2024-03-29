<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainAdmin">
		<g:set var="entityName" value="${message(code: 'doctor.label', default: 'M&eacute;dico')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">

		<div id="create-doctor" class="content scaffold-create" role="main">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${doctor}">
			<ul class="errors" role="alert">
				<g:eachError bean="${doctor}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:doctor, action:'save']" onkeypress="return event.keyCode != 13;" id="formularioDoctor" >
				<fieldset class="form-horizontal">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons col-sm-offset-4">
					<g:submitButton name="create" class="save" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
	</div>
	<script>
			$(document).ready( setNavBarLista("${entityName}")  );
	</script>
	</body>
</html>
