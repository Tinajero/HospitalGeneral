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
				<td>Apellido paterno</td>
				<td>Apellido materno</td>
				<td>Nombre</td>
				<td>Expediente</td>
			</thead>

			<tbody>
				<g:each in="${lista}" status="${i}" var ="elemento">

						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
							<td>${elemento.ap_pat}</td>
							<td>${elemento.ap_mat}</td>
							<td> <g:link controller="paciente" action="show" id="${elemento.id}"> ${elemento.nombre}</g:link></td>

							<td> <g:link controller="paciente" action="show" id="${elemento.id}"> ${elemento.expediente} </g:link> </td>
						</tr>

				</g:each>
			</tbody>

		</table>
	</div>
	</body>

</html>
