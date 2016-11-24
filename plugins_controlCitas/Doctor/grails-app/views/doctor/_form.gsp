<%@ page import="doctor.Doctor" %>

<g:set name= ''var="doctorS" bean="doctorService"/>
<script type='text/javascript' src='${request.contextPath}/js/horarios.js'></script>

<div class="form-group ${hasErrors(bean: doctorInstance, field: 'nombre', 'error')} required">
	<label for="nombre" class="col-sm-2 control-label">
		<g:message code="doctor.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		<g:textField name="nombre" class="form-control" required="" value="${doctorInstance?.nombre}"/>
	</div>
	
</div>

<div class="form-group ${hasErrors(bean: doctorInstance, field: 'apellidoPat', 'error')} required">
	<label for="apellidoPat" class="col-sm-2 control-label">
		<g:message code="doctor.apellidoPat.label" default="Apellido Paterno" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		<g:textField name="apellidoPat" class="form-control" required="" value="${doctorInstance?.apellidoPat}"/>
	</div>
	
</div>

<div class="form-group ${hasErrors(bean: doctorInstance, field: 'apellidoMat', 'error')} required">
	<label for="apellidoMat" class="col-sm-2 control-label">
		<g:message code="doctor.apellidoMat.label" default="Apellido Materno" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		<g:textField name="apellidoMat" class="form-control" required="" value="${doctorInstance?.apellidoMat}"/>
	</div>
	
</div>

<div class="form-group ${hasErrors(bean: doctorInstance, field: 'tipoCita', 'error')} required">
	<label for="tipoCita" class="col-sm-2 control-label">
		<g:message code="doctor.tipoCita.label" default="Tipo de cita" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		<g:select name="tipoCita" class="form-control" required="" value="${doctorInstance?.tipoCita} " from="${doctorS.listaTiposCita()}"/>
	</div>
	
</div>

<%--Almacenar los dias laborales en variable(diasLaborales) y comparar con los dias del checkbox --%>
<div class="form-group required">
	<div class="row">
		<label class="col-sm-2 control-label">
			<g:message code="doctor.diasLaborales.label" default="Dias Laborales" />
			<span class="required-indicator">*</span>
		</label>
	
		<div class="col-sm-10">				
			<table>						
				
				<g:set var = "diasSemana" value = "${['Domingo','Lunes','Martes','Miercoles','Jueves','Viernes','Sabado']}"/>
				<g:if test="${doctorInstance?.diasLaborales != null}">
					<g:set var = "diasLab" value="${doctorInstance?.diasLaborales}" />
					
				</g:if>
				<g:else>
					<g:set var = "diasLab" value="${'0000000'}"/>
				</g:else>
				<tr>
					<g:each in="${[0,1,2,3,4,5,6]}" var ="diaBoton">					
						<td>&nbsp;&nbsp;${diasSemana[diaBoton]}&nbsp;&nbsp;</td> 					
					</g:each>
				</tr>
				<tr id="diasMarcados">
					<g:each in="${[0,1,2,3,4,5,6]}" var ="diaBoton">
						<td align="center">
							<g:if test="${diasLab[diaBoton]=='-'}">
								<g:checkBox name="${diasSemana[diaBoton]}"  value="${false}"/>
							</g:if>
							<g:else>
								<g:checkBox name="${diasSemana[diaBoton]}" value="${true}"/>
							</g:else>
						</td>
					</g:each>
				</tr>
			</table>
		</div>
	</div>
</div>
		

	<div class="row">
		<div class="col-sm-4 col-sm-offset-1" id="cajaWarning">

		</div>
	</div>
	<br/>
	<div class="row">		
		<div class="col-sm-2 col-sm-offset-1">
			
			<input type="checkbox" id="tipoHora" name="checkBox_tipoHora"/>
			<label for="checkBox_tipoHora" >
				Primera Vez
			</label>
		</div>
		<div class="col-sm-2">
				<input type="text" id="horarioInput"  name="horarioInput"/>
		</div>
		<div class="col-sm-2">
			<a href="" title="" id="agregarFila" class="btn btn-default">Agregar hora</a>
		</div>
	</div>
	<div class="col-sm-4 col-sm-offset-1">
		<table class="table table-striped">
			<thead>
				<g:each in="${[0,1,2,3,4,5,6]}" var ="diaBoton">					
					<th>&nbsp;&nbsp;${diasSemana[diaBoton]}&nbsp;&nbsp;</th> 					
				</g:each>
			</thead>
			<tbody id="tablaHorarios">

			</tbody>
		</table>
	</div>
	
	<p id="horarios">  </p>

	
</div>

