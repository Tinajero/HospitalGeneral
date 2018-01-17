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

	$(document).ready(function(){ 
		 $("#curpDoctor").mask('ABCDEFGHIJKLMNOPQR', {'translation': {
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
	});

