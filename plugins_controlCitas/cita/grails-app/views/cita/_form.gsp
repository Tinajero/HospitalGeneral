<%@ page import="cita.Cita" %>


<div class="form-group ${hasErrors(brean: paciente, field: expediente, 'has error')} required">
	<label for="expediente" class="col-sm-2 control-label">
		<g:message code="cita.paciente.label" default='Expediente'/>
		<span class="required-indicator">*</span>
	</label>
	<div class ="col-sm-4">
		<g:textField name="paciente.expediente" id="expediente" placeholder="Introduce Expediente" class="form-control" required="" value="${cita?.paciente?.expediente}"/>
	</div>
  
</div>

<div class="form-group ${hasErrors(brean: paciente, field: nombre, 'has error')} required">
	<label for="apellidoPaterno" class="col-sm-2 control-label">
		<g:message code="cita.paciente.nombre.label" default="Paciente" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-2">
		<g:textField name="paciente.apellidoPaterno" class="form-control" required="" placeholder="Apellido Paterno" value="${cita?.paciente?.apellidoPaterno}"/>
	</div>
	<div class="col-sm-2">
		<g:textField name="paciente.apellidoMaterno" class="form-control" required="" placeholder="Apellido Materno" value="${cita?.paciente?.apellidoMaterno}"/>
	</div>
	<div class="col-sm-2">
		<g:textField name="paciente.nombre" class="form-control" required="" placeholder="Nombre(s)" value="${cita?.paciente?.apellidoMaterno}"/>
	</div>
</div>

<div class="form-group ${hasErrors(brean: paciente, field: poblacion, 'has error')} required">
	<label for="Poblacion" class="col-sm-2 control-label">
		<g:message code="cita.paciente.poblacion.label" default="Poblacion" />
		<span class="required-indicator">*</span>
	</label>
	<div class ="col-sm-4">
		<g:textField name="paciente.poblacion" class="form-control" required="" value="${cita?.paciente?.poblacion}"/>
	</div>
</div>

<div class="form-group ${hasErrors(brean: paciente, field: telefono, 'has error')} required">
	<label for="Telefono" class="col-sm-2 control-label">
		<g:message code="cita.paciente.telefono.label" default="Telefono" />
		<span class="required-indicator">*</span>
	</label>
	<div class ="col-sm-4">
		<input type="tel" name="paciente.numeroTelefono" class="form-control" required="" value="${cita?.paciente?.poblacion}"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: cita, field: 'doctor', 'has error')} required">
	<label for="Tipo Cita" class="col-sm-2 control-label">
		<g:message code="cita.doctor.label" default="Tipo de cita" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
	<%--	<g:select id="doctor" name="doctor.tipoCita" from="${ doctor.Doctor.list() }" optionKey="tipoCita" optionValue="tipoCita"required="" value="cita?.doctor?.tipoCita}" class="form-control"/> 
  optionKey="tipoCita" optionValue="tipoCita"
  --%>
    <g:select id="TipoCita" name="doctor.tipoCita" from="${doctor.Doctor.listUnique()}"  required="" value="${cita?.doctor?.tipoCita}" class="form-control" noSelection="[null:'']" onchange="categoryChanged(this.value);"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: cita, field: 'doctor.nombre', 'error')} required">
	<label for="Doctor" class="col-sm-2 control-label">
		<g:message code="cita.doctor.label" default="Medico" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-4">
		<%-- <g:select id="doctor" name="doctor.id" from="${doctor.Doctor.list()}" optionKey="id" optionValue="nombre" required="" value="cita?.doctor?.nombre}" class="many-to-one form-control"/> --%>
    <span id="subContainer"> </span>


	</div>
</div>


 <div class="form-group ${hasErrors(bean: cita, field: 'fecha', 'error')} required">
	<label for="fecha" class="col-sm-2 control-label">
		<g:message code="cita.fecha.label" default="Fecha" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-3">
		<g:datePicker name="fecha" id="cbFechaCita" precision="day" class= "form-control" value="${cita?.fecha}"  />
	</div>
	<div class="col-sm-1">
		<!-- Button trigger modal -->
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal"
		onclick="getHorarios()">
			Horario
		</button>
	</div>
	<div class="col-sm-3">
		<input type="text" id="cbFechaCita_hour" name="fecha_hour" hidden="true"/>
	</div>
	<div class="col-sm-3">
		<input type="text" id="cbFechaCita_minute" name="fecha_minute" hidden="true"/>
	</div>
</div> 

<!-- <div class="fieldcontain ${hasErrors(bean: cita, field: 'paciente', 'error')} required">
	<label for="paciente">
		<g:message code="cita.paciente.label" default="Paciente" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="paciente" name="paciente.id" from="${paciente.Paciente.list()}" optionKey="id" required="" value="${cita?.paciente?.id}" class="many-to-one"/>

</div> -->



<div id='calendar'></div>


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
  // agregando comportamiento cuando el mouse este sobre la fila
	  // 		$("td.libre").mouseover(function() {     
		 //    	$(this).addClass('cell-highlight' );     
	  // 		}).mouseout(function() { 
	  //   		$(this).removeClass('cell-highlight' );        
			// });  
 /* function cambioDoctor(doctorId) {
  	console.log("DoctorId " +  doctorId);
  	$('#calendar').fullCalendar({
		        // put your options and callbacks here
		        header:{
				    left:   'title',
				    center: '',
				    right:  'today month basicWeek basicDay prev,next'
				},
		       	 events: {
		       	 	url: '../MetodosCalendar/consulta' ,
		       	 	data: {
			            DoctorId : doctorId
			        },
			        error: function(){
			        	console.log("error");
			        }
			       

		    	}
    		})
  }*/
   	function cambioDoctor(doctorId){
    	console.log(doctorId);
    	// quitar la bandera de que a sido seleccionado algo
    	seleccionado = false;
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
    })

});
</script>