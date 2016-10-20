//Genera autocomplete solo por Expediente
    $(document).ready(function() {

          
        console.log("here "+window.location.pathname);
      
        if (window.location.pathname == "/controlCitas/cita/create"){
    		$.ajax({
            	type: "GET",
    	        url: "AutocompletadoEnCitas",
    	        dataType: "json",
    	        success : function(response) { 
    				var datos =
                    $.map(response, function(item){
                 
                        return{
                            value: item.expediente, 	//busca por expediende                        
                            apaterno: item.apellidoPaterno,
                            amaterno: item.apellidoMaterno,
                            nombre: item.nombre,
                            poblacion: item.poblacion,
                            telefono: item.numeroTelefono
                        }

                    });
                    
                    $("#expediente_textField").autocomplete({
                    	source: datos,
                    	//focus: function (event, ui){
                    	select: function (event, ui){
                        	console.log("selected expediente:" + ui.item.value);
                        	console.log("selected apellidoPaterno:" + ui.item.apaterno);
                        	console.log("selected apellidoPaterno:" + ui.item.amaterno);
                        	console.log("selected nombre:" + ui.item.nombre);
                        	console.log("selected poblacion:" + ui.item.poblacion);
                        	console.log("selected telefono:" + ui.item.telefono);
     
                        	$('#expediente_textField').val(ui.item.value);
                        	$('#apaterno').val(ui.item.apaterno);
                        	$('#amaterno').val(ui.item.amaterno);
                        	$('#nombre').val(ui.item.nombre);
                        	$('#poblacion').val(ui.item.poblacion);
                        	$('#telefono').val(ui.item.telefono);
                        	//desactivamos los inputs una vez seleccionado el paciente
                        	document.getElementById('expediente_textField').readOnly=true;
                        	document.getElementById('apaterno').readOnly=true;
                        	document.getElementById('amaterno').readOnly=true;
                        	document.getElementById('nombre').readOnly=true;
                        	document.getElementById('poblacion').readOnly=true;
                        	document.getElementById('telefono').readOnly=true;
                    	}
                	});
                
            	}
    		});
        }

                    
    });
	      
	      //Genera autocomplete por apellidoPaterno + apellidoMaterno + Nombre
$(document).ready(function() {
    if (window.location.pathname == "/controlCitas/cita/create"){
        $.ajax({
            type: "GET",
            url: "AutocompletadoEnCitas",
            dataType: "json",
            success : function(response) {
            	 
            	var datos =
                $.map(response, function(item){
                
                    return{
                        value: item.apellidoPaterno + " " + item.apellidoMaterno + " " +item.nombre, //busca por apellidoPaterno + apellidoMaterno + nombre
                        expediente: item.expediente,
                        nombre: item.nombre,
            		    apaterno: item.apellidoPaterno,                   
                        amaterno: item.apellidoMaterno,
                        poblacion: item.poblacion,
                        telefono: item.numeroTelefono

                    }

                });

                $("#apaterno").autocomplete({
                	source: datos,
                	//focus: function (event, ui){
                    focus: function(event, ui) {
                        // prevent autocomplete from updating the textbox
                        event.preventDefault();
                        // manually update the textboxs
                        $('#expediente_textField').val(ui.item.expediente);
                        $(this).val(ui.item.apaterno);
                        $('#amaterno').val(ui.item.amaterno);
                        $('#nombre').val(ui.item.nombre);
                        $('#poblacion').val(ui.item.poblacion);
                        $('#telefono').val(ui.item.telefono);
                    },
                	select: function (event, ui){
                    	console.log("selected expediente:" + ui.item.expediente);
                    	console.log("selected apellidoPaterno:" + ui.item.apaterno);
                    	console.log("selected apellidoPaterno:" + ui.item.amaterno);
                    	console.log("selected nombre:" + ui.item.nombre);
                    	console.log("selected poblacion:" + ui.item.poblacion);
                    	console.log("selected telefono:" + ui.item.telefono);

                    	event.preventDefault();
            			
                    	$('#expediente_textField').val(ui.item.expediente);
                    	$('#apaterno').val(ui.item.apaterno);
                    	$('#amaterno').val(ui.item.amaterno);
                    	$('#nombre').val(ui.item.nombre);
                    	$('#poblacion').val(ui.item.poblacion);
                    	$('#telefono').val(ui.item.telefono);
                    	//desactivamos los inputs una vez seleccionado el paciente
                    	document.getElementById('expediente_textField').readOnly=true;
                    	document.getElementById('apaterno').readOnly=true;
                    	document.getElementById('amaterno').readOnly=true;
                    	document.getElementById('nombre').readOnly=true;
                    	document.getElementById('poblacion').readOnly=true;
                    	document.getElementById('telefono').readOnly=true;            
                	}
            	});
            }
        });
    }
});
