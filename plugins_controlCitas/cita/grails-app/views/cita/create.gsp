<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainVentanilla">
		<g:set var="entityName" value="${message(code: 'cita.label', default: 'Cita')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<style >
			.centrado {
				 text-align:center;
			}
			.libre {
				background-color:#6BCDAE;
				color: WHITE;
			}
			.libre:hover {
				background-color:#286090;
				color: WHITE;	
			}
			.seleccionado{
				background-color:#12436E;
				color: WHITE;	
			}
			.selectionBox {
				padding-right:0px;
			}
			.col-narrow {
				padding-right:0px !important;
			}
			.nopadding {
			   padding-right: 0 !important;
			   margin: 0 !important;
			}
		</style>
		<script type="text/javascript">

	      $(document).ready(function() {
    		$.ajax({
        	type: "GET",
	        url: "getAllExpedientes",
	        dataType: "json",
	        success : function(response) {
            	/*console.log("response:" + response);
 				$("#expediente_textField").autocomplete({
 					source: response
            	});*/  
				var datos =
                $.map(response, function(item){

                    return{
                        value: item.expediente, 	//busca por expediende                        
                        apaterno: item.apellidoPaterno,
                        amaterno: item.apellidoMaterno,
                        nombre: item.nombre,
                        poblacion: item.poblacion,
                        telefono: item.numeroTelefono
                    }

                });
                
                $("#expediente_textField").autocomplete({
                	source: datos,
                	//focus: function (event, ui){
                	select: function (event, ui){
                    	console.log("selected expediente:" + ui.item.value);
                    	console.log("selected apellidoPaterno:" + ui.item.apaterno);
                    	console.log("selected apellidoPaterno:" + ui.item.amaterno);
                    	console.log("selected nombre:" + ui.item.nombre);
                    	console.log("selected poblacion:" + ui.item.poblacion);
                    	console.log("selected telefono:" + ui.item.telefono);
 
                    	$('#expediente').val(ui.item.apaterno);
                    	$('#apaterno').val(ui.item.apaterno);
                    	$('#amaterno').val(ui.item.amaterno);
                    	$('#nombre').val(ui.item.nombre);
                    	$('#poblacion').val(ui.item.poblacion);
                    	$('#telefono').val(ui.item.telefono);
                	}
            	});
            
        	}
    		});
 
			});
	      

	</script>
	
	</head>
	<body>
		<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">

			<div id="create-cita" class="content scaffold-create" role="main">
				<h1><g:message code="default.create.label" args="[entityName]" /></h1>
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<g:hasErrors bean="${cita}">
				<ul class="errors" role="alert">
					<g:eachError bean="${cita}" var="error">
					<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
					</g:eachError>
				</ul>
				</g:hasErrors>
				<g:form url="[resource:cita, action:'save']" >
					<fieldset class="form-horizontal">
						<g:render template="form"/>
					</fieldset>
					<fieldset class="buttons col-sm-offset-2">
						<g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
					</fieldset>
				</g:form>

			</div>
		</div>
		<script>
			$(document).ready( setNavBarLista("${entityName}")  );
		</script>

	</body>
</html>
