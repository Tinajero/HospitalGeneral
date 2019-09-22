<%@ page import="doctor.DiaSinCita"%>



<div
	class="form-group ${hasErrors(bean: diaSinCita, field: 'medico', 'error')} required">
	
	<label for="medico" class="col-sm-2 control-label"> <g:message
			code="diaSinCita.medico.label" default="Medico" /> <span
		class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		<g:select id="medico" name="medico.id" 
			from="${doctor.Doctor.list()}"
			optionKey="id" required="" value="${diaSinCita?.medico?.id}"
			optionValue="${{  }}"
			required="true"
			
			class="form-control" />
		</div>

</div>

