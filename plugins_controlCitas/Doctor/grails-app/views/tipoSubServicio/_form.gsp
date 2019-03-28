<%@ page import="doctor.TipoSubServicio"%>


<div
	class="form-group fieldcontain ${hasErrors(bean: tipoSubServicio, field: 'nombre', 'error')} required">
	<label for="nombre" class="col-sm-2 control-label"> <g:message
			code="tipoSubServicio.nombre.label" default="Nombre" /> <span
		class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		<g:textField name="nombre" required="" class="form-control"
			value="${tipoSubServicioInstance?.nombre}" />
	</div>
</div>


<div
	class="form-group fieldcontain ${hasErrors(bean: tipoSubServicio, field: 'descripcion', 'error')} required">
	<label for="descripcion" class="col-sm-2 control-label"> <g:message
			code="tipoSubServicio.descripcion.label" default="Descripcion" /> <span
		class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		<g:textField name="descripcion" required="" class="form-control"
			value="${tipoSubServicioInstance?.descripcion}" />
	</div>
</div>


