<%@ page import="cita.Cita" %>


<div class="form-group ${hasErrors(brean: paciente, field: expediente, 'has error')} required">
	<label for="expediente" class="col-sm-2 control-label">
		<g:message code="cita.paciente.label" default='Expediente'/>
		<span class="required-indicator">*</span>
	</label>
	<div class ="col-sm-4">
		<!--<g:textField name="paciente.expediente" id="expediente_textField" placeholder="Introduce Expediente" class="form-control" required="" value="${cita?.paciente?.expediente}"/> -->
		<input type="text" name="paciente.expediente" id="expediente_textField" placeholder="Introduce Expediente" class="form-control" required="" value=""/>
	</div>
	<div class ="col-sm-4">
		<input type="hidden" id="expediente" name="expediente" value=""/>
		<!--<g:hiddenField id= "expediente" name="cita.expediente" value=""></g:hiddenField>-->
	</div>
</div>

<div class="form-group ${hasErrors(brean: paciente, field: nombre, 'has error')} required">
	<label for="apellidoPaterno" class="col-sm-2 control-label">
		<g:message code="cita.paciente.nombre.label" default="Paciente" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-2">
		<g:textField id="apaterno" name="paciente.apellidoPaterno" class="form-control" required="" placeholder="Apellido Paterno" value="${cita?.paciente?.apellidoPaterno}"/>
	</div>
	<div class="col-sm-2">
		<g:textField id="amaterno" name="paciente.apellidoMaterno" class="form-control" required="" placeholder="Apellido Materno" value="${cita?.paciente?.apellidoMaterno}"/>
	</div>
	<div class="col-sm-2">
		<g:textField id="nombre" name="paciente.nombre" class="form-control" required="" placeholder="Nombre(s)" value="${cita?.paciente?.apellidoMaterno}"/>
	</div>
</div>

<div class="form-group ${hasErrors(brean: paciente, field: poblacion, 'has error')} required">
	<label for="Poblacion" class="col-sm-2 control-label">
		<g:message code="cita.paciente.poblacion.label" default="Poblacion" />
		<span class="required-indicator">*</span>
	</label>
	<div class ="col-sm-4">
		<g:textField id="poblacion" name="paciente.poblacion" class="form-control" required="" value="${cita?.paciente?.poblacion}"/>
	</div>
</div>

<div class="form-group ${hasErrors(brean: paciente, field: telefono, 'has error')} required">
	<label for="Telefono" class="col-sm-2 control-label">
		<g:message code="cita.paciente.telefono.label" default="Telefono" />
		<span class="required-indicator">*</span>
	</label>
	<div class ="col-sm-4">
		<input id="telefono" type="tel" name="paciente.numeroTelefono" class="form-control" required="" value="${cita?.paciente?.poblacion}"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: cita, field: 'doctor', 'has error')} required">
	<label for="Tipo Cita" class="col-sm-2 control-label">
		<g:message code="cita.doctor.label" default="Tipo de cita" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
    <g:select id="TipoCita" name="doctor.tipoCita" from="${doctor.Doctor.listUnique()}"  required="" value="${cita?.doctor?.tipoCita}" class="form-control" noSelection="[null:'']" onchange="categoryChanged(this.value);"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: cita, field: 'doctor.nombre', 'error')} required">
	<label for="Doctor" class="col-sm-2 control-label">
		<g:message code="cita.doctor.label" default="Medico" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
    <span id="subContainer"> </span>


	</div>
</div>


 <div class="form-group ${hasErrors(bean: cita, field: 'fecha', 'error')} required">
	<label for="fecha" class="col-sm-2 control-label">
		<g:message code="cita.fecha.label" default="Fecha" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-1 nopadding" 	style="padding-right:15px;">		
		<select name="fecha_day" class="form-control selectionBox" id="cbFechaCita_day" onchange="quitarSeleccionado();">
		<% def count=31 %>
		<g:each in="${1..count}" var="dia" >
			<option value="${dia}">${dia}</option>
		</g:each>
		<select>
	</div>

	
              <input type="hidden" name="fecha" value="date.struct" />

	<div class="col-sm-2 nopadding" >
		<select name="fecha_month" class="form-control selectionBox" id="cbFechaCita_month" onchange="quitarSeleccionado();">
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
		<select name="fecha_year" class="form-control selectionBox" id="cbFechaCita_year" onchange="quitarSeleccionado();"><option value="2115">2115</option>		
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
			<option value="2015" selected="selected">2015</option>
			<option value="2014">2014</option>
			<option value="2013">2013</option>
		</select>
	</div>
	<div class="col-sm-1 col-narrow">
		<!-- Button trigger modal -->
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal"
		onclick="getHorarios()">
			Horario
		</button>
	</div>
	<div class="col-sm-3 col-narrow">
		<input type="text" id="cbFechaCita_hour" name="fecha_hour" hidden="true"/>
	</div>
	<div class="col-sm-3">
		<input type="text" id="cbFechaCita_minute" name="fecha_minute" hidden="true"/>
	</div>
</div> 

<div id='calendar' style="width:600px;"></div>


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
		        				<th class="centrado">No</th><th class="centrado">Hora</th>
		        			</thead>
		        			<tbody>
		        			</tbody>
		        		</table>
		        	</div>
        		</div>
  			</div>
  			<div class="modal-footer">
  				<button type="button" class="btn btn-primary" onclick="seleccionarHora()">
  					Seleccionar hora
  				</button>
  			</div>
		 		
		 </div>
	</div>
