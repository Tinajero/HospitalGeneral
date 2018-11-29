
<%@ page import="cita.Cita"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="mainVentanilla">
<g:set var="entityName"
	value="${message(code: 'cita.label', default: 'Cita')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
	<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">
		<div id="show-cita" class="content scaffold-show" role="main">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h1>
						<g:message code="default.show.label" args="[entityName]" />
					</h1>
					<g:if test="${flash.message}">
						<div class="message" role="status">
							${flash.message}
						</div>
					</g:if>
				</div>
				<div class="panel-body">
					<table class="table table-bordered">
						<tbody>
							<g:if test="${citaInstance?.doctor}">
								<tr>
									<td style="width: 15%;"><span id="doctor-label"
										class="property-label"> <g:message
												code="cita.doctor.label" default="Doctor" />
									</span></td>
									<td><span class="property-value"
										aria-labelledby="doctor-label"> <b> ${citaInstance?.doctor?.nombre.encodeAsHTML()}
												${citaInstance?.doctor?.apellidoPat.encodeAsHTML()} ${citaInstance?.doctor?.apellidoMat.encodeAsHTML()}
										</b>
									</span></td>
								</tr>
								<tr>
									<td style="width: 15%;">
										<span id="doctor-label"
											class="property-label"> <g:message
													code="cita.doctor.label" default="Tipo de Cita" />
										</span>
									</td>
									<td>
										${ citaInstance?.tipoCita == 0?'Primera Vez':'Subsecuente' }
									</td>
								</tr>
							</g:if>

							<g:if test="${citaInstance?.fecha}">
								<tr>
									<td>
										<span id="fecha-label"
											class="property-label"><g:message
													code="cita.fecha.label" default="Fecha" /></span>
									</td>
									<td><span class="property-value"
										aria-labelledby="fecha-label"><g:formatDate
												format="EEEE dd 'de' MMMM yyyy"
												date="${citaInstance?.fecha}" /></span></td>
								<tr>
							</g:if>

							<g:if test="${citaInstance?.fecha}">
								<tr>
									<td>
										<span id="fecha-label"
											class="property-label"><g:message
													code="cita.fecha.label" default="Hora" /></span>
									</td>
									<td><span class="property-value"
										aria-labelledby="fecha-label"><g:formatDate
												format="HH:mm" date="${citaInstance?.fecha}" /></span></td>
								<tr>
							</g:if>

							<g:if test="${citaInstance?.paciente}">
								<tr>
									<td>
										<span id="paciente-label"
											class="property-label"><g:message
													code="cita.paciente.label" default="Expediente de Paciente" /></span>
									
									</td>
									<td><span class="property-value"
										aria-labelledby="paciente-label"><g:link
												controller="paciente" action="show"
												id="${citaInstance?.paciente?.id}">
												${citaInstance?.paciente?.expediente.encodeAsHTML()}
											</g:link></span></td>

								</tr>

								<tr>
									<td>
										<span id="paciente-label"
											class="property-label"> <g:message
													code="cita.paciente.label"
													default="Tel&eacute;fono del Paciente" />
										</span>
									</td>
									<td><span class="property-value"
										aria-labelledby="paciente-label"> ${citaInstance?.paciente?.numeroTelefono.encodeAsHTML()}
									</span></td>
								</tr>
								<tr>
									<td>
										<span id="paciente-label"
											class="property-label"> <g:message
													code="cita.paciente.label" default="Localidad del Paciente" />
										</span>
									</td>
									<td><span class="property-value"
										aria-labelledby="paciente-label"> ${citaInstance?.paciente?.poblacion.encodeAsHTML()}
									</span></td>

								</tr>
							</g:if>

							<g:if test="${citaInstance?.paciente}">
								<tr>
									<td>
										<span id="paciente-label"
											class="property-label"><g:message
													code="cita.paciente.label" default="Paciente" /></span>
									</td>
									<td><span class="property-value"
										aria-labelledby="paciente-label"><g:link
												controller="paciente" action="show"
												id="${citaInstance?.paciente?.id}">
												${citaInstance?.paciente?.nombre.encodeAsHTML()}
												${citaInstance?.paciente?.apellidoPaterno.encodeAsHTML()}
												${citaInstance?.paciente?.apellidoMaterno.encodeAsHTML()}
											</g:link></span></td>
								</tr>
							</g:if>


						</tbody>
					</table>
				</div>
				<div class="panel-footer">
					<g:form url="[resource:citaInstance, action:'delete']"
						method="DELETE">
						<fieldset class="buttons">
							<g:link class="btn btn-info" action="edit"
								id="${citaInstance.id}">
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
