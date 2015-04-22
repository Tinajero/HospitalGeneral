	//Se recibe el valor de la hora en entero
	function aumentaReloj(tiempoIni, tiempoFin,intervalo){
		var arreglo = new Array();

			while( tiempoIni < tiempoFin ){
				arreglo.push(asignaTiempo(tiempoIni));
				tiempoIni+=intervalo;
			}

		return arreglo;
	}

	function asignaTiempo(tiempo){

		 var minutos =	tiempo%60;
		 var horas 	 =	tiempo/60;
		 hora = horas%24;

		 if (minutos.toString().length == 1)
		 	minutos="0"+minutos;
		 
		 return ""+formato(horas)+":"+minutos;
	}
	function formato(valor){
		if (valor<10){
			return "0"+valor.toString().substring(0,1);
		}
		return valor.toString().substring(0,2);
	}

	function leeTabla(){
		
		var objeto 	= 	$("#tablaHoras");
		var horaI 	= 	$("#horaI option:selected").val();
		var minI 	= 	$("#minI option:selected").val();
		var horaF	= 	$("#horaF option:selected").val();
		var minF 	= 	$("#minF option:selected").val();
		var tI 		=	(horaI*60);
		var tF 		=	(horaF*60);

			tI += + minI;
			tF += + minF;

		var arregloTiempo 	=	aumentaReloj(tI,tF ,20);
		var salida="<table>";
		var l = arregloTiempo.length;
		
		salida+="<tr><td> Turno </td><td> Horario </td></tr>";
		for (var i=0; i < l; i++){
			salida+="<tr><td>"+i+"</td><td>"+arregloTiempo[i]+"</td></tr>";
		}
	
		salida+="</table>"
		objeto.html(salida);
	}

