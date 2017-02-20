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
})
function leerTabla(){

	$('#tablaHorarios tr').each(function(index){
	
		$(this).children("td").each(function(index2){
			
			var tipoHora = ""
			if ($(this).hasClass("primeraVez"))
		    	tipoHora = "primeraVez"
		   	else if ($(this).hasClass("subsecuente"))
		   		tipoHora = "subsecuente"
		
			if (tipoHora != ""){
				var idCelda = $(this).attr('id');
				var hora = $(this).find("span:first").html();
				var par = {'hora':hora.split(":")[0],'minuto':hora.split(":")[1], 'tipoHora':tipoHora};			
				var fila = obtenerFila(idCelda);
				var columna = obtenerColumna(idCelda);
				matrizDias[ columna ][ fila ] = par;	
				
				tope[columna]++;
				if (maxTope < tope[columna]) maxTope = tope[columna];	
							
			}
		});

		
		
		   	        	
	});
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
				cadena +=  "<td id='f" + j + "_c"+ i +"' class='"+ matrizDias[j][i].tipoHora +" centrado'>" 
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
/**funcion que agrega una fila a una tabla*/
function agregarFila() {
   
	var dias = obtenerDiasMarcados();
    //console.log("click");
    var tipoHora;
    if ($("#tipoHora").is(":checked"))
    	tipoHora = "primeraVez"
   	else
   		tipoHora = "subsecuente"
    var hora = $("#horarioInput").val();		
	//-------------
	if(hora){				
		for (var i = 0; i < dias.length ; i++ ) {
			if (dias[i]) {
				var par = {'hora':hora.split(":")[0],'minuto':hora.split(":")[1], 'tipoHora':tipoHora};
				matrizDias[i][ tope[i] ] = par;
				tope[i]++;
				if (maxTope < tope[i]) maxTope = tope[i];
			}										
		}
		pintarMatriz();
	}
	
	//-----------
    if ( hora && tieneFormato(hora) ){
        counter++;
        var newRow = jQuery('<tr><td id="renglon'+ counter +'">'+
            hora +'</td><td>' +
            tipoHora +'</td><td>' +
            '<a href="" class="eliminarFila" class="btn btn-default">Quitar hora</a>' 
            + '</td></tr>' );	       
        jQuery('#tablaHoras').append(newRow);
        $('#cajaWarning').empty();	   
         $('.eliminarFila').click(function(event) {
    	event.preventDefault();
        console.log("click Eliminar");
        $(this).parent().parent().remove();
    });
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
