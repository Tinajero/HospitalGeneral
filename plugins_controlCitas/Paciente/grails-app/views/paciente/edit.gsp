<%@ page import="paciente.Paciente" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainVentanilla">
		<g:set var="entityName" value="${message(code: 'paciente.label', default: 'Paciente')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		
		<div id="edit-paciente" class="content scaffold-edit col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${paciente}">
			<ul class="errors" role="alert">
				<g:eachError bean="${paciente}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:pacienteInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${paciente?.version}" />
				<fieldset class="form form-horizontal cita-form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons col-sm-2 control-label" >
					</fieldset>
				<fieldset class="buttons col-sm-2 control-label">
					<g:actionSubmit class="save btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
