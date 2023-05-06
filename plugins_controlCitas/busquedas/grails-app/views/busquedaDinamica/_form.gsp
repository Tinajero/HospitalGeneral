<%@ page contentType="text/html;charset=UTF-8" %>
<g:set name= '' var="servicioService" bean="servicioService"/>
<div class="form-group">
    <label for="fechaInicio" class="col-sm-2 control-label">
		Fecha Inicio:
	</label>
    <span class="required-indicator">*</span>
    <div class="col-sm-4">
        <g:textField id="fechaInicio" class="form-control" name='fechaInicio'
         precision='day' value="${HojaRegistroDiario?.fecha}" /><br>
    </div>
</div>

<div class="form-group">
    <label for="fechaFin" class="col-sm-2 control-label">
	    Fecha Fin:
	</label>    
    <div class="col-sm-4">
        <g:textField id="fechaFin" class="form-control" name='fechaFin'
         precision='day' value="${HojaRegistroDiario?.fecha}" /><br>
    </div>
</div>

<div class="form-group">
    <label for="Turno" class="col-sm-2 control-label">
		Turno
	</label>    
    <div class="col-sm-2">
        <input type="checkbox" id="turno" name="turnoMatutino"> 
        <label for="turno" class="control-label">
        	Matutino
        </label>
    </div>
    <div class="col-sm-2">
        <input type="checkbox" id="turnoVespertino" name="turnoVespertino"> 
         <label for="turnoVespertino" class="control-label">
        	Vespertino
        </label>
    </div>
</div>

<div class="form-group">
	<div class="row">	
		<label class="col-sm-2 control-label">
			Servicio:
		</label>	
		<div class="col-sm-4">
		<g:select id="servicios" class="form-control" name="servicios" 
			from="${servicioService.listaTiposCita()}" 
			optionKey="id" 
			value="${servicio*.id}"
			optionValue="nombre" 
			multiple="true"
			noSelection="['null': '']"/>
	</div>
	</div>
<%--	<g:each in="${servicioService.listaTiposCita()}" var="servicio" status="i">--%>
<%--		--%>
<%--		<g:if test="${(i % 2) != 0}">--%>
<%--			<div class="row">--%>
<%--		</g:if>			--%>
<%--			<div class="col-sm-2 ${( (i % 2) == 0) ? 'col-sm-offset-3 col-md-offset-2': ''}">--%>
<%--				<label><input type="checkbox" name="optradio_${servicio.id}">${servicio.nombre}</label> --%>
<%--			</div>--%>
<%--		<g:if test="${(i % 2) != 0}">	--%>
<%--			</div>--%>
<%--		</g:if>--%>
<%--	</g:each>--%>

	
</div>

<div class="form-group">
	<div class="row">	
		<label class="col-sm-2 control-label">
			Datos a Mostrar:
		</label>	
	</div>
	
	<div class="row">
		<div class="col-sm-4 col-sm-offset-3 col-md-offset-2">
			<label><input type="checkbox" name="Hora">Hora</label> 
		</div>
	</div>

	<div class="row">
		<div class="col-sm-4 col-sm-offset-3 col-md-offset-2">
			<label><input type="checkbox" name="nombrePacienteCheck">Nombre del Paciente</label> 
		</div>
	</div>

	<div class="row">
		<div class="col-sm-4 col-sm-offset-3 col-md-offset-2">
			<label><input type="checkbox" name="Localidad">Localidad</label> 
		</div>
	</div>

	<div class="row">
		<div class="col-sm-4 col-sm-offset-3 col-md-offset-2">
			<label><input type="checkbox" name="telefonoCheck">Tel&eacute;fono</label> 
		</div>
	</div>

	
	<div class="row">
		<div class="col-sm-4 col-sm-offset-3 col-md-offset-2">
			<label><input type="checkbox" name="nombreDoctorCheck">M&eacute;dico</label> 
		</div>
	</div>
	
	<div class="row">
		<div class="col-sm-4 col-sm-offset-3 col-md-offset-2">
			<label><input type="checkbox" name="numeroExpedientePacienteCheck">Expediente Paciente </label> 
		</div>
	</div>
			
</div>

<%--
<div class="form-group">
    <label class="col-sm-2 control-label">
		Mostrar citas libres como espacios en blanco
	</label>    
    <div class="col-sm-1">
        <input type="radio" name="mostrarEnBlanco"> Sí
    </div>
    <div class="col-sm-1">
        <input type="radio" name="mostrarEnBlanco"> No
    </div>
</div>
--%>

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

