
<%@ page import="busquedas.BusquedasComodin" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainVentanilla">
		<g:set var="entityName" value="${message(code: 'busquedasComodin.label', default: 'BusquedasComodin')}" />
		<title>Busqueda de informaci&oacute;n<g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">
			<fieldset class="form-horizontal">
				<!-- resource indica el nombre del paquete donde esta la acccion a ejecutar-->
				<div>
					<p>	Favor de introducir el nombre del paciente con apellidos antes de iniciar la b&uacute;squeda.</p>
					<br/>
						<p>Nota: Tambien puede dejar nombres y apellidos incompletos sin introducir para ampliar la b&uacute;squeda.</p>
					<br/>
				</div>
					<g:form name="busquedas" url="[resource:busquedas, action:'buscar' ]">

						<div class="form-group">
						<!-- busquedas por nombre-->
							<label for="Paciente" class="col-sm-2 control-label">
							Nombre del paciente:
							</label>
							<div class="col-sm-3">
								<g:textField class="form-control" name='p_nombre' placeHolder= 'Nombre (s)' value ="${p_nombre}"/> <br>
							</div>
							<div class="col-sm-3">
								<g:textField class="form-control" name='p_ap_pat' placeHolder= 'Apellido paterno' value ="${p_ap_pat}"/> <br>
							</div>
							<div class="col-sm-3">
								<g:textField class="form-control" name='p_ap_mat' placeHolder= 'Apellido Materno' value ="${p_ap_mat}"/> <br>
							</div>
						</div>
						
						<div class="form-group">
							<label for="expediente" class="col-sm-2 control-label">
							Expediente:
							</label>
							<div class="col-sm-3">
								<g:textField class="form-control" id="expediente_textField" 
									name='expediente' placeHolder= 'Número de expediente' value ="${expediente}"/> <br>
							</div>
						
						</div>

						<!-- Por Nombre del doctor--
						<div class="form-group">
							<label for="Doctor" class="col-sm-2 control-label">
							Nombre del doctor:
							</label>
							<div class="col-sm-4">
								<g:textField class="form-control" name='Doctor' placeHolder= 'Nombre' value ="${tipoCita}"/> <br>
							</div>
						</div>
						-->
						<!--boton para llamar al formularipo-->
						<fieldset class="buttons col-sm-offset-2">
							<g:submitButton name='buscar' value='Iniciar búsqueda' class="btn btn-primary"/>
						</fieldset>

					</g:form>
			</fieldset>

		</div><!-- end div post body-->
		<g:javascript>
		//Modificacion de datos, se usa el script datepicker.js
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
