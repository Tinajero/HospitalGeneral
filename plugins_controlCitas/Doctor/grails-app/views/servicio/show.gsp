
<%@ page import="doctor.Servicio" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainAdmin">
		<g:set var="entityName" value="${message(code: 'servicio.label', default: 'Servicio')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">
			
			<div id="show-servicio" class="content scaffold-show" role="main">
				<h1><g:message code="default.show.label" args="[entityName]" /></h1>
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
	
					<table class="table table-bordered">							
						<g:if test="${servicioInstance?.nombre}">
							<tr >
								<td style="width: 15%;">
									<span id="nombre-label" class="property-label"><g:message code="servicio.nombre.label" default="Nombre" /></span>
								</td>
								<td>
									<span class="property-value" aria-labelledby="nombre-label">
										<g:fieldValue bean="${servicioInstance}" field="nombre"/>
									</span>
								</td>
							</tr>
						</g:if>
					
						<g:if test="${servicioInstance?.subServicios}">
							<tr >
								<td>
									<span id="subServicio-label" class="property-label"><g:message code="servicio.subServicios.label" default="Sub Servicios" /></span>
								</td>
								<td>
									<span class="property-value" aria-labelledby="subServicio-label"><g:link controller="servicio" action="show" 
									id="${servicioInstance?.subServicios?.id}">${servicioInstance?.subServicios?.encodeAsHTML()}</g:link></span>
								</td>
							</tr>
						</g:if>
					
						<g:if test="${servicioInstance?.descripcion}">
							
							<tr>
								<td>
								<span id="descripcion-label" class="property-label">
									<g:message code="servicio.descripcion.label" default="Descripcion" /></span>
								</td>
								<td>
									<span class="property-value" aria-labelledby="descripcion-label">
									<g:fieldValue bean="${servicioInstance}" field="descripcion"/>
									</span>
								</td>
								
							</tr>
						</g:if>
				
					
				
				</table>
				<g:form url="[resource:servicio, action:'delete']" method="DELETE">
					<fieldset class="buttons">
						<g:link class="btn btn-info" action="edit" resource="${servicioInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="delete  btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" 
						onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
			</div>
		</div>
	</body>
</html>
