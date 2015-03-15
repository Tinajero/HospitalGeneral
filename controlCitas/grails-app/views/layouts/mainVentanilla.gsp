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
		<link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">
  		<asset:stylesheet src="application.css"/>
		<asset:javascript src="application.js"/>
		<asset:stylesheet src="dashboard.css"/>

<link rel="stylesheet" href="${resource(dir: 'css', file: 'wdCalendar/dailog.css')}" type="text/css">
<link rel="stylesheet" href="${resource(dir: 'css', file: 'wdCalendar/calendar.css')}" type="text/css">
<link rel="stylesheet" href="${resource(dir: 'css', file: 'wdCalendar/dp.css')}" type="text/css">
<link rel="stylesheet" href="${resource(dir: 'css', file: 'wdCalendar/alert.css')}" type="text/css">
<link rel="stylesheet" href="${resource(dir: 'css', file: 'wdCalendar/main.css')}" type="text/css">

		
  
    

		 <g:javascript src="utilerias.js" />
		 <g:javascript src="jquery1.4.js" />
		 <g:javascript src="wdCalendarPlugins/Common.js"/>
		 <g:javascript src="wdCalendarPlugins/datepicker_lang_US.js"/>
		 <g:javascript src="wdCalendarPlugins/jquery.datepicker.js"/>
		 <g:javascript src="wdCalendarPlugins/jquery.alert.js"/>
		 <g:javascript src="wdCalendarPlugins/jquery.ifrmdailog.js"/>
		 <g:javascript src="wdCalendarPlugins/wdCalendar_lang_US.js"/>
		 <g:javascript src="wdCalendarPlugins/jquery.calendar.js"/>
		 <g:javascript src="wdCalendarScript.js"/>
		 
		 //plugin jQuery-ui
		 <g:javascript src="jquery-ui-1.11.4.custom/external/jquery/jquery.js"/>
		 <g:javascript src="jquery-ui-1.11.4.custom/jquery-ui.css"/>
		 <g:javascript src="jquery-ui-1.11.4.custom/jquery-ui.js"/>
		 <g:javascript src="jquery-ui-1.11.4.custom/jquery-ui.min.css"/>
		 <g:javascript src="jquery-ui-1.11.4.custom/jquery-ui.min.js"/>
		 <g:javascript src="jquery-ui-1.11.4.custom/jquery-ui.structure.css"/>
		 <g:javascript src="jquery-ui-1.11.4.custom/jquery-ui.structure.min.css"/>
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
			 
			  <li><a href="/controlCitas/logout">Salir</a></li>
			</ul>
         
        </div>
      </div>
    </nav>
    
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">

            <li><g:link controller ="cita" action="create"><span class="glyphicon glyphicon-book" aria-hidden="true"></span> Citas</g:link></li>
            <li><g:link controller ="#"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> Busqueda</g:link></li>
            
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
