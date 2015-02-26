<%@ page import="cita.Cita" %>



<div class="fieldcontain ${hasErrors(bean: cita, field: 'doctor', 'error')} required">
	<label for="doctor">
		<g:message code="cita.doctor.label" default="Doctor" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="doctor" name="doctor.id" from="${doctor.Doctor.list()}" optionKey="id" required="" value="${cita?.doctor?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: cita, field: 'fecha', 'error')} required">
	<label for="fecha">
		<g:message code="cita.fecha.label" default="Fecha" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="fecha" precision="day"  value="${cita?.fecha}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: cita, field: 'paciente', 'error')} required">
	<label for="paciente">
		<g:message code="cita.paciente.label" default="Paciente" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="paciente" name="paciente.id" from="${paciente.Paciente.list()}" optionKey="id" required="" value="${cita?.paciente?.id}" class="many-to-one"/>

</div>

