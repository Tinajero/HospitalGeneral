
<%@ page import="doctor.DiaSinCita"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="mainAdmin">
<g:set var="entityName"
	value="${message(code: 'diaSinCita.label', default: 'DiaSinCita')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
	<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">
		
		<div id="show-diaSinCita" class="content scaffold-show" role="main">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h1>
						<g:message code="default.show.label" args="[entityName]" />
					</h1>
				</div>
				<div  class="panel-body">
				<g:if test="${flash.message}">
					<div class="message" role="status">
						${flash.message}
					</div>
				</g:if>
				<table class="table table-bordered">
					<tbody>
						<tr>
							<td>
								<span id="nombre-label" class="property-label">
									<g:message code="diaSinCita.medico.nombre.label" default="Medico" />
								</span>
							</td>
							<td>
								<span class="property-value" aria-labelledby="nombre-label">
										<g:fieldValue bean="${diaSinCitaInstance}" field="medico.nombre"/>
										<g:fieldValue bean="${diaSinCitaInstance}" field="medico.apellidoPat"/>
										<g:fieldValue bean="${diaSinCitaInstance}" field="medico.apellidoMat"/>
								</span>
							</td>
						</tr>	
						<tr>
							<td>
								<span id="nombre-label" class="property-label">
									<g:message code="diaSinCita.fechaInicio" default="fecha Inicio" />
								</span>
							</td>
							<td>
								<span class="property-value" aria-labelledby="nombre-label">
									<g:formatDate
												format="EEEE dd 'de' MMMM yyyy"
												date="${diaSinCitaInstance?.fechaInicio}"/>										
								</span>
							</td>
						</tr>	
						<tr>
							<td>
								<span id="nombre-label" class="property-label">
									<g:message code="diaSinCita.fechaInicio" default="fecha Fin" />
								</span>
							</td>
							<td>
								<span class="property-value" aria-labelledby="nombre-label">
									<g:formatDate
												format="EEEE dd 'de' MMMM yyyy"
												date="${diaSinCitaInstance?.fechaFin}" field="fechaFin"/>										
								</span>
							</td>
						</tr>	
					</tbody>
				</table>	
				<g:form url="[resource:diaSinCitaInstance, action:'delete']" method="DELETE">
					<fieldset class="buttons">
						<g:link class="btn btn-info" action="edit" resource="${diaSinCitaInstance}">
							<g:message code="default.button.edit.label" default="Edit" />
						</g:link>
						<g:actionSubmit class="btn btn-danger" action="delete"
							value="${message(code: 'default.button.delete.label', default: 'Delete')}"
							onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
