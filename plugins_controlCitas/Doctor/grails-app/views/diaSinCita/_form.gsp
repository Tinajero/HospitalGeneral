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
			optionValue="${{it.nombre + ' '+ it.apellidoPat + ' ' + it.apellidoMat  }}"
			required="true"
			
			class="form-control" />
	</div>

</div>

<div class="form-group">
    <label for="fechaInicio" class="col-sm-2 control-label">
		Fecha Inicio:
	</label>
    <span class="required-indicator">*</span>
    <div class="col-sm-4">
        <g:textField id="fechaInicio" class="form-control" name='fechaInicio'
         precision='day' value="${diaSinCitaInstance?.fechaInicio}" /><br>
    </div>
</div>

<div class="form-group">
    <label for="fechaFin" class="col-sm-2 control-label">
	    Fecha Fin:
	</label>    
    <div class="col-sm-4">
        <g:textField id="fechaFin" class="form-control" name='fechaFin'
         precision='day' value="${diaSinCitaInstance?.fechaFin}" /><br>
    </div>
</div>

	<script type="text/javascript">
		// Detalles en http://www.daterangepicker.com/#examples
		var locale = {
		    "format": "YYYY-MM-DD",
		    "separator": " - ",
		    "applyLabel": "Aplicar",
		    "cancelLabel": "Cancelar",
		    "fromLabel": "Desde",
		    "toLabel": "Hasta",
		    "customRangeLabel": "Personalizar",
		    "daysOfWeek": [
		        "Do",
		        "Lu",
		        "Ma",
		        "Mi",
		        "Ju",
		        "Vi",
		        "Sa"
		    ],
		    "monthNames": [
		        "Enero",
		        "Febrero",
		        "Marzo",
		        "Abril",
		        "Mayo",
		        "Junio",
		        "Julio",
		        "Agosto",
		        "Septiembre",
		        "Octubre",
		        "Noviembre",
		        "Diciembre"
		    ],
		    "firstDay": 1
		};

		$("input[id='fechaInicio']").daterangepicker({
		    "singleDatePicker": true,
		    "opens": "left",
		    "drops": "down",
		    "buttonClasses": "btn btn-sm",
		    "applyClass": "btn-success",
		    "cancelClass": "btn-default",
		    "format": "YYYY-MM-DD",
		    "locale": locale

        });
        
        $("input[id='fechaFin']").daterangepicker({
		    "singleDatePicker": true,
		    "opens": "left",
		    "drops": "down",
		    "buttonClasses": "btn btn-sm",
		    "applyClass": "btn-success",
		    "cancelClass": "btn-default",
		    "format": "YYYY-MM-DD",
		    "locale": locale

		});


	</script>
