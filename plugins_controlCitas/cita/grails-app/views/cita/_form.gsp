<%@ page import="cita.Cita" %>

${request?.session.servletContext.realPath}
<script> var getTipoCitaCambiadaPath = "${createLink(action:'tipoCitaCambiada')}" </script>
<script> var getBussyDaysPath = "${createLink(action:'getBussyDays')}" </script>
<script> var getCalendarPath = "${createLink(controller:'metodosCalendar', action:'consulta')}" </script>
<script> var getMostrarHorarioPath = "${createLink(action:'mostrarHorario')}" </script>
<script> var tipoCitaSeleccionada = "${citaInstance?.tipoCita}" </script>
<script> var doctorSeleccionado = "${citaInstance?.doctor?.id}" </script>
<script> var fechaCitaSeleccionada = "${citaInstance?.fecha}" </script>
<script> var autocompleteByExpediente = "${createLink(controller: cita, action:'autocompleteByExpediente')}" </script>

<g:set name= '' var="doctorS" bean="doctorService"/>
<g:set name= '' var="subServicioService" bean="subServicioService"/>
<g:set name= '' var="tipoSubServicioService" bean="tipoSubServicioService"/>

<div class="form-group required">
	<label for="tipoCita" class="col-sm-2 control-label">
		<g:message code="cita.tipoCita" default="Tipo de Cita"/>
		
	</label>
	<div class="col-sm-5">
	<g:select id="subServicio" class="form-control" name="cita.tipoCita" 
			from="${subServicioService.obtienesLosSubServicios()}" 
			optionKey="id" 
			value="${citaInstance?.asignadaA?.id}"
			optionValue="nombre" 		
			required="true"	
			noSelection="['null': '']"/>
<%--		<select --%>
<%--			name="cita.tipoCita" --%>
<%--			id="tipoCita" --%>
<%--			class="form-control selectionBox" --%>
<%--			required="true"--%>
<%--			--%>
<%--			onChange="onChangeTipoCita()">--%>
<%--			<option value="0">Primera Vez</option>--%>
<%--			<option value="1">Subsecuente</option>			--%>
<%--		</select>--%>
	</div> 
</div>

<div class="form-group ${hasErrors(bean: cita, field: 'doctor.nombre', 'has-error')} required">
	<label for="Doctor" class="col-sm-2 control-label">
		<g:message code="cita.doctor.label" default="M&eacute;dico" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
    <span id="subContainer"> </span>


	</div>
</div>


<%--TipoSubServicio
<div class="form-group required">
	<label for="tipoCita" class="col-sm-2 control-label">
		<g:message code="cita.tipoCita" default="Tipo de Cita"/>
		
	</label>
	<div class="col-sm-5">
	<g:select id="tipoSubServicio" class="form-control" name="cita.tipoSubServicioAtendido" 
			from="${tipoSubServicioService.obtieneLosTipoSubServiciosDeUnSubServicio()}" 
			optionKey="id" 
			value="${citaInstance?.asignadaA?.id}"
			optionValue="nombre" 		
			required="true"	
			noSelection="['null': '']"/>
	</div> 
</div>--%>

<div class="form-group ${hasErrors(bean: cita?.paciente, field: 'expediente', 'has error')}" id="divExpediente">

	<label for="expediente" class="col-sm-2 control-label">
		<g:message code="cita.paciente.label" default='Expediente'/>
		
	</label>
	
	<div class ="col-sm-4">
		<input type="text" 
			name="cita.paciente.expediente" 
			id="expediente_textField" 
			
			placeholder="Introduce Expediente" 
			class="form-control"  value="${citaInstance?.paciente?.expediente}"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: cita?.paciente, field: 'nombre', 'has-error')} required" >
	<label for="apellidoPaterno" class="col-sm-2 control-label">
		<g:message code="cita.paciente.nombre.label" default="Paciente" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-2">
			<input type="text" name="cita.paciente.nombre" id="nombre" class="por_nombre form-control" 
			placeholder="Nombre(s)" required="true" value="${citaInstance?.paciente?.nombre}"/>
	</div>
	<div class="col-sm-2">
		<input type="text" name="cita.paciente.apellidoPaterno" id="apaterno" class="por_nombre form-control" placeholder="Apellido Paterno" 
		required="true" value="${citaInstance?.paciente?.apellidoPaterno}"/>
		<input type="hidden" id="apaterno_only" name="country_id" value="" />
	</div>
	<div class="col-sm-2">
		<input type="text" name="cita.paciente.apellidoMaterno" id="amaterno" class="por_nombre form-control" 
		placeholder="Apellido Materno" required="true" value="${citaInstance?.paciente?.apellidoMaterno}"/>
	</div>
	
