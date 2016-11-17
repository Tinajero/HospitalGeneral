var Autocomplete = function(){
    function autocompleteExpediente() {
        $('#expediente_textField').on("keyup", function(){
            value = $(this).val();
        
                $.ajax({
                    type: "GET",
                    url: "autocompleteByExpediente",
                    data: {
                        'expediente' : value
                    },
                    dataType: "json",
                    success: function(response){
                        var datos =
                        $.map(response, function(item){
                            return {
                                value: item.expediente,
                                apaterno: item.apellidoPaterno,
                                amaterno: item.apellidoMaterno,
                                nombre: item.nombre,
                                poblacion: item.poblacion,
                                telefono: item.numeroTelefono
                            }
                        });

                        $('#expediente_textField').autocomplete({
                            source: datos,
                            select: function (event, ui){
                                $('#expediente_textField').val(ui.item.value);
                                $('#apaterno').val(ui.item.apaterno);
                                $('#amaterno').val(ui.item.amaterno);
                                $('#nombre').val(ui.item.nombre);
                                $('#poblacion').val(ui.item.poblacion);
                                $('#telefono').val(ui.item.telefono);
                            }
                        });
                    }
                });

        });
    }
    function autocompleteNombre() {
        $('#nombre').on("keyup", function(){
            value = $(this).val();
            if($('#tipoCita').val() == '2'){ //esto para que solo haga el autocomplete en tipo de cita Subsecuente
                $.ajax({
                    type: "GET",
                    url: "autocompleteByNombre",
                    data: {
                        'nombre' : value
                    },
                    dataType: "json",
                    success: function(response){
                        var datos =
                        $.map(response, function(item){
                            return{
                                value: item.apellidoPaterno + " " + item.apellidoMaterno + " " +item.nombre, //busca por nombre
                                expediente: item.expediente,
                                nombre: item.nombre,
                                apaterno: item.apellidoPaterno,                   
                                amaterno: item.apellidoMaterno,
                                poblacion: item.poblacion,
                                telefono: item.numeroTelefono
                            }
                        });

                        $("#nombre").autocomplete({
                            source: datos,
                            select: function (event, ui){                                
                                $('#expediente_textField').val(ui.item.expediente);
                                $('#apaterno').val(ui.item.apaterno);
                                $('#amaterno').val(ui.item.amaterno);
                                $('#nombre').val(ui.item.nombre);
                                $('#poblacion').val(ui.item.poblacion);
                                $('#telefono').val(ui.item.telefono);   
                            }
                        });
                    }
                });
            }
        });
        $('#apaterno').on("keyup", function(){
            value = $(this).val();
            if($('#tipoCita').val() == '2'){ //esto para que solo haga el autocomplete en tipo de cita Subsecuente
                $.ajax({
                    type: "GET",
                    url: "autocompleteByApaterno",
                    data: {
                        'apaterno' : value
                    },
                    dataType: "json",
                    success: function(response){
                        var datos =
                        $.map(response, function(item){
                            return{
                                value: item.apellidoPaterno + " " + item.apellidoMaterno + " " +item.nombre, //busca por apellidoPaterno
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
                            select: function (event, ui){                                
                                $('#expediente_textField').val(ui.item.expediente);
                                $('#apaterno').val(ui.item.apaterno);
                                $('#amaterno').val(ui.item.amaterno);
                                $('#nombre').val(ui.item.nombre);
                                $('#poblacion').val(ui.item.poblacion);
                                $('#telefono').val(ui.item.telefono);   
                            }
                        });
                    }
                });
            }
        });
        $('#amaterno').on("keyup", function(){
            value = $(this).val();
            if($('#tipoCita').val() == '2'){ //esto para que solo haga el autocomplete en tipo de cita Subsecuente
                $.ajax({
                    type: "GET",
                    url: "autocompleteByAmaterno",
                    data: {
                        'amaterno' : value
                    },
                    dataType: "json",
                    success: function(response){
                        var datos =
                        $.map(response, function(item){
                            return{
                                value: item.apellidoPaterno + " " + item.apellidoMaterno + " " +item.nombre, //busca por apellidoMaterno
                                expediente: item.expediente,
                                nombre: item.nombre,
                                apaterno: item.apellidoPaterno,                   
                                amaterno: item.apellidoMaterno,
                                poblacion: item.poblacion,
                                telefono: item.numeroTelefono
                            }
                        });

                        $("#amaterno").autocomplete({
                            source: datos,
                            select: function (event, ui){                                
                                $('#expediente_textField').val(ui.item.expediente);
                                $('#apaterno').val(ui.item.apaterno);
                                $('#amaterno').val(ui.item.amaterno);
                                $('#nombre').val(ui.item.nombre);
                                $('#poblacion').val(ui.item.poblacion);
                                $('#telefono').val(ui.item.telefono);
                            }
                        });
                    }
                });
            }
        });
    }
    return{
        autoCompleteByExpediente : autocompleteExpediente,
        autoCompleteByNombre : autocompleteNombre
    }
}();

$(function(){
    Autocomplete.autoCompleteByExpediente();
    Autocomplete.autoCompleteByNombre();
});

                    /*$("#expediente_textField").autocomplete({
                        source: datos,
                        //focus: function (event, ui){
                        select: function (event, ui){
                            //console.log("selected expediente:" + ui.item.value);
                            //console.log("selected apellidoPaterno:" + ui.item.apaterno);
                            //console.log("selected apellidoPaterno:" + ui.item.amaterno);
                            //console.log("selected nombre:" + ui.item.nombre);
                            //console.log("selected poblacion:" + ui.item.poblacion);
                            //console.log("selected telefono:" + ui.item.telefono);
     
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
                    });*/

