<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainVentanilla">
		<title> Hojas de registro diario</title>

	</head>

	<body>
	<script> var getTipoCitaCambiadaPath = "${createLink(action:'tipoCitaCambiada')}" </script>
		<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">
			<p>Introduzca una fecha para generar la HDR, los dem&aacute;s campos son opcionales. </p>
	<fieldset class="form-horizontal">
			<g:form  name = 'busquedaHDR' url = "[resource : hojaRegistroDiario, action : 'buscar']" >

				<div class="form-group">
						<label for="fecha" class="col-sm-2 control-label">
						Fecha de b&uacute;squeda:
						</label>
						<span class="required-indicator">*</span>
						<div class="col-sm-4">
							<g:textField id="date" class="form-control" name = 'fecha' precision='day' value = "${HojaRegistroDiario?.fecha}"/><br>
						</div>
				</div>

<%--				<div class="form-group">--%>
<%--					<label for="tipoCita" class="col-sm-2 control-label">--%>
<%--					Servicio (opcional):--%>
<%--					</label>--%>
<%--					<div class="col-sm-4">--%>
<%--						<g:textField class="form-control" name='tipoCita' placeHolder= 'Servicio' value ="${tipoCita}"/> <br>--%>
<%--					</div>--%>
<%--				</div>--%>
				
				<%--	Esto es lo nuevo	--%>
				<div class="form-group ${hasErrors(bean: cita, field: 'doctor', 'has-error')}">
					<label for="TipoCita" class="col-sm-2 control-label">
						<g:message code="cita.doctor.label" default="Servicio" />
						
					</label>
					<div class="col-sm-4">
				    <g:select id="TipoCita" name="tipoCita" from="${doctor.Doctor.listUnique()}" 
					value="${tipoCita}" class="form-control" noSelection="['':'']" onchange="obtenerDoctoresPorServicio();"/>
					</div>
				</div>
				
				<div class="form-group ${hasErrors(bean: cita, field: 'doctor.nombre', 'has-error')}">
					<label for="Doctor" class="col-sm-2 control-label">
						<g:message code="cita.doctor.label" default="Medico" />
						
					</label>
					<div class="col-sm-4">
				    <span id="subContainer"> </span>
				
				
					</div>
				</div>

				<fieldset class="buttons col-sm-offset-2">
					<g:submitButton name='buscar' value='Buscar datos' class="btn btn-primary"/>
				</fieldset>
			</g:form>
		</fieldset>

		</div><!--div body-->
		<g:javascript>
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

		$("input[id='date']").daterangepicker({
		    "singleDatePicker": true,
		    "opens": "left",
		    "drops": "down",
		    "buttonClasses": "btn btn-sm",
		    "applyClass": "btn-success",
		    "cancelClass": "btn-default",
		    "format": "YYYY-MM-DD",
		    "locale": locale

		});

		

		</g:javascript>

	</body>
</html>
