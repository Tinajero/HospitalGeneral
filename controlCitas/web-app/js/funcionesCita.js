var seleccionado = false;
var cadena;
var arregloHorarios;
function categoryChanged(categoryId) {  
  quitarSeleccionado();
  jQuery.ajax({type:'POST',data:'tipoCita='+categoryId, url:'tipoCitaCambiada',success:function(data,textStatus){
  		jQuery('#subContainer').html(data);		
  	},
	error:function(XMLHttpRequest,textStatus,errorThrown){}});
}
  
function getHorarios(  ){
    var doctorId = $("#cbDoctores").val();
    console.log("functio getHorarios()");
  	if (!seleccionado && doctorId != null ) {
    	var doctorId = $("#cbDoctores").val();
    	console.log("doctorId = " +doctorId);
    	var dia = $('#cbFechaCita_day').val();
    	var mes = $('#cbFechaCita_month').val();
    	var anio = $('#cbFechaCita_year').val();
    	var fecha = dia + "-" + mes + "-" + anio;
    	console.log(fecha);
    	jQuery.ajax({type:'POST',data:'doctorID='+doctorId+'&fecha='+fecha, url:'mostrarHorario',success:function(data,textStatus){
      		//jQuery('#subContainer').html(data);		
      		console.log(data);
      		var arreglo = data;//JSON.parse(data);
          arregloHorarios = data; //copia de los horarios para usarlo en agregar hora
      		var htmlString = "";
      		// con each recorremos
      		// luego agregamos una fila a la tabla en su tbody
      		$('#tablaHorariosCita tbody').empty();
      		$.each( arreglo, function( index, horario){
      			console.log(index + " " + horario.hora);
      			if ( horario.libre ) {
              console.log("t " + horario.tipo + ".")
              if ( horario.tipo === '1'){
                $("<tr class='libre primeraVez'></tr>").appendTo( '#tablaHorariosCita tbody').append(
                  "<td class='centrado'>"+(index+1)+"</td>" +
                  "<td class='centrado'>" + horario.hora + "</td>"+
                  "<td class='centrado'>  Primera Vez </td>"                  
                );

              } else {
        				$("<tr class='libre subsecuente'></tr>").appendTo( '#tablaHorariosCita tbody').append(
        					"<td class='centrado'>"+(index+1)+"</td>" +
        					"<td class='centrado'>" + horario.hora + "</td>"+
                  "<td class='centrado'> Subsecuente </td>"        					
        				);
              }
      			} else {
      				$("<tr class='horaOcupada'></tr>").appendTo( '#tablaHorariosCita tbody').append("<td class='centrado '>"+(index+1)+"</td><td class='centrado'>" + horario.hora + "</td><td class='centrado'>"+horario.tipo+"</td>");
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
function agregarHora(){
  var tamaño = arregloHorarios.length;
  if ( tamaño == 2 && arregloHorarios[0]['hora'] == "No atiende citas ese dia, unicamente "){
    // no se pueden agregar horas, pues ese dia no labora
    return ;
  } else {
    //event.preventDefault();
    $("<tr class='libre subsecuente'></tr>").appendTo( '#tablaHorariosCita tbody').append(
      "<td class='centrado'>"+(tamaño + 1)+"</td>" +
      "<td class='centrado' id='renglonHorario_" +(tamaño+1)+ "'><input type='text' id='idaAgregarHora'  class='form-control'/></td>"+
      "<td class='centrado'> </td>"
      );

    $("#idaAgregarHora").mask('00:00');  
    $("#idaAgregarHora").focus();
    $("#idaAgregarHora").focusout(function(){
      var horaIntroducida = $("#idaAgregarHora").val();
      if((/^(?:[0-5][0-9]):[0-5][0-9]$/).test(horaIntroducida)){
      //console.log(horaIntroducida);
        $("#renglonHorario_" +(tamaño+1)).empty();
        $("#renglonHorario_" +(tamaño+1)).text(horaIntroducida);
        $("#renglonHorario_" +(tamaño+1)).parent().click(function(){

            var selected = $(this).hasClass("seleccionado");
            $(this).removeClass("seleccionado");
            if (!selected){
              $(this).addClass("seleccionado");
              seleccionado = false;
            }
        });
      }
      
    });
      
  }

  console.log(tamaño);
}
function tieneFormatoHora(cadena){
    if(!(/^(?:[0-5][0-9]):[0-5][0-9]$/).test(cadena)){
          //$('.alert-box').html('Please use the correct format');
          return false;
    }
    return true;
  }
function seleccionarHora(){	
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
		$('#cbFechaCita_hour').val(hour);
		$('#cbFechaCita_minute').val(minute);

    $('#vista_hour').val(hour);
    $('#vista_minute').val(minute);
	});
	$('#myModal').modal('hide')

	
}
function quitarSeleccionado(){
	seleccionado = false;
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
	console.log("function cambioDoctor doctorId= " + doctorId);
	// quitar la bandera de que a sido seleccionado algo
	quitarSeleccionado();
  	if (doctorId != '' ){
    var events = {
  		url: '../MetodosCalendar/consulta' ,
  		data: {
  			DoctorId : doctorId
  		}
  	};

  	$('#calendar').fullCalendar('removeEventSource',events);
  	$('#calendar').fullCalendar('addEventSource', events);
  	} else {
      console.log("else function cambioDoctor");
      $('#calendar').fullCalendar('removeEventSource',events);
    }
	}
function cambiarColorDias(){
	var  startDay = $('#calendar').fullCalendar('getView').intervalStart.format();
	var  endDay = $('#calendar').fullCalendar('getView').intervalEnd.format();
	var doctorId = $("#cbDoctores").val();
	console.log("function cambiarColorDias ");
  if (doctorId != ''){
    console.log("function cambiarColorDias >> ENTRO");
  	$.ajax({
  		type:'POST',   		
  		data: 'startTime=' + startDay + "&endTime=" + endDay + "&doctorId=" + doctorId,
  		url:'getBussyDays',
  		success:function(data,textStatus){			
  			$.each( data, function( index, dia){
  				//console.log(dia);
  				var cell = $('#dia'+dia.id);
  				if ( dia.ocupado == 0){
  					cell.css('background-color','#7DE96E');
  				} else if ( dia.ocupado == 1 ) {					
  					cell.css('background-color','#E94E58');
  				} else {					
  					cell.css('background-color','#868080');
  				}
  				
  			});

  	  },
      error:function(XMLHttpRequest,textStatus,errorThrown){}
    });
  }
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
    	
    },
    // funcion llamada cuando los datos son cargados
    loading: function(isLoading, view) {    
    	if (isLoading == false){ // cuando ya se cargaron
    		eventsLoaded = $('#calendar').fullCalendar('clientEvents');    		
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