</div>

<script> 
 	var seleccionado = false;
  function categoryChanged(categoryId) {
    console.log(categoryId);
    quitarSeleccionado();
    jQuery.ajax({type:'POST',data:'tipoCita='+categoryId, url:'tipoCitaCambiada',success:function(data,textStatus){
    		jQuery('#subContainer').html(data);		
    	},
		error:function(XMLHttpRequest,textStatus,errorThrown){}});
  }
  var cadena;
  function getHorarios(  ){

  	if (!seleccionado ) {
	  	var doctorId = $("#cbDoctores").val();
	  	console.log(doctorId);
	  	var dia = $('#cbFechaCita_day').val();
	  	var mes = $('#cbFechaCita_month').val();
	  	var anio = $('#cbFechaCita_year').val();
	  	var fecha = dia + "-" + mes + "-" + anio;
	  	console.log(fecha);
	  	jQuery.ajax({type:'POST',data:'doctorID='+doctorId+'&fecha='+fecha, url:'mostrarHorario',success:function(data,textStatus){
	    		//jQuery('#subContainer').html(data);		
	    		console.log(data);
	    		var arreglo = data;//JSON.parse(data);
	    		var htmlString = "";
	    		// con each recorremos
	    		// luego agregamos una fila a la tabla en su tbody
	    		$('#tablaHorariosCita tbody').empty();
	    		$.each( arreglo, function( index, horario){
	    			console.log(index + " " + horario.hora);
	    			if (horario.libre ) {
	    				$("<tr class='libre'></tr>").appendTo( '#tablaHorariosCita tbody').append(
	    					"<td class='centrado'>"+(index+1)+"</td>" +
	    					"<td class='centrado'>" + horario.hora + "</td>"+
	    					"<td class='centrado'> </td>"
	    					);
	    			} else {
	    				$("<tr ></tr>").appendTo( '#tablaHorariosCita tbody').append("<td class='centrado '>"+(index+1)+"</td><td class='centrado'>" + horario.hora + "</td>");
	    			}
	    		});
	    		$("#tablaHorariosCita tr.libre").click(function() {
				    var selected = $(this).hasClass("seleccionado");
				    $("#tablaHorariosCita tr").removeClass("seleccionado");
				    if(!selected){
			            $(this).addClass("seleccionado");
			            seleccionado = false;
				    }
				});  					
	    	},
			error:function(XMLHttpRequest,textStatus,errorThrown){}});
	} 

  }
  function seleccionarHora(){
  	console.log("Hola");
  	seleccionado = false;
  	$(".seleccionado").each(function(index){
  		$(this).children("td").each(function(index2){
  			switch(index2){					
					case 1: hora = $(this).text(); break;
				}				
  		});
  		seleccionado = true;
  		var hour = getHora(hora);
  		var minute = getMinuto(hora);
  		console.log(hour+ " " + minute);
  		$('#cbFechaCita_hour').val(hour);
  		$('#cbFechaCita_minute').val(minute);
  	});
  	$('#myModal').modal('hide')

  	
  }
  function quitarSeleccionado(){
  	seleccionado = false;
  	console.log("quitandoSeleccionado");
  	$('#cbFechaCita_hour').val("");
  	$('#cbFechaCita_minute').val("");
  }
  function getHora(hora){
  	var temp = ""    
    for (var i = 0; i < hora.length && hora.charAt(i) !=':' ; i++){
        temp += hora.charAt(i)
    }                
    return temp;
  }
  function getMinuto(hora){
	var temp = ""	    
    var i;
    for ( i = 0; i < hora.length && hora.charAt(i) !=':' ; i++);
    i++;
    for  ( ; i < hora.length && hora.charAt(i) >='0' && hora.charAt(i) <='9' ; i++){
         temp += hora.charAt(i)
    }                    
    
    return temp;
  }
  function cambioFecha(){
  	console.log("cambio fecha");
  }
   	function cambioDoctor(doctorId){
    	console.log(doctorId);
    	// quitar la bandera de que a sido seleccionado algo
    	quitarSeleccionado();
    	var events = {
    		url: '../MetodosCalendar/consulta' ,
    		data: {
    			DoctorId : doctorId
    		}
    	};
    	$('#calendar').fullCalendar('removeEventSource',events);
    	$('#calendar').fullCalendar('addEventSource', events);
    	
   	}
$(document).ready(function() {

    // page is now ready, initialize the calendar...
     $('#calendar').fullCalendar({
        // put your options and callbacks here
        header: {
					left: 'prev,next today',
					center: 'title',
					right: 'month,agendaWeek,agendaDay'
				},

       	timezone: 'local',
       	lang: 'es',
       	//// funcion que es accionada cuando el usuario da click en el calendar
       	dayClick: function(date, jsEvent, view) {
	        var fecha = date.toDate();
	        var day = 1;
	        var month = 1;
	        var year = 2015;
	        	day = date.format('D');
	        	month = date.format('M');
	        	year = fecha.getFullYear();
	        // cambiando la fecha a donde dio Click el usuario
	        $('#cbFechaCita_day').val( day );
	        $('#cbFechaCita_month').val(  month );
	        $('#cbFechaCita_year').val( year );	   	    
	       $('#calendar').fullCalendar('select', date);
		}        	
    })
});
</script>