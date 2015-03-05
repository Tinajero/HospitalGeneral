<%@ page import="doctor.Doctor" %>



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
		<g:message code="doctor.tipoCita.label" default="Tipo de Cita" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		<g:textField name="tipoCita" class="form-control" required="" value="${doctorInstance?.tipoCita}"/>
	</div>
	
</div>

	<div>
		<%--<g:each in="${['Domingo','Lunes','Martes','Miercoles','Jueves','Viernes','Sabado']}" var ="diaBoton">
			
			<button type="button" class="btn btn-success">${diaBoton}</button>
		</g:each>
		--%>
	</div>

	<%--Almacenar los dias laborales en variable(diasLaborales) y comparar con los dias del checkbox --%>
	<div>

		<table>
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

	<br>
</div>

-<div class="fieldcontain ${hasErrors(bean: doctor, field: 'diasLaborales', 'error')} required">
	<div class="col-sm-4">
		<g:textField name="diasLaborales" style = "display:none;"class="form-control" required="" value="HOLa"/>
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