</div>

<div class="form-group ${hasErrors(bean: cita?.paciente, field: 'curp', 'has-error')} required">
	<label for="curp" class="col-sm-2 control-label">
		<g:message code="cita.paciente.curp.label" default="Curp" />		
	</label>
	<div class ="col-sm-4">
		<g:textField id="curp" name="cita.paciente.curp" class="form-control" pattern="/^.{18,}\$/" value="${citaInstance?.paciente?.curp}"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: cita?.paciente, field: 'folioSeguroPopular', 'has-error')} required">
	<label for="folioSeguroPopular" class="col-sm-2 control-label">
		<g:message code="cita.paciente.folioSeguroPopular.label" default="Folio Seguro Popular" />
	</label>
	<div class ="col-sm-4">
		<g:textField id="folioSeguroPopular" name="cita.paciente.folioSeguroPopular" class="form-control"  value="${citaInstance?.paciente?.folioSeguroPopular}"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: cita?.paciente, field: 'poblacion', 'has-error')} required">
	<label for="poblacion" class="col-sm-2 control-label">
		<g:message code="cita.paciente.poblacion.label" default="Localidad" />
		<span class="required-indicator">*</span>
	</label>
	<div class ="col-sm-4">
		<input type="text" id="poblacion"  name="cita.paciente.poblacion"  class="form-control" required="true" 
		value="${citaInstance?.paciente?.poblacion}"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: cita?.paciente, field: 'numeroTelefono', 'has-error')} required">
	<label for="Telefono" class="col-sm-2 control-label">
		<g:message code="cita.paciente.telefono.label" default="Telefono" />		
	</label>
	<div class ="col-sm-4">
		<input id="telefono" type="tel" name="cita.paciente.numeroTelefono" class="form-control"
		 value="${citaInstance?.paciente?.numeroTelefono}"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: doctorInstance, field: 'tipoCita', 'error')} required">
	<label for="turno" class="col-sm-2 control-label">
		<g:message code="doctor.turno.label" default="Turno" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		
		<g:select id="turnoDoctor" name="turno" class="form-control" required="" onchange="categoryChanged();" value="${citaInstance?.doctor?.turno}"
          from="${doctorS.listaTurnos()}"
          optionKey="value" optionValue="turno"/>
	</div>
	
</div>

<div class="form-group ${hasErrors(bean: cita, field: 'doctor', 'has-error')} required">
	<label for="TipoCita" class="col-sm-2 control-label">
		<g:message code="cita.doctor.label" default="Servicio" />
		<span class="required-indicator">* ${citaInstance?.doctor?.tipoCita?.id}</span>
	</label>
	<div class="col-sm-4">
    <g:select id="TipoCita" name="cita.doctor.tipoCita" 
    	from="${doctor.Doctor.listUnique()}"   
    	required="" 
		value="${citaInstance?.doctor?.tipoCita?.id}"
		optionKey="id"
		optionValue="nombre" 
		class="form-control" noSelection="['':'']" onchange="categoryChanged();"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: cita, field: 'doctor.nombre', 'has-error')} required">
	<label for="Doctor" class="col-sm-2 control-label">
		<g:message code="cita.doctor.label" default="M&eacute;dico" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
    <span id="subContainer"> </span>


	</div>