<!-- Codigo JQuery -->
<script type="text/javascript">	
	var counter = 0;		
		/**
		 * Regresa un arreglo que dice que dias estan marcados.
		 */
		function obtenerDiasMarcados(){
			var d = $("#diasMarcados");
			var diasValores = [];
			d.each(function(index){
				$(this).children("td").each(function(index2){
					var t = $(this).children("input");					
					diasValores[index2] = t.is(":checked");
				});
			});

			return diasValores;

		}
		function eliminarCelda(event){
				event.preventDefault();
				var idCelda = event.target.parentNode.id;
				var fila = obtenerFila(idCelda);
				var columna = obtenerColumna(idCelda);
				matrizDias[fila].splice(columna,1);
				tope[fila]--;
				pintarMatriz();
		}
		function pintarMatriz(){
			$("#tablaHorarios").empty();
			var cadena = '';
			for (var i = 0 ; i < maxTope; i++){
				cadena += "<tr>";	
				for (var j = 0 ; j < 7 ; j++ ){
					if (matrizDias[j][i] != undefined){
						cadena +=  "<td id='f" + j + "_c"+ i +"' class='"+ matrizDias[j][i].tipoHora +" centrado'>" 
							    + matrizDias[j][i].hora + ":" + matrizDias[j][i].minuto 								 					 
								 + "&nbsp;<a href='' class='eliminarCelda glyphicon glyphicon-trash'>"									 
								 + "</a></td>";
					}

					else cadena += "<td> </td>";
				}
				cadena += "</tr>";
			}			
			$("#tablaHorarios").append(cadena);
			$('.eliminarCelda').click(eliminarCelda);
		}

	    /**funcion que agrega una fila a una tabla*/
	    jQuery('#agregarFila').click(function(event) {
	        event.preventDefault();
			var dias = obtenerDiasMarcados();
	        //console.log("click");
	        var tipoHora;
	        if ($("#tipoHora").is(":checked"))
	        	tipoHora = "primeraVez"
	       	else
	       		tipoHora = "subsecuente"

	        var hora = $("#horarioInput").val();		
			//-------------
			if(hora){				
				for (var i = 0; i < dias.length ; i++ ) {
					if (dias[i]) {
						var par = {'hora':hora.split(":")[0],'minuto':hora.split(":")[1], 'tipoHora':tipoHora};
						matrizDias[i][ tope[i] ] = par;
						tope[i]++;
						if (maxTope < tope[i]) maxTope = tope[i];
					}										
				}
				pintarMatriz();
			}
			
			//-----------
	        if ( hora && tieneFormato(hora) ){
		        counter++;
		        var newRow = jQuery('<tr><td id="renglon'+ counter +'">'+
		            hora +'</td><td>' +
		            tipoHora +'</td><td>' +
		            '<a href="" class="eliminarFila" class="btn btn-default">Quitar hora</a>' 
		            + '</td></tr>' );	       
		        jQuery('#tablaHoras').append(newRow);
		        $('#cajaWarning').empty();	   

		         $('.eliminarFila').click(function(event) {
		    	event.preventDefault();
		        console.log("click Eliminar");
		        $(this).parent().parent().remove();
		    });

		     } else {
		     	$('#cajaWarning').empty();	
		     	$('#cajaWarning').append('<p class="bg-warning">Introduzca la hora con el formato HH:mm</p>');
		     }
	    });
	    
	$('#formularioDoctor').submit(function(){
	//function insertInput(){
		console.log("apunto de enviar");
		var horas = "[";
		var first = false;
			//Funcion que recorrera la tabla con id tablaHoras
		$('#tablaHoras tbody tr').each(function(index){
			var numero, hora, tipo;		
			if (first)
				horas += ",";
			first = true;
			$(this).children("td").each(function(index2){
				counter++;
				switch(index2){					
					case 0: hora = $(this).text(); break;
					case 1: 
							console.log($(this).text());
							if ( $(this).text() === "Primera Vez")  {
								tipo = 1;
							} else {
								tipo = 0;
							}
				}				
			});	
			// tipo true = primera vez, false = subsecuente
			horas += "{\"hora\":\"" +  hora + "\",\"tipo\":\""+tipo+"\"}";        	        	
		});
		
		horas += " ]";
		if(!counter)
			return false;
		$('<input />').attr('type', 'text')
	          .attr('name', "horario")
	          .attr('value', JSON.stringify(matrizDias))
	          .attr("style", "visibility: hidden")
	          .appendTo('#formularioDoctor');
	   
		return true;
		
	});
	function tieneFormato(cadena){
		if(!(/^(?:[0-5][0-9]):[0-5][0-9]$/).test(cadena)){
      		//$('.alert-box').html('Please use the correct format');
      		return false;
		}
		return true;
	}
	function obtenerFila(s){
		var fila = s.match(/\d+/)[0];
		return fila;
	}	
	function obtenerColumna(s){
		var columna = s.replace(/.*\D/g, "");
		return columna;
	}
	var matrizDias;	
	var tope;
	var maxTope;
	$(document).ready(function(){	
		$("#horarioInput").mask("00:00");
		matrizDias = [];
		tope = [];
		maxTope = -1;
		for (var i = 0; i < 7; i++){
			matrizDias[i] = new Array(1);
			tope[i] = 0;
		}
	})
</script>

