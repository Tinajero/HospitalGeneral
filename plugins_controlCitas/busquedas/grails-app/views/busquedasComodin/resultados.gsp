<DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainVentanilla"/>
		<title>Resultados de la consulta</title>

	</head>
	<body>
	<div class="col-sm-20 col-md-10 col-sm-offset-3 col-md-offset-2 main">
		Los resultados obtenidos son:
		<div>
			<ul>
				<g:each in="${lista}" var ="elemento">
					<li>${elemento.fecha}</li>
					<li>${elemento.paciente}</li>
					<li>${elemento.doctor}</li>
					<li>${elemento.tipoCita}</li>
				</g:each>
			<ul>
		</div>
	</div>
	</body>

</html>
