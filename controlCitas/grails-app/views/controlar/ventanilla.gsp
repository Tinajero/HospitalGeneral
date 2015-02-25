<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainVentanilla">
		
		
	</head>
<body>

    
    
       <div class="col-sm-7 col-md-8 col-sm-offset-3 col-md-offset-2 main">
	       <div class="bs-docs-section">
	 				<h1 id="carousel" class="page-header"> Hospital General <small>Huajuapan de León, Oax.</small></h1>
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


	
       
<%--        	<p class="text-muted" align="center"; >Universidad Tecnológica de la Mixteca.</p>--%>
        
    
</body>
</html>