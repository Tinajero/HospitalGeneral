<%@ page import="doctor.Doctor" %>
 <g:javascript src="funcionesDoctor.js"/>
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
			<a title="" id="agregarFila" class="btn btn-default" onclick="agregarFila()">Agregar hora</a>
		</div>
	</div>
	<div class="col-sm-4 col-sm-offset-1">
		${horarioLength}
		<table class="table table-striped">
			<thead>
				<g:each in="${[0,1,2,3,4,5,6]}" var ="diaBoton">					
					<th>&nbsp;&nbsp;${diasSemana[diaBoton]}&nbsp;&nbsp;</th> 					
				</g:each>
			</thead>
			<tbody id="tablaHorarios">
				
				<g:each in="${ (0..< horarioLength) }" status="i" var="fila">
					<tr  >	
						<g:each in="${ (0..< 7) }" status="j" var="columnaS">						
							<td id="f${i}_c${j}" class="${ horario[j][i]?.tipoCita} centrado">			
								<g:if test="${horario[j][i]}">
									<span>${horario[j][i]?.hora}</span>
									<a class='eliminarCelda glyphicon glyphicon-trash' onclick="eliminarCelda('f${j}_c${i}')"/>
								</g:if>				 																																								
							</td>
						</g:each>					
					</tr>

				</g:each>
			</tbody>
		</table>
	</div>
	
	<p id="horarios">  </p>

	
</div>

<!-- Codigo JQuery -->
<script type="text/javascript">	

</script>

