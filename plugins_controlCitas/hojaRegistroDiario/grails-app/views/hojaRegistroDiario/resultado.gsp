<!DOCTYPE html>
<html>

	<head>
		<meta name="layout" content="mainVentanilla">
		<title> Resultado HDR</title>
	</head>

	<body>
		<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">
			<p>Los resultados obtenidos son:</p>

			<ul>
				<g:each in="${lista}" var ="elemento">
					<li>${elemento}</li>
				</g:each>
			</ul>
		</div>

	</body>


</html>