var seleccionado = false;
var cadena;

function categoryChanged(categoryId) {
  console.log(categoryId);
  quitarSeleccionado();
  jQuery.ajax({type:'POST',data:'tipoCita='+categoryId, url:'tipoCitaCambiada',success:function(data,textStatus){
  		jQuery('#subContainer').html(data);		
  	},
	error:function(XMLHttpRequest,textStatus,errorThrown){}});
}
  
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
function cambiarColorDias(){
	var  startDay = $('#calendar').fullCalendar('getView').intervalStart.format();
	var  endDay = $('#calendar').fullCalendar('getView').intervalEnd.format();
	var doctorId = $("#cbDoctores").val();
	console.log(startDay + " " + endDay + " d " + doctorId);

	$.ajax({
		type:'POST',   		
		data: 'startTime=' + startDay + "&endTime=" + endDay + "&doctorId=" + doctorId,
		url:'getBussyDays',
		success:function(data,textStatus){
			console.log("exito Ajax");
			$.each( data, function( index, dia){
				//console.log(dia);
				var cell = $('#dia'+dia.id);
				if ( dia.ocupado == 0){
					cell.css('background-color','#7DE96E');
				} else if ( dia.ocupado == 1 ) {
					console.log("dia ocupado ");
					cell.css('background-color','#E94E58');
				} else {
					console.log("dia no laboral ");
					cell.css('background-color','#868080');
				}
				
			});

	  },
    error:function(XMLHttpRequest,textStatus,errorThrown){}
  });
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
    },
    // funcion que modifica el color de fondo de un dia
    dayRender:function( date, cell ) { 
    	//console.log( date.format() );
    	cell.attr("id","dia" + date.format() );
    	//$(cell).css("background", "red");
    	console.log("called dayRender");
    },
    // funcion llamada cuando los datos son cargados
    loading: function(isLoading, view) {
    	console.log("loading = " + isLoading);
    	if (isLoading == false){ // cuando ya se cargaron
    		eventsLoaded = $('#calendar').fullCalendar('clientEvents');
    		console.log(eventsLoaded);
    		cambiarColorDias();
    	}
    }        	
  })
});

//Mask for Expediente
  $(document).ready(function(){ 
  	$("#expediente_textField").mask('00-00-00');
  	$("#telefono").mask('(000)000-0000');  	
});
