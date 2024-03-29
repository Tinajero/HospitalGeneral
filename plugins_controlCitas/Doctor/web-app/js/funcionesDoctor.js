var counter = 0;		
var matrizDias;	
var tope;
var maxTope;
$(document).ready(function(){	
	$("#horarioInput").mask("00:00");
	matrizDias = [];
	tope = [];
	maxTope = -1;
	for (var i = 0; i < 7; i++){
		matrizDias[i] = new Array(1);
		tope[i] = 0;
	}
	leerTabla();
	pintarMatriz();
	
	setTimeout(function(){
		
		if(servicioDoctor != null ) {
			$("#tipoCita").val(servicioDoctor);
		}
		
	}, 500); 
})
function leerTabla(){

	if(matrizHorarios != null){
		for (var i = 0; i < matrizHorarios.length; i++){
			for (var j = 0; j < matrizHorarios[i].length; j++){
				var horario = matrizHorarios[i][j];
				if(horario.hasOwnProperty("tipoCita")){
					var hora = horario.hora;
					var tipoHora = horario.tipoCita;
					var par = {'hora':hora.split(":")[0],'minuto':hora.split(":")[1], 'tipoHora':JSON.parse(tipoHora)};
					matrizDias[ i ][ j ] = par;	
					
					tope[i]++;
					if (maxTope < tope[i]) maxTope = tope[i];	
				}
						
			}
		}
			
//			$(this).each(function(index2){
//				
//				var tipoHora = ""
////				if ($(this).hasClass("primeraVez"))
////			    	tipoHora = "primeraVez"
////			   	else if ($(this).hasClass("subsecuente"))
////			   		tipoHora = "subsecuente"
//			
//				if (tipoHora != ""){
//					var idCelda = $(this).attr('id');
//					var hora = $(this).find("span:first").html();
//					var par = {'hora':hora.split(":")[0],'minuto':hora.split(":")[1], 'tipoHora':tipoHora};			
//					var fila = obtenerFila(idCelda);
//					var columna = obtenerColumna(idCelda);
//					matrizDias[ columna ][ fila ] = par;	
//					
//					tope[columna]++;
//					if (maxTope < tope[columna]) maxTope = tope[columna];	
//								
//				}
//			});			   	        	
//		});
	}
}
/**
 * Regresa un arreglo que dice que dias estan marcados.
 */
function obtenerDiasMarcados(){
	var d = $("#diasMarcados");
	var diasValores = [];
	d.each(function(index){
		$(this).children("td").each(function(index2){
			var t = $(this).children("input");					
			diasValores[index2] = t.is(":checked");
		});
	});
	return diasValores;
}
function eliminarCelda(id){
		
		var idCelda = id;		
		var fila = obtenerFila(idCelda);
		var columna = obtenerColumna(idCelda);
		matrizDias[fila].splice(columna,1);
		tope[fila]--;
		pintarMatriz();
}
function pintarMatriz(){
	$("#tablaHorarios").empty();
	var cadena = '';
	for (var i = 0 ; i < maxTope; i++){
		cadena += "<tr>";	
		for (var j = 0 ; j < 7 ; j++ ){
			if (matrizDias[j][i] != undefined){
				var id = "f" + j + "_c"+ i ;
				cadena +=  "<td id='f" + j + "_c"+ i +"' style='background-color:"+ matrizDias[j][i].tipoHora.colorHexadecimal +"' class='centrado'>" 
					    + matrizDias[j][i].hora + ":" + matrizDias[j][i].minuto 								 					 
						 + "&nbsp;<a  class='eliminarCelda glyphicon glyphicon-trash' onclick='eliminarCelda(\"" + id + "\")'>"									 
						 + "</a></td>";
			}
			else cadena += "<td> </td>";
		}
		cadena += "</tr>";
	}			
	$("#tablaHorarios").append(cadena);
	$('.eliminarCelda').click(eliminarCelda);
}


function getById(lista, id, field){
	
	return lista.find(x => x[field] == id)
		
}

/**funcion que agrega una fila a una tabla*/
function agregarFila() {
    
	
	var dias = obtenerDiasMarcados();
	$('#cajaWarning').empty();	 
    //console.log("click");
    var tipoHora;

    var id = $("#comboSubServicios").val();
    tipoHora = listSubServicios.find(x => x.id == id)
    
    var hora = $("#horarioInput").val();		
	//-------------
	if(hora && tieneFormato(hora) ){				
		for (var i = 0; i < dias.length ; i++ ) {
			if (dias[i]) {
				var par = {'hora':hora.split(":")[0],'minuto':hora.split(":")[1], 'tipoHora':tipoHora};
				matrizDias[i][ tope[i] ] = par;
				tope[i]++;
				if (maxTope < tope[i]) maxTope = tope[i];
			}										
		}
		pintarMatriz();
	} else {
     	$('#cajaWarning').empty();	
     	$('#cajaWarning').append('<p class="bg-warning">Introduzca la hora con el formato HH:mm</p>');
     }
}
// Con esto se manda los datos de la tabla del formulario al controller
$('#formularioDoctor').submit(function(){
	$('<input />').attr('type', 'text')
      .attr('name', "horario")
      .attr('value', JSON.stringify(matrizDias))
      .attr("style", "visibility: hidden")
      .appendTo('#formularioDoctor');
   
	return true;
	
});
function tieneFormato(cadena){
	if(!(/^(?:[0-5][0-9]):[0-5][0-9]$/).test(cadena)){
  		//$('.alert-box').html('Please use the correct format');
  		return false;
	}
	return true;
}
function obtenerFila(id){
	var fila = id.match(/\d+/)[0];
	return fila;
}	
function obtenerColumna(id){
	var columna = id.replace(/.*\D/g, "");
	return columna;
}

function cargarSubServicios() {  
	  
  var obtieneSubservicio = urlObtieneSubservicio;
  console.log(urlObtieneSubservicio);    
  var servicioSeleccionado = $("#tipoCita").val()
  
  jQuery.ajax({type:'POST',data:'servicio='+servicioSeleccionado, 
	  			url:obtieneSubservicio,
	  			success:function(data,textStatus){
		  		jQuery('#subServiciosContainer').html(data);
//		  		if(doctorSeleccionado != null && doctorSeleccionado != ""){
//		  			$("#cbDoctores").val(doctorSeleccionado);
//		  			cambioDoctor(doctorSeleccionado);
//		  		} 
  	},
	error:function(XMLHttpRequest,textStatus,errorThrown){}});
}


