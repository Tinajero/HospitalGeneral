<%@ page import="paciente.Paciente" %>
<script> var autocompleteByExpediente = "${createLink(controller: 'cita', action:'autocompleteByExpediente')}" </script>

<div class="form-group ${hasErrors(bean: paciente, field: 'expediente', 'has-error')} required">
	<label for="expediente" class="col-sm-2 control-label">
		<g:message code="paciente.expediente.label" default="Expediente" />
		
	</label>
	<div class="col-sm-5">
		<g:textField id="a" name="paciente.expediente"  
				required="true" class="form-control" value="${pacienteInstance?.expediente}"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: paciente, field: 'nombre', 'has-error')} required">
	<label for="nombre" class="col-sm-2 control-label">
		<g:message code="paciente.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-5">
		<g:textField name="paciente.nombre" required="true" class="form-control" value="${pacienteInstance?.nombre}"/>
	</div>

</div>

<div class="form-group ${hasErrors(bean: paciente, field: 'apellidoPaterno', 'has-error')} required">
	<label for="apellidoPaterno" class="col-sm-2 control-label">
		<g:message code="paciente.apellidoPaterno.label" default="Apellido Paterno" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-5">
		<g:textField name="paciente.apellidoPaterno" required="true" class="form-control" value="${pacienteInstance?.apellidoPaterno}"/>
	</div>

</div>

<div class="form-group ${hasErrors(bean: paciente, field: 'apellidoMaterno', 'has-error')} required">
	<label for="apellidoMaterno" class="col-sm-2 control-label">
		<g:message code="paciente.apellidoMaterno.label" default="Apellido Materno" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-5">
		<g:textField name="paciente.apellidoMaterno" required="true" class="form-control" value="${pacienteInstance?.apellidoMaterno}"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: paciente, field: 'numeroTelefono', 'has-error')} ">
	<label for="numeroTelefono" class="col-sm-2 control-label">
		<g:message code="paciente.numeroTelefono.label" required="true" class="form-control" default="Numero Telefono" />		
	</label>
	<div class="col-sm-5">
		<g:textField id="paciente.telefono" type="tel" name="paciente.numeroTelefono" class="form-control" required="true"
		 value="${pacienteInstance?.numeroTelefono}"/>
	</div>

</div>

<div class="form-group ${hasErrors(bean: paciente, field: 'poblacion', 'has-error')} ">
	<label for="poblacion" class="col-sm-2 control-label">
		<g:message code="paciente.poblacion.label" default="Poblacion" required="true" class="form-control"/>
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-5">
		<g:textField id="poblacion" name="paciente.poblacion" class="form-control" required="" value="${pacienteInstance?.poblacion}"/>
	</div>

</div>

<div class="form-group ${hasErrors(bean: paciente, field: 'curp', 'has-error')} required">
	<label for="curp" class="col-sm-2 control-label">
		<g:message code="paciente.curp.label" default="Curp" />		
	</label>
	<div class ="col-sm-4">
		<g:textField id="curp" name="paciente.curp" class="form-control" pattern=".{18}" value="${pacienteInstance?.curp}"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: paciente, field: 'folioSeguroPopular', 'has-error')} required">
	<label for="folioSeguroPopular" class="col-sm-2 control-label">
		<g:message code="paciente.folioSeguroPopular.label" default="Folio Insabi" />
	</label>
	<div class ="col-sm-4">
		<g:textField id="folioSeguroPopular" name="paciente.folioSeguroPopular" class="form-control"  value="${pacienteInstance?.folioSeguroPopular}"/>
	</div>
</div>

