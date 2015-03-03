<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainVentanilla">
		<title> Hojas de registro diario</title>
	</head>

	<body>
		<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">
			<p> Introducir campos de b&uacute;squeda</p>

			<g:form  name = 'busquedaHDR' url = "[resource : hojaRegistroDiario, action : 'buscar']" >
				<g:datePicker name = 'fecha' precision='day' value = "${HojaRegistroDiario?.fecha}"/><br>
				<g:textField name='tipoCita' placeHolder= 'Tipo de cita' value ="${tipoCita}"/> <br>
				<g:submitButton name='buscar' value='Buscar datos'/>
			</g:form>
		</div>
	</body>

</html>
