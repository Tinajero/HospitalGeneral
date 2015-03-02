<%@ page import="cita.Cita" %>


<div class="form-group ${hasErrors(brean: paciente, field: expediente, 'has error')} required">
	<label for="expediente" class="col-sm-2 control-label">
		<g:message code="cita.paciente.label" default='Expediente'/>
		<span class="required-indicator">*</span>
	</label>
	<div class ="col-sm-4">
		<g:textField name="expediente" class="form-control" required="" value="${cita?.paciente?.expediente}"/>
	</div>
</div>

<div class="form-group ${hasErrors(brean: paciente, field: nombre, 'has error')} required">
	<label for="apellidoPaterno" class="col-sm-2 control-label">
		<g:message code="cita.paciente.nombre.label" default="Paciente" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-2">
		<g:textField name="apellidoPaterno" class="form-control" required="" placeholder="Apellido Paterno" value="${cita?.paciente?.apellidoPaterno}"/>
	</div>
	<div class="col-sm-2">
		<g:textField name="apellidoMaterno" class="form-control" required="" placeholder="Apellido Materno" value="${cita?.paciente?.apellidoMaterno}"/>
	</div>
	<div class="col-sm-2">
		<g:textField name="nombre" class="form-control" required="" placeholder="Nombre(s)" value="${cita?.paciente?.apellidoMaterno}"/>
	</div>
</div>

<div class="form-group ${hasErrors(brean: paciente, field: poblacion, 'has error')} required">
	<label for="Poblacion" class="col-sm-2 control-label">
		<g:message code="cita.paciente.poblacion.label" default="Poblacion" />
		<span class="required-indicator">*</span>
	</label>
	<div class ="col-sm-4">
		<g:textField name="poblacion" class="form-control" required="" value="${cita?.paciente?.poblacion}"/>
	</div>
</div>

<div class="form-group ${hasErrors(brean: paciente, field: telefono, 'has error')} required">
	<label for="Telefono" class="col-sm-2 control-label">
		<g:message code="cita.paciente.telefono.label" default="Telefono" />
		<span class="required-indicator">*</span>
	</label>
	<div class ="col-sm-4">
		<input type="tel" name="numeroTelefono" class="form-control" required="" value="${cita?.paciente?.poblacion}"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: cita, field: 'doctor', 'has error')} required">
	<label for="Tipo Cita" class="col-sm-2 control-label">
		<g:message code="cita.doctor.label" default="Tipo de cita" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		<g:select id="doctor" name="doctor.tipoCita" from="${doctor.Doctor.list()}" optionKey="tipoCita" optionValue="tipoCita"required="" value="cita?.doctor?.tipoCita}" class="form-control"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: cita, field: 'doctor.nombre', 'error')} required">
	<label for="Doctor" class="col-sm-2 control-label">
		<g:message code="cita.doctor.label" default="Medico" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		<g:select id="doctor" name="doctor.id" from="${doctor.Doctor.list()}" optionKey="nombre" optionValue="nombre" required="" value="cita?.doctor?.nombre}" class="many-to-one form-control"/>
	</div>
</div>


<!-- <div class="fieldcontain ${hasErrors(bean: cita, field: 'fecha', 'error')} required">
	<label for="fecha" class="col-sm-2 control-label">
		<g:message code="cita.fecha.label" default="Fecha" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		<g:datePicker name="fecha" precision="day"  value="${cita?.fecha}"  />
	</div>	
</div> -->

<!-- <div class="fieldcontain ${hasErrors(bean: cita, field: 'paciente', 'error')} required">
	<label for="paciente">
		<g:message code="cita.paciente.label" default="Paciente" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="paciente" name="paciente.id" from="${paciente.Paciente.list()}" optionKey="id" required="" value="${cita?.paciente?.id}" class="many-to-one"/>

</div> -->

