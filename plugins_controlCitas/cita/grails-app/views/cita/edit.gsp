<%@ page import="cita.Cita" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainVentanilla">
		<g:set var="entityName" value="${message(code: 'cita.label', default: 'Cita')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">				
			<div id="edit-cita" class="content scaffold-edit cita" role="main">
				<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>	
				<g:hasErrors bean="${citaInstance}">
				<ul class="errors" role="alert">
					<g:eachError bean="${citaInstance}" var="error">
					<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
					</g:eachError>
				</ul>
				</g:hasErrors>
				
				<g:form url="[resource:citaInstance, action:'update']" method="PUT" onkeypress="return event.keyCode != 13;"  id="formularioCita">
					<g:hiddenField name="version" value="${citaInstance?.version}" />
					<fieldset class="form-horizontal cita-form">
						<g:render template="form"/>
					</fieldset>
<%--					<fieldset class="buttons col-sm-offset-2 cita-buttons">--%>
					<div class="col-sm-2 control-label"></div>
					<div class="col-sm-2">
						<g:actionSubmit class=" save btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
<%--					</fieldset>--%>
					</div>
				</g:form>
				<div class="row">
					<div id='calendar' class="col-sm-offset-1 col-xs-offset-0 calendar"></div>
				</div>
			</div>
		</div>
	</body>
</html>
