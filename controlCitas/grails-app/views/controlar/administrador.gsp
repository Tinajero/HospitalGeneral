<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<asset:stylesheet src="dashboard.css"/>
		
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
          <a class="navbar-brand" href="#"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> <b>Administración del Sistema</b> </a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="#">Configuración</a></li>
            <li><a href="logout">Salir</a></li>
          </ul>
         
        </div>
      </div>
    </nav>
    
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li><a href="usuario"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Usuarios</a></li>
            <li><a href="#"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Doctores</a></li>
            
          </ul>
        </div>
        <div class="col-sm-7 col-md-8 col-sm-offset-3 col-md-offset-2 main">
        <div class="bs-docs-section">
  				<h1 id="carousel" class="page-header"> Hospital General <small>Huajuapan de León, Oax.</small></h1>

<%--  				<p>Universidad Tecnológica de la Mixteca </strong></p>--%>

  				<h2 id="carousel-examples">Fotografías</h2>
			  	<div class="bs-example" data-example-id="simple-carousel">
				    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
				      <ol class="carousel-indicators">
				        <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
				        <li data-target="#carousel-example-generic" data-slide-to="1"></li>
				        <li data-target="#carousel-example-generic" data-slide-to="2"></li>
				      </ol>
				      <div class="carousel-inner" role="listbox">
					     <div class="item active">
					     <img src="${resource(dir: 'images', file: 'hospital1.jpg') }" style="width: 900px; height: 500px">
					  </div>
			          <div class="item">
			        	 <img src="${resource(dir: 'images', file: 'hospital3.jpg') }" style="width: 900px; height: 500px">
			          </div>
			          <div class="item">
			             <img src="${resource(dir: 'images', file: 'hospital2.jpg') }" style="width: 900px; height: 500px">
			          </div>
			        </div>
			      	<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
			        	<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
			        	<span class="sr-only">Anterior</span>
			        </a>
			        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
			        	<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			        	<span class="sr-only">Siguiente</span>
			        </a>
			    </div>
		</div>
	    </div>
	  </div>
	</div>
	</div>

	<div class="row">
	<div class="col-sm-7 col-md-8">
	<footer class="blog-footer">
      <div class="container">
       
<%--        	<p class="text-muted" align="center"; >Universidad Tecnológica de la Mixteca.</p>--%>
        
      </div>
    </footer>
	</div>
	</div>
</body>
</html>