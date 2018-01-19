var seleccionado = false;
var cadena;
var arregloHorarios;
function categoryChanged() {  
  
	quitarSeleccionado();
  var urlTipoCitaCambiada = getTipoCitaCambiadaPath;
  console.log(urlTipoCitaCambiada);
  
  var turnoSeleccionado = $("#turnoDoctor").val(); 
  var especialidadSeleccionada = $("#TipoCita").val()
  
  jQuery.ajax({type:'POST',data:'tipoCita='+especialidadSeleccionada+ '&turno=' + turnoSeleccionado , url:urlTipoCitaCambiada,success:function(data,textStatus){
  		jQuery('#subContainer').html(data);
  		if(doctorSeleccionado != null && doctorSeleccionado != ""){
  			$("#cbDoctores").val(doctorSeleccionado);
  			cambioDoctor(doctorSeleccionado);
  		} 
  	},
	error:function(XMLHttpRequest,textStatus,errorThrown){}});
}

function getHorarios(  ){
    var doctorId = $("#cbDoctores").val();
		var tipoCita = $("#tipoCita").val();
  	if (!seleccionado && doctorId != null ) {
    	var doctorId = $("#cbDoctores").val();
    	console.log("doctorId = " +doctorId);
    	var dia = $('#cbFechaCita_day').val();
    	var mes = $('#cbFechaCita_month').val();
    	var anio = $('#cbFechaCita_year').val();
    	var fecha = dia + "-" + mes + "-" + anio;
    	console.log(fecha);
    	jQuery.ajax({type:'POST',data:'doctorID='+doctorId+'&fecha='+fecha, url:getMostrarHorarioPath,success:function(data,textStatus){
      		//jQuery('#subContainer').html(data);		
      		console.log(data);
      		var arreglo = data;//JSON.parse(data);
          arregloHorarios = data; //copia de los horarios para usarlo en agregar hora
      		var htmlString = "";
          var asignadoA = ""; //asignadoA es progra de Max
      		// con each recorremos
      		// luego agregamos una fila a la tabla en su tbody
      		$('#tablaHorariosCita tbody').empty();
      		$.each( arreglo, function( index, horario){
      			console.log(index + " " + horario.hora);
      			if ( horario.libre ) {              
              if ( horario.tipo == 0){
                $("<tr class='libre primeraVez'></tr>").appendTo( '#tablaHorariosCita tbody').append(
                  "<td class='centrado'>"+(index+1)+"</td>" +
                  "<td class='centrado'>" + horario.hora + "</td>"+
                  "<td class='centrado'>  Primera Vez </td>"              
                );

              } else if (horario.tipo == 1){ // si el tipo de cita es subsecuente;
        				$("<tr class='libre subsecuente'></tr>").appendTo( '#tablaHorariosCita tbody').append(
        					"<td class='centrado'>"+(index+1)+"</td>" +
        					"<td class='centrado'>" + horario.hora + "</td>"+
                  "<td class='centrado'> Subsecuente </td>"        					
        				);
              }
      			} else {
              //Colocar Si un paciente subsecuente ocupa un lugar de "Primera Vez" y si un paciente de primera vez ocupa un "subsecuente"
              if(horario.asignadaA=='primera vez' && horario.tipo==1){
                asignadoA = "<td class='centrado asignadaA'>Primera vez</td>";
              }else if(horario.asignadaA=='subsecuente' && horario.tipo==0){
                asignadoA = "<td class='centrado asignadaA'>Subsecuente</td>";
              }else{
                asignadoA = "";
              }
              //end
      				$("<tr class='horaOcupada'></tr>").appendTo( '#tablaHorariosCita tbody').append("<td class='centrado '>"+(index+1)+"</td><td class='centrado'>" 
								+ horario.hora 
								+ "</td><td class='centrado'>"+(horario.tipo==1?"Subsecuente":"Primera Vez") +"</td>"
                + asignadoA); //asignadoA es progra de Max
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
	
	$("#vista_hour").val("");
	$("#vista_minute").val("");
	
	
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
  		url: getCalendarPath,
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
  function cambiarFechaCalendario(){
    var dia = $("#cbFechaCita_day").val();
    var mes = $('#cbFechaCita_month').val() - 1;
    var year = $('#cbFechaCita_year').val();
    var fecha = new Date(year, mes, dia);
    $('#calendar').fullCalendar( 'gotoDate', fecha);
    $('#calendar').fullCalendar('select', fecha);
    quitarSeleccionado();

  }
function cambiarColorDias(){
	var  startDay = $('#calendar').fullCalendar('getView').intervalStart.format();
	var  endDay = $('#calendar').fullCalendar('getView').intervalEnd.format();
	var doctorId = $("#cbDoctores").val();
	console.log("function cambiarColorDias ");
  if (doctorId != ''){
    console.log("function cambiarColorDias >> ENTRO");
    var pathDiasOcupados = getBussyDaysPath;
  	$.ajax({
  		type:'POST',   		
  		data: 'startTime=' + startDay + "&endTime=" + endDay + "&doctorId=" + doctorId,
  		url:pathDiasOcupados,
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
/*fuuncion llamada cuando se cambia el select del tipo de cita que debera de ocultar o mostrar
 * campos, en este caso el de expediente ya que un tipo de primera vez no tiene expediente
 * 
 * Mal esta funcion ya ni sera llamada siempre se podra escojer entre dos tipos solo que 
 * si existe una seleccion cruzada se debe poder ver, esa funcionalidad la hara Max
 * */
function onChangeTipoCita(){
	var valueSelect = $("#tipoCita").val();
	// comentado por que ya no se debe hacer nada
	/*if (valueSelect == '2') {
		$("#divExpediente").removeClass("ocultar-contenido");
	} else {
		$("#divExpediente").addClass("ocultar-contenido");
	}*/
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
		 quitarSeleccionado();
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

	// Mascara customizada para el curp
     $("#curp").mask('ABCDEFGHIJKLMNOPQR', {'translation': {
      A:{pattern: '[A-Za-z]'},
      B:{pattern: '[AEIOUaeiou]'},
      C:{pattern: '[A-Za-z]'},
      D:{pattern: '[A-Za-z]'},
      E:{pattern: '[0-9]'},
      F:{pattern: '[0-9]'},
      G:{pattern: '[0-1]'},
      H:{pattern: '[0-9]'},
      I:{pattern: '[0-9]'},
      J:{pattern: '[0-9]'},
      K:{pattern: '[H,M,h,m]'},
      L:{pattern: '[A-Za-z]'},
      M:{pattern: '[A-Za-z]'},
      N:{pattern: '[B-DF-HJ-NP-TV-Z-b-df-hj-np-tv-z]'},
      O:{pattern: '[B-DF-HJ-NP-TV-Z-b-df-hj-np-tv-z]'},
      P:{pattern: '[B-DF-HJ-NP-TV-Z-b-df-hj-np-tv-z]'},
      Q:{pattern: '[0-9A-Za-z]'},
      R:{pattern: '[0-9]'}           
     }
   });

   // Para que se seleccione el anio
   var d = new Date(); 
   console.log(d.getFullYear());
  
   setTimeout(function(){
	   var fecha = $("#fechaOculta").val();
	   
	   if (fecha != null && fecha != ""){	
		   console.log("FEchaString: " +fecha);
		   fecha = new Date(fecha)	   
		   var day = 1;
		   var month = 1;
		   var year = 2015;
		   day = fecha.getDate();
		   month = fecha.getMonth();
		   year = fecha.getFullYear();
		   var hour = fecha.getHours();
		   var minutes = fecha.getMinutes();
		   $('#cbFechaCita_day').val(day);
		   $('#cbFechaCita_month').val(month+1);
		   $('#cbFechaCita_year').val( year );		   		   		  
		   var tipoCita = $("#TipoCita").val();
		   categoryChanged(tipoCita);		   
		   $("#vista_hour").val(hour);
		   $("#vista_minute").val(minutes);
		   
		   console.log(fecha)
		   
	   } else {
		   $("#cbFechaCita_year").val("" + d.getFullYear());
	   }	   
	   
   }, 500)
   
   

/*
   
    regex:"[A-Z]{1}[AEIOU]{1}[A-Z]{2}[0-9]{2}" +
          "(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-1])" +
          "[HM]{1}" +
          "(AS|BC|BS|CC|CS|CH|CL|CM|DF|DG|GT|GR|HG|JC|MC|MN|MS|NT|NL|OC|PL|QT|QR|SP|SL|SR|TC|TS|TL|VZ|YN|ZS|NE)" +
          "[B-DF-HJ-NP-TV-Z]{3}" +
          "[0-9A-Z]{1}[0-9]{1}$"
    });
*/
});
  
function fnExcelReport() {
      var tab_text = "";
      var textRange; var j=0;
     
      var tablas = document.getElementsByClassName("table")
      for(i = 0; i < tablas.length ; i++){   
          
          tab_text +="<table border='2px'><tr bgcolor='#87AFC6'>";
          tab = tablas[i];//document.getElementById(id); // id of table

          for(j = 0 ; j < tab.rows.length ; j++) 
          {       
              tab_text=tab_text+tab.rows[j].innerHTML+"</tr>";
              //tab_text=tab_text+"</tr>";
          }

          tab_text+="</table>";
      }
      //tab_text= tab_text.replace(/<A[^>]*>|<\/A>/g, "");//remove if u want links in your table
      //tab_text= tab_text.replace(/<img[^>]*>/gi,""); // remove if u want images in your table
      //tab_text= tab_text.replace(/<input[^>]*>|<\/input>/gi, ""); // reomves input params

      var ua = window.navigator.userAgent;
      var msie = ua.indexOf("MSIE "); 

      if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))      // If Internet Explorer
      {
          txtArea1.document.open("txt/html","replace");
          txtArea1.document.write(tab_text);
          txtArea1.document.close();
          txtArea1.focus(); 
          sa=txtArea1.document.execCommand("SaveAs",true,"Say Thanks to Sumit.xls");
      }  
      else {                 //other browser not tested on IE 11
          //sa = window.open('data:application/vnd.ms-excel,' + encodeURIComponent(tab_text));        
      	var uri = 'data:application/vnd.ms-excel;base64,'
      	    ,template = '<html xmlns:0="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-HTML140"><head><!--[if dte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--><meta http-equiv="content-type" content="text/plain; charset=UTF-8"/> </head><body><table>{table}</table></body></html>'
      	    ,base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s)));}
      	    ,format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p];}); };

      	    var ctx = { worksheet: name || 'Worksheet', table: tab_text }
      		sa = window.location.href = uri + base64(format(template, ctx));    	    	    
      }	               
      return (sa);
  }  
  