</div>


 <div class="form-group ${hasErrors(bean: cita, field: 'fecha', 'has-error')} required">
	<label for="fecha" class="col-sm-2 control-label">
		<g:message code="cita.fecha.label" default="Fecha" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-1 nopadding" 	style="padding-right:15px;">		
		<select name="cita.fecha_day" class="form-control selectionBox" id="cbFechaCita_day" onchange="cambiarFechaCalendario();" 
			required="">
		<% def count=31 %>
		<g:each in="${1..count}" var="dia" >
			<option value="${dia}">${dia}</option>
		</g:each>
		</select>
	</div>
		<input type="hidden"  value="${citaInstance?.fecha}" id="fechaOculta"/>
        <input type="hidden" name="cita.fecha" value="date.struct"/>
	<div class="col-sm-2 nopadding" >
		<select name="cita.fecha_month" class="form-control selectionBox" id="cbFechaCita_month" required="" onchange="cambiarFechaCalendario();"
			>
			<option value="1">enero</option>
			<option value="2">febrero</option>
			<option value="3">marzo</option>
			<option value="4">abril</option>
			<option value="5">mayo</option>
			<option value="6">junio</option>
			<option value="7">julio</option>
			<option value="8">agosto</option>
			<option value="9">septiembre</option>
			<option value="10">octubre</option>
			<option value="11">noviembre</option>
			<option value="12">diciembre</option>
		</select>
	</div>
	<div class="col-sm-1 nopadding">
		<select name="cita.fecha_year" class="form-control selectionBox" id="cbFechaCita_year" required="" onchange="cambiarFechaCalendario();">
			<option value="2115">2115</option>		
			<option value="2031">2031</option>
			<option value="2030">2030</option>
			<option value="2029">2029</option>
			<option value="2028">2028</option>
			<option value="2027">2027</option>
			<option value="2026">2026</option>
			<option value="2025">2025</option>
			<option value="2024">2024</option>
			<option value="2023">2023</option>
			<option value="2022">2022</option>
			<option value="2021">2021</option>
			<option value="2020">2020</option>
			<option value="2019">2019</option>
			<option value="2018">2018</option>
			<option value="2017">2017</option>
			<option value="2016">2016</option>
			<option value="2015">2015</option>
			<option value="2014">2014</option>
			<option value="2013">2013</option>
		</select>
	</div>	
</div> 
<div class="form-group ${hasErrors(bean: cita, field: 'fecha', 'has-error')} required">
	<label for="vista_hour" class="col-sm-2 control-label">
		<g:message code="cita.fecha.label" default="Hora" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-2 col-narrow">
		<input type="text" id="vista_hour"  disabled="true" style="width:50px;display:inline;" class="form-control" name="minutoHora" />	:
		<input type="text" id="vista_minute"  disabled="true" style="width:50px;display:inline;"  class="form-control" name="minutoVista"/>
		<!-- Button trigger modal -->
		

		<input type="hidden" id="cbFechaCita_hour" class="" name="cita.fecha_hour" />
		<input type="hidden" id="cbFechaCita_minute" class="" name="cita.fecha_minute"/>
	</div>
	<div class="col-sm-2 col-narrow">
		
			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal"
			onclick="getHorarios()">		
				Horario
			</button>
		
	</div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		 <div class="modal-content">
		 	<div class="modal-header">
		 		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        		<h4 class="modal-title" id="myModalLabel">Horario </h4>
		 	</div>
		 	<div class="modal-body" id="modal-body"> 
		 		<div class="row">
		 			<div class="col-sm-5 col-sm-offset-2">
		        		<table id="tablaHorariosCita" class="table">
		        			<thead>
		        				<th class="centrado">No</th>
		        				<th class="centrado">Hora</th>
		        				<th class="centrado">Tipo</th>
		        				<th class="centrado">Asignado a un</th>
		        			</thead>
		        			<tbody>
		        			</tbody>
		        		</table>
		        	</div>
        		</div>
  			</div>
  			<div class="modal-footer">
  				<button type="button" class="btn btn-warning" onclick="agregarHora()">
  					Agregar Hora
  				</button>

  				<button type="button" class="btn btn-primary" onclick="seleccionarHora()">
  					Seleccionar Hora
  				</button>

  			</div>
		 		
		 </div>
	</div>
</div>

	<input type="text" id="asignadoA"  hidden="true" name="cita.asignadaA" value="${citaInstance?.asignadaA?.id }"/>


