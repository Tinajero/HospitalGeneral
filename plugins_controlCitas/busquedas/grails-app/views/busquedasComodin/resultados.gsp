<DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainVentanilla"/>
		<title>Resultados de la consulta</title>

	</head>
	<body>
	<div class="col-sm-20 col-md-10 col-sm-offset-3 col-md-offset-2 main">
		Los resultados obtenidos son:

		<table class="table table-striped">
			<thead style="color: blue;">
				<td>Fecha</td>
				<td>Paciente</td>
				<td>Doctor</td>
				<td>Tipo de cita</td>
			</thead>

			<tbody>
				<g:each in="${lista}" status="${i}" var ="elemento">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
							<td>${elemento.fecha}</td>
							<td><g:link controller="paciente" action="show" id="${elemento.id}">${elemento.paciente}</g:link></td>
							<td>${elemento.doctor}</td>
							<td>${elemento.tipoCita}</td>
						</tr>
				</g:each>
			</tbody>

		</table>
	</div>
	</body>

</html>
