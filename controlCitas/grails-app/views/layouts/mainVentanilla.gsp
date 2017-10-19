<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Ventanilla"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${resource(dir:"images", file: "iconoSecretaria.ico") }" type="image/x-icon">
		<!-- <link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}"> -->
  		<asset:stylesheet src="application.css"/>
		<asset:javascript src="application.js"/>
		<asset:stylesheet src="dashboard.css"/>

		 <!-- plugin jQuery-ui -->		
		 <g:javascript src="jquery-ui-1.11.4.custom/jquery-ui.css"/>
		 <g:javascript src="jquery-ui-1.11.4.custom/jquery-ui.js"/>
		 <g:javascript src="jquery-ui-1.11.4.custom/jquery-ui.min.css"/>
		 <g:javascript src="jquery-ui-1.11.4.custom/jquery-ui.min.js"/>
		 <g:javascript src="jquery-ui-1.11.4.custom/jquery-ui.structure.css"/>
		 <g:javascript src="jquery-ui-1.11.4.custom/jquery-ui.structure.min.css"/>

		 <!-- plugin jQuery-mask para mask en los inputs de Expediente y Telefono en Citas -->
		 <g:javascript src="jquery-mask/jquery.mask.js"/>
		 <!-- fullCallendar plugin dependences-->
    	<link rel="stylesheet" href="${resource(dir: 'js', file: 'fullcalendar-2.3.1/fullcalendar.css')}" type="text/css">
    	 <g:javascript src="fullcalendar-2.3.1/lib/moment.min.js"/>
    	 <g:javascript src="fullcalendar-2.3.1/fullcalendar.js"/>
    	 <g:javascript src="fullcalendar-2.3.1/lang/es.js"/>
    	 <!-- end fullCallendar plugin dependences -->

		 <g:javascript src="utilerias.js" />
		 <!-- Js de las funciones utilizadas en la vista de creacion de citas -->		
		 

		 <!--  Estilos usados en la vista de citas-->
		 <link rel="stylesheet" href="${resource(dir: 'css', file: 'citaEstilos.css')}" type="text/css">

		 <link rel="stylesheet" href="${resource(dir: 'css', file: 'daterangepicker.css')}" type="text/css">


		 <g:javascript src="funcionesCita.js"/>
		 <!-- script usados para el autocomplete de la vista de creacion Citas-->
		 <g:javascript src="autoCompleteMax.js"/>

		<g:javascript src="daterangepicker.js"/>

		<g:layoutHead/>
	</head>
	<body>
		    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
<%--          <a class="home" href="${createLink(uri: '/')}">--%>
          <a class="navbar-brand" href="${createLink(uri: '/')}"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> <b> Ventanilla</b> </a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
	        <ul class="nav navbar-nav" id="contenedorNavbarPrincipal">
<%--	        	<li><a href="#">Casdn</a></li>--%>
	        </ul>
			<ul class="nav navbar-nav navbar-right">

			  <li><g:link controller='logout'>Salir</g:link></li>
			</ul>

        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">

            <li><g:link controller ="cita" action="create"><span class="glyphicon glyphicon-book" aria-hidden="true"></span> Citas</g:link></li>
						<li><g:link controller ="hojaRegistroDiario" action=""><span class="glyphicon glyphicon-book" aria-hidden="true"></span> Hojas de registro diario</g:link></li>
						<li><g:link controller ="busquedasComodin"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> Busqueda</g:link></li>
						<li><g:link controller ="BusquedaDinamica" action="busqueda"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> Busqueda Dinamica</g:link></li>

          </ul>
        </div>
<%--		<div id="grailsLogo" role="banner"><a href="http://grails.org"><asset:image src="grails_logo.png" alt="Grails"/></a></div>--%>
		<g:layoutBody/>

		</div>
	</div>
<%--		<div class="footer" role="contentinfo"></div>--%>
<%--		<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>--%>
  	<div class="row">
		<div class="col-sm-7 col-md-8">
			<footer class="blog-footer">
      		<div class="container">
      			Esto es el footer
	  		</div>
    	</footer>
	</div>
</div>

</body>
</html>
