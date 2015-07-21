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

	<%-- Asignacion de horario de los usuarios--%>
	<!-- <div class="form-group ${hasErrors(bean: doctorInstance, field: 'horaI', 'error')} required">
		<label for="horaInicial" class="col-sm-4 control-label">
			<g:message code="doctor.horaI.label" default="Hora de entrada" />
			<g:select id = 'horaI' name="horaI" from="${doctorS.getHoras()}"  noSelection="['':'-Hora-']" value="${doctorInstance?.horaI}"/>
			<g:select id = 'minI' name="minutoI" from="${doctorS.getMinutos()}"  noSelection="['':'-Min.-']" value="${doctorInstance?.minutoI}"/>
			<span class="required-indicator">*</span>
		</label>
	</div>

	<div class="form-group ${hasErrors(bean: doctorInstance, 'error')}  required">
		<label for="horaFinal" class="col-sm-4 control-label">
			<g:message code="doctor.horaF.label" default="Hora de salida" />
			<g:select id='horaF' name="horaF" from="${doctorS.getHoras()}"  noSelection="['':'-Hora-']" value="${doctorInstance?.horaF}"/>
			<g:select id='minF'	name="minutoF" from="${doctorS.getMinutos()}"  noSelection="['':'-Min.-']" value="${doctorInstance?.minutoF}"/>
	
			<span class="required-indicator">*</span>
		</label>
		
	</div> -->

	<%-- Boton para generar horarios --%>
<!-- 	<div class="botonTabla">
		<input type = "button" name="Horarios" value = "Horarios"onClick="leeTabla()"/>
	</div> -->

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
		<div class="col-sm-2 col-sm-offset-1">
				<input type="text" id="horario"  name="horario"/>
		</div>
		<div class="col-sm-2">
			<a href="" title="" id="agregarFila" class="btn btn-default">Agregar hora</a>
		</div>
	</div>
	<div  class="col-sm-4 col-sm-offset-1">
		<table id='tablaHoras' class="table table-striped">
			<thead>
				<th style="width:100px;">No.</th>
				<th style="width:200px;">Hora</th>
			</thead>
			<tbody>
			<!-- 	<tr>
					<td>0</td>
					<td>1</td>
				</tr> -->
			</tbody>
		</table>
	</div>
	<p id="horarios"> Aqui </p>

	
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
	jQuery(function(){
	    var counter = 0;
	    /**funcion que agrega una fila a una tabla*/
	    jQuery('#agregarFila').click(function(event) {
	        event.preventDefault();
	        console.log("click");
	        var hora = $("#horario").val();
	        counter++;
	        var newRow = jQuery('<tr><td>' +
	            counter + '</td><td id="renglon'+ counter +'">'+
	            hora +'</td></tr>' );	       
	        jQuery('#tablaHoras').append(newRow);	       
	    });
	});
	$('#formularioDoctor').submit(function(){
	//function insertInput(){
		console.log("apunto de enviar");

			//Funcion que recorrera la tabla con id tablaHoras
		$('#tablaHoras tbody tr').each(function(index){
			var numero, hora;		
			$(this).children("td").each(function(index2){
				switch(index2){
					case 0: numero =$(this).text(); break;
					case 1: hora = $(this).text(); break;
				}				
			});		
        	$('<input />').attr('type', 'text')
	          .attr('name', "hora_"+numero)
	          .attr('value', hora)
	          .appendTo('#formularioDoctor');        	
		
		});
		return true;
	});
</script>

