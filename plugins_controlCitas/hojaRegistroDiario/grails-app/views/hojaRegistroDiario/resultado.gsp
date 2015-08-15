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
		<div>
			<span>PDF Generado</span>
			<div>
	    	<object data="consulta.pdf" type="application/pdf" width="300" height="200">
	        alt : <a href="consulta.pdf">test.pdf</a>
	    	</object>
			</div>
		</div>
	</body>


</html>
