<%@ page import="doctor.SubServicio" %>



<div class="form-group fieldcontain ${hasErrors(bean: subServicio, field: 'nombre', 'error')} required">
	<label for="nombre" class="col-sm-2 control-label">
		<g:message code="subServicio.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		<g:textField name="nombre" class="form-control" required="" value="${subServicio?.nombre}"/>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: subServicio, field: 'descripcion', 'error')} required">
	<label for="descripcion" class="col-sm-2 control-label">
		<g:message code="subServicio.descripcion.label" default="Descripcion" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		<g:textField name="descripcion" class="form-control" required="" value="${subServicio?.descripcion}"/>
	</div>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: subServicio, field: 'color', 'error')} required">
	<label for="colorpicker" class="col-sm-2 control-label">
		<g:message code="subServicio.colorHexadecimal.label" default="Color" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		
		<input type="color" id="colorpicker" name="colorHexadecimal" pattern="^#+([a-fA-F0-9]{6}|[a-fA-F0-9]{3})$" value="${subServicio?.colorHexadecimal}"> 
 
		<input type="text" pattern="^#+([a-fA-F0-9]{6}|[a-fA-F0-9]{3})$" value="#bada55" id="hexcolor"></input>
	</div>

</div>

<<script type="text/javascript">
$('#colorpicker').on('change', function() {
	$('#hexcolor').val(this.value);
});
$('#hexcolor').on('change', function() {
  $('#colorpicker').val(this.value);
});
</script>




