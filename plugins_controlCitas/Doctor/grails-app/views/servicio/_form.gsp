<%@ page import="doctor.Servicio" %>



<div class="form-group fieldcontain ${hasErrors(bean: servicio, field: 'nombre', 'error')} required">
	<label for="nombre" class="col-sm-2 control-label">
		<g:message code="servicio.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		<g:textField name="nombre" class="form-control" required="" value="${servicio?.nombre}"/>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: servicio, field: 'descripcion', 'error')} required">
	<label for="descripcion" class="col-sm-2 control-label">
		<g:message code="servicio.descripcion.label" default="Descripcion" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		<g:textField name="descripcion" class="form-control" required="" value="${servicio?.descripcion}"/>
	</div>

</div>

<div class="form-group ${hasErrors(bean: servicio, field: 'subServicio', 'error')} ">
	<label for="subServicio" class="col-sm-2 control-label">
		<g:message code="servicio.subServicio.label" default="Sub Servicio" />		
	</label>
	<div class="col-sm-4">
		<g:select id="subServicio" class="form-control" name="subServicio.id" 
			from="${doctor.Servicio.list()}" 
			optionKey="id" 
			value="${servicio?.subServicios*.id}"
			optionValue="nombre" 
			multiple="true"
			noSelection="['null': '']"/>
	</div>

</div>


