<%@ page import="paciente.Paciente" %>



<div class="fieldcontain ${hasErrors(bean: paciente, field: 'apellidoPaterno', 'error')} required">
	<label for="apellidoPaterno">
		<g:message code="paciente.apellidoPaterno.label" default="Apellido Paterno" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="apellidoPaterno" required="" value="${paciente?.apellidoPaterno}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: paciente, field: 'apellidoMaterno', 'error')} required">
	<label for="apellidoMaterno">
		<g:message code="paciente.apellidoMaterno.label" default="Apellido Materno" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="apellidoMaterno" required="" value="${paciente?.apellidoMaterno}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: paciente, field: 'nombre', 'error')} required">
	<label for="nombre">
		<g:message code="paciente.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nombre" required="" value="${paciente?.nombre}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: paciente, field: 'expediente', 'error')} required">
	<label for="expediente">
		<g:message code="paciente.expediente.label" default="Expediente" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="expediente" pattern="${paciente.constraints.expediente.matches}" required="" value="${paciente?.expediente}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: paciente, field: 'numeroTelefono', 'error')} ">
	<label for="numeroTelefono">
		<g:message code="paciente.numeroTelefono.label" default="Numero Telefono" />
		
	</label>
	

</div>

<div class="fieldcontain ${hasErrors(bean: paciente, field: 'poblacion', 'error')} ">
	<label for="poblacion">
		<g:message code="paciente.poblacion.label" default="Poblacion" />
		
	</label>
	

</div>

