
<%@ page import="doctor.Doctor" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainAdmin">
		<g:set var="entityName" value="${message(code: 'doctor.label', default: 'Doctor')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">
		<a href="#show-doctor" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-doctor" class="content scaffold-show" role="main">
			
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<div class="panel panel-default">
				<div class="panel-heading"><h1><g:message code="default.show.label" args="[entityName]" /></h1></div>
				<div class="panel-body">
<%--				<ol class="property-list doctor">--%>
					<table class="table table-bordered">
						<tbody>
							<g:if test="${doctorInstance?.nombre}">
							<tr>
								<td><span id="nombre-label" class="property-label"><g:message code="doctor.nombre.label" default="Nombre" /></span></td>
					
								<td>
									<span class="property-value" aria-labelledby="nombre-label">
										<g:fieldValue bean="${doctorInstance}" field="nombre"/>
									</span>
								</td>
					
							</tr>
							</g:if>
							
							<g:if test="${doctorInstance?.apellidoPat}">
							<tr>
								<td><span id="apellidoPat-label" class="property-label"><g:message code="doctor.apellidoPat.label" default="Apellido Paterno" /></span></td>
								
								<td>
									<span class="property-value" aria-labelledby="apellidoPat-label">
										<g:fieldValue bean="${doctorInstance}" field="apellidoPat"/>
									</span>
								</td>
							</tr>
							</g:if>
							
							<g:if test="${doctorInstance?.apellidoMat}">
							<tr>
								<td><span id="apellidoMat-label" class="property-label"><g:message code="doctor.apellidoMat.label" default="Apellido Materno" /></span></td>
					
								<td>
									<span class="property-value" aria-labelledby="apellidoMat-label">
										<g:fieldValue bean="${doctorInstance}" field="apellidoMat"/>
									</span>
								</td>
					
							</tr>
							</g:if>
							
							<g:if test="${doctorInstance?.tipoCita}">
							<tr>
								<td><span id="tipoCita-label" class="property-label"><g:message code="doctor.tipoCita.label" default="Tipo de Cita" /></span></td>
					
								<td>
									<span class="property-value" aria-labelledby="tipoCita-label">
										<g:fieldValue bean="${doctorInstance}" field="tipoCita"/>
									</span>
								</td>
							</tr>
							</g:if>
			
<%--							<g:if test="${doctorInstance?.diasLaborales}">--%>
<%--							<tr>--%>
<%--								<td><span id="diasLaborales-label" class="property-label"><g:message code="doctor.diasLaborales.label" default="Dias Laborales" /></span></td>--%>
<%--					--%>
<%--							</tr>--%>
<%--							</g:if>--%>
<%--			--%>
<%--							<g:if test="${doctorInstance?.diasNoLaborales}">--%>
<%--							<tr>--%>
<%--								<td><span id="diasNoLaborales-label" class="property-label"><g:message code="doctor.diasNoLaborales.label" default="Dias No Laborales" /></span></td>--%>
<%--					--%>
<%--							</tr>--%>
<%--							</g:if>--%>
<%--			--%>
<%--							<g:if test="${doctorInstance?.horario}">--%>
<%--							<tr>--%>
<%--								<td><span id="horario-label" class="property-label"><g:message code="doctor.horario.label" default="Horario" /></span></td>--%>
<%--					--%>
<%--							</tr>--%>
<%--							</g:if>--%>
			
						</tbody>
					</table>
	
					<g:form url="[resource:doctor, action:'delete']" method="DELETE">
						<fieldset class="buttons">
							<g:link class="edit" action="edit" resource="${doctorInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
							<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
						</fieldset>
					</g:form>
				</div>
			</div>
		</div>
	</div>
	</body>
</html>