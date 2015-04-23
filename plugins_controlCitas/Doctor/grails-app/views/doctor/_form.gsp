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


	<%-- Asignacion de horario de los usuarios--%>
	<div class="form-group ${hasErrors(bean: doctorInstance, field: 'horaI', 'error')} required">
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
		
	</div>

	<%-- Boton para generar horarios --%>
	<div class="botonTabla">
		<input type = "button" name="Horarios" value = "Horarios"onClick="leeTabla()"/>
	</div>

	<%--Almacenar los dias laborales en variable(diasLaborales) y comparar con los dias del checkbox --%>
	<div class="form-group required">

		<table>
			<label for="diasLaborales" class="col-sm-2 control-label">
			<g:message code="doctor.diasLaborales.label" default="Dias Laborales" />
			<span class="required-indicator">*</span>
			<g:set var = "diasSemana" value = "${['Domingo','Lunes','Martes','Miercoles','Jueves','Viernes','Sabado']}"/>
			<g:if test="${doctorInstance?.diasLaborales != null}">
				<g:set var = "diasLab" value="${doctorInstance?.diasLaborales}" />
				
			</g:if>
			<g:else>
				<g:set var = "diasLab" value="${'0000000'}"/>
			</g:else>

			<g:each in="${[0,1,2,3,4,5,6]}" var ="diaBoton">
				<tr>
					<td>${diasSemana[diaBoton]}</td> 

					<g:if test="${diasLab[diaBoton]=='0'}">
					<td><g:checkBox name="${diasSemana[diaBoton]}" value="${false}"/></td>
					</g:if>
					<g:else>
					<td><g:checkBox name="${diasSemana[diaBoton]}" value="${true}"/></td>
					</g:else>

				</tr>
				
			</g:each>
		</table>
	</div>

	<div id='tablaHoras'>
	</div>
	
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





