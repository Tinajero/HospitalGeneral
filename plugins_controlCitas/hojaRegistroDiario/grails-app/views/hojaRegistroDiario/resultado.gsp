<!DOCTYPE html>
<html>

	<head>
		<meta name="layout" content="mainVentanilla">
		<title>Hoja de Registro Diario </title>
	</head>
	<body>

		<div class="col-sm-20 col-md-10 col-sm-offset-3 col-md-offset-2 main">
			<p>Resultados de tu b&uacute;squeda:</p>

			<g:if test="${lista[0] == 0}">
			  	Lo sentimos, no se encontro informaci&oacute;n para los datos:
				</br>Fecha: ${lista[1]}
				</br>Tipo de cita: ${lista[2]}
				</br>Doctor:
				</br>Paciente:
				</br>
			</g:if>
			<g:else>
			   Se encontro la siguiente información para:
			 </br>Fecha: ${lista[1]} y
			 </br>Tipo de cita: ${lista[2]}
		 	</br>
				 <div class="">
	 				<object data="http://localhost:8080/controlCitas/temp_pdf/consulta.pdf" type="application/pdf" width="100%" height="600px">
	 					<p>Parece ser que no puedes visualizar el pdf. Click para descargar <a href="http://localhost:8080/controlCitas/pdf/consulta.pdf">consulta.pdf</a></p>

	 				</object>
	 			</div>
			</g:else>

		</div>
	</body>


</html>
