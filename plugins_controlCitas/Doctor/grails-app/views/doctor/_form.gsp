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
		<label for="diasLaborales" class="col-sm-2 control-label">
		<table class="col-sm-offset-1">
			
			<g:message code="doctor.diasLaborales.label" default="Dias Laborales" />
			<span class="required-indicator">*</span>
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
			<tr>
				<g:each in="${[0,1,2,3,4,5,6]}" var ="diaBoton">
					<td align="center">
						<g:if test="${diasLab[diaBoton]=='-'}">
							<g:checkBox name="${diasSemana[diaBoton]}" value="${false}"/>
						</g:if>
						<g:else>
							<g:checkBox name="${diasSemana[diaBoton]}" value="${true}"/>
						</g:else>
					</td>
				</g:each>
			</tr>


		</table>
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
	<div  class="col-sm-4 col-sm-offset-1">
		<table id='tablaHoras' class="table table-striped">
			<thead>
				
				<th style="width:200px;">Hora</th>
				<th style="width:200px;">Tipo</th>
				<th style="width:200px;">Quitar</th>
			</thead>
			<tbody>
				<g:each in="${horario}" status="i" var="horas">
					<tr> 
						<td id="renglon${i+1}">${horas.hora}</td>				
						<td>${horas.tipo}</td>
						<td> 
							<a href="" class="eliminarFila" class="btn btn-default">Quitar hora</a> 
						</td>
					</tr>
				</g:each>
			</tbody>
		</table>
	</div>
	<p id="horarios">  </p>

	
</div>



<%--<div class="fieldcontain ${hasErrors(bean: doctor, field: 'diasLaborales', 'error')} required">--%>
<%--	<label for="diasLaborales">--%>
<%--		<g:message code="doctor.diasLaborales.label" default="Dias Laborales" />--%>
<%--		<span class="required-indicator">*</span>--%>
<%--	</label>--%>
<%--	--%>
<%----%>
<%--</div>--%>
<%----%>
<%--<div class="fieldcontain ${hasErrors(bean: doctor, field: 'diasNoLaborales', 'error')} required">--%>
<%--	<label for="diasNoLaborales">--%>
<%--		<g:message code="doctor.diasNoLaborales.label" default="Dias No Laborales" />--%>
<%--		<span class="required-indicator">*</span>--%>
<%--	</label>--%>
<%--	--%>
<%----%>
<%--</div>--%>
<%----%>
<%--<div class="fieldcontain ${hasErrors(bean: doctor, field: 'horario', 'error')} required">--%>
<%--	<label for="horario">--%>
<%--		<g:message code="doctor.horario.label" default="Horario" />--%>
<%--		<span class="required-indicator">*</span>--%>
<%--	</label>--%>
<%--	--%>
<%----%>
<%--</div>--%>


<!-- Codigo JQuery -->
<script type="text/javascript">	
	var counter = 0;
		jQuery(function(){
		    $('.eliminarFila').click(function(event) {
		    	event.preventDefault();
		        console.log("click Eliminar");
		        $(this).parent().parent().remove();
		    });
		});
	    /**funcion que agrega una fila a una tabla*/
	    jQuery('#agregarFila').click(function(event) {
	        event.preventDefault();
	        //console.log("click");
	        var tipoHora;
	        if ($("#tipoHora").is(":checked"))
	        	tipoHora = "Primera Vez"
	       	else
	       		tipoHora = "Subsecuente"

	        var hora = $("#horarioInput").val();
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
					case 1: tipo = $(this).text(); break;
				}				
			});	
			horas += "{\"hora\":\"" +  hora + "\",\"tipo\":\""+tipo+"\"}";        	        	
		});
		
		horas += " ]";
		if(!counter)
			return false;
		console.log(horas);
		$('<input />').attr('type', 'text')
	          .attr('name', "horario")
	          .attr('value', horas)
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
	$(document).ready(function(){	
		$("#horarioInput").mask("00:00");
	})
</script>

