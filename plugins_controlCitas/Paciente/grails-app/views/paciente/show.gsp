
<%@ page import="paciente.Paciente" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainVentanilla">
		<g:set var="entityName" value="${message(code: 'paciente.label', default: 'Paciente')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">
			<a href="#show-paciente" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
			<div class="nav" role="navigation">
				<ul>
					<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
					<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
					<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				</ul>
			</div>
			<div id="show-paciente" class="content scaffold-show" role="main">
				<h1><g:message code="default.show.label" args="[entityName]" /></h1>
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<ol class="property-list paciente">
				
					<g:if test="${pacienteInstance?.apellidoPaterno}">
					<li class="fieldcontain">
						<span id="apellidoPaterno-label" class="property-label"><g:message code="pacienteInstance.apellidoPaterno.label" default="Apellido Paterno" /></span>
						
							<span class="property-value" aria-labelledby="apellidoPaterno-label"><g:fieldValue bean="${pacienteInstance}" field="apellidoPaterno"/></span>
						
					</li>
					</g:if>
				
					<g:if test="${pacienteInstance?.apellidoMaterno}">
					<li class="fieldcontain">
						<span id="apellidoMaterno-label" class="property-label"><g:message code="pacienteInstance.apellidoMaterno.label" default="Apellido Materno" /></span>
						
							<span class="property-value" aria-labelledby="apellidoMaterno-label"><g:fieldValue bean="${pacienteInstance}" field="apellidoMaterno"/></span>
						
					</li>
					</g:if>
				
					<g:if test="${pacienteInstance?.nombre}">
					<li class="fieldcontain">
						<span id="nombre-label" class="property-label"><g:message code="pacienteInstance.nombre.label" default="Nombre" /></span>
						
							<span class="property-value" aria-labelledby="nombre-label"><g:fieldValue bean="${pacienteInstance}" field="nombre"/></span>
						
					</li>
					</g:if>
				
					<g:if test="${pacienteInstance?.expediente}">
					<li class="fieldcontain">
						<span id="expediente-label" class="property-label"><g:message code="pacienteInstance.expediente.label" default="Expediente" /></span>
						
							<span class="property-value" aria-labelledby="expediente-label"><g:fieldValue bean="${pacienteInstance}" field="expediente"/></span>
						
					</li>
					</g:if>
				
					<g:if test="${pacienteInstance?.numeroTelefono}">
					<li class="fieldcontain">
						<span id="numeroTelefono-label" class="property-label"><g:message code="pacienteInstance.numeroTelefono.label" default="Numero Telefono" /></span>
						
							<span class="property-value" aria-labelledby="numeroTelefono-label"><g:fieldValue bean="${pacienteInstance}" field="numeroTelefono"/></span>
						
					</li>
					</g:if>
				
					<g:if test="${pacienteInstance?.poblacion}">
					<li class="fieldcontain">
						<span id="poblacion-label" class="property-label"><g:message code="pacienteInstance.poblacion.label" default="Poblacion" /></span>
						
							<span class="property-value" aria-labelledby="poblacion-label"><g:fieldValue bean="${pacienteInstance}" field="poblacion"/></span>
						
					</li>
					</g:if>
				
				</ol>
				<g:form url="[resource:paciente, action:'delete']" method="DELETE">
					<fieldset class="buttons">
						<g:link class="edit" action="edit" resource="${paciente}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
			</div>
		</div>
	</body>
</html>
