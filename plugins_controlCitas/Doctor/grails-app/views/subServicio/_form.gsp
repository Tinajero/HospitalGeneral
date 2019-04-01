<%@ page import="doctor.SubServicio" %>

<g:set name= '' var="tipoSubServicioService" bean="tipoSubServicioService"/>

<div class="form-group fieldcontain ${hasErrors(bean: subServicio, field: 'nombre', 'error')} required">
	<label for="nombre" class="col-sm-2 control-label">
		<g:message code="subServicio.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		<g:textField name="nombre" class="form-control" required="" value="${subServicioInstance?.nombre}"/>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: subServicio, field: 'descripcion', 'error')} required">
	<label for="descripcion" class="col-sm-2 control-label">
		<g:message code="subServicio.descripcion.label" default="Descripcion" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		<g:textField name="descripcion" class="form-control" required="" value="${subServicioInstance?.descripcion}"/>
	</div>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: subServicio, field: 'color', 'error')} required">
	<label for="colorpicker" class="col-sm-2 control-label">
		<g:message code="subServicio.colorHexadecimal.label" default="Color" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		
		<input type="color" id="colorpicker" name="colorHexadecimal" pattern="^#+([a-fA-F0-9]{6}|[a-fA-F0-9]{3})$" value="${subServicioInstance?.colorHexadecimal}"> 
 
		<input type="text" pattern="^#+([a-fA-F0-9]{6}|[a-fA-F0-9]{3})$" value="#bada55" id="hexcolor"></input>
	</div>

</div>

<div class="form-group ${hasErrors(bean: servicio, field: 'subServicio', 'error')} ">
	<label for="subServicio" class="col-sm-2 control-label">
		<g:message code="servicio.subServicio.label" default="Sub Servicio" />		
	</label>
	<div class="col-sm-4">
		<g:select id="tipoSubServicios" class="form-control" 
			name="tipoSubServicio.id" 
			from="${tipoSubServicioService.obtienesLosTipoSubServicios()}" 
			optionKey="id" 
			value="${subServicioInstance?.tipoSubServicios*.id}"
			optionValue="nombre" 
			multiple="true"
			noSelection="['null': '']"/>
	</div>
	
<%--  --%>
</div>	

<<script type="text/javascript">
$('#colorpicker').on('change', function() {
	$('#hexcolor').val(this.value);
});
$('#hexcolor').on('change', function() {
  $('#colorpicker').val(this.value);
});
</script>




