	function creaTabla(){
		var objeto 	= 	$("#tablaHoras");
		var horaI 	= 	$("#horaI option:selected").val();
		var minI 	= 	$("#minI option:selected").val();/*
		var horaF	= 	$("#horaF option:selected").val();
		var minF 	= 	$("#minF option:selected").val();*/

	//	var arregloTiempo 	=	aumentaReloj(horaI*100+minI, horaF*100+minF,20);
		var salida="<table>";
		//var l = arregloTiempo.length;
/*
		for (var i=0; i < l; i++){
			salida+="<tr><td>"+arregloTiempo[i]+":</td><td>"+i+"</td></tr>";
		}*/
		salida+="</table>"
		
		objeto.html(salida);
		
	}
	//Se recibe el valor de la hora en entero
	function aumentaReloj(var tiempoIni, var tiempoFin,var intervalo){
		var arreglo = new Array();

			while( tiempoIni < tiempoFin ){
				arreglo.push(tiempoIni);
				tiempo+=intervalo;
				tiempo = asignaTiempo(tiempo);
			}
		return arreglo;
	}

	function asignaTiempo(var tiempo){
	 var minuto =	tiempo%100;
	 var hora 	=	tiempo/100;

	 if ( minuto > 60){
	 	hora++;
	 	minuto = minuto % 60;
	 }	

	 	hora = hora%24;
	}

	function botonTabla(){

	}

	function leeTabla(){
		
		var objeto 	= 	$("#tablaHoras");
		var horaI 	= 	$("#horaI option:selected").val();
		var minI 	= 	$("#minI option:selected").val();
		var horaF	= 	$("#horaF option:selected").val();
		var minF 	= 	$("#minF option:selected").val();

		var arregloTiempo 	=	aumentaReloj(horaI*100+minI, horaF*100+minF,20);
		var salida="<table>";
		var l = arregloTiempo.length;

		for (var i=0; i < l; i++){
			salida+="<tr><td>"+arregloTiempo[i]+":</td><td>"+i+"</td></tr>";
		}
		salida+="</table>"
		
		objeto.html(salida);
	}

