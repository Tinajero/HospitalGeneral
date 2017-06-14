var changeTipoCita = function(){
   $('#tipoCita').change(function(){
      readOnlyInputs(false);
      $('#expediente_textField').val('');
      $('#apaterno').val('');
      $('#amaterno').val('');
      $('#nombre').val('');
      $('#poblacion').val('');
      $('#telefono').val('');
   });
}
var focus = function(){
   $('#expediente_textField').focusin(function(){      
         $(this).prop('readonly', false);      
   });
   $('#expediente_textField').focusout(function(){      
         $(this).prop('readonly', true);      
   });
   $('#nombre').focusin(function(){      
         $(this).prop('readonly', false);      
   });
   $('#nombre').focusout(function(){      
         $(this).prop('readonly', true);      
   });
   $('#apaterno').focusin(function(){      
         $(this).prop('readonly', false);      
   });
   $('#apaterno').focusout(function(){      
         $(this).prop('readonly', true);      
   });
   $('#amaterno').focusin(function(){      
         $(this).prop('readonly', false);
   });
   $('#amaterno').focusout(function(){      
         $(this).prop('readonly', true);      
   });
   $('#poblacion').focusin(function(){      
         $(this).prop('readonly', false);
   });
   $('#poblacion').focusout(function(){      
         $(this).prop('readonly', true);      
   });
   $('#telefono').focusin(function(){      
         $(this).prop('readonly', false);
   });
   $('#telefono').focusout(function(){      
         $(this).prop('readonly', true);      
   });
   $('#curp').focusin(function(){      
         $(this).prop('readonly', false);
   });
   $('#curp').focusout(function(){      
         $(this).prop('readonly', true);      
   });
   $('#folioSeguroPopular').focusin(function(){      
         $(this).prop('readonly', false);
   });
   $('#folioSeguroPopular').focusout(function(){      
         $(this).prop('readonly', true);      
   });
}
var readOnlyInputs = function(value){
   $('#expediente_textField').prop('readonly', value);
   $('#apaterno').prop('readonly', value);
   $('#amaterno').prop('readonly', value);
   $('#nombre').prop('readonly', value);
   $('#poblacion').prop('readonly', value);
   $('#telefono').prop('readonly', value);
   $('#curp').prop('readonly', value);
   $('#folioSeguroPopular').prop('readonly', value);
}

var Autocomplete = function(){
    function autocompleteExpediente() {
        $('#expediente_textField').on("keyup", function(){
            value = $(this).val();
         //   if($('#tipoCita').val() == '1'){
               if(value.length >= 4){
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
                                  telefono: item.numeroTelefono,
                                  curp: item.curp,
                                  folioSeguroPopular: item.folioSeguroPopular

                              }
                          });

                          $('#expediente_textField').autocomplete({
                              source: datos,
                              select: function (event, ui){
                                  event.preventDefault();
                                  $('#expediente_textField').val(ui.item.value);
                                  $('#apaterno').val(ui.item.apaterno);
                                  $('#amaterno').val(ui.item.amaterno);
                                  $('#nombre').val(ui.item.nombre);
                                  $('#poblacion').val(ui.item.poblacion);
                                  $('#telefono').val(ui.item.telefono);
                                  $('#curp').val(ui.item.curp);
                                  $('#folioSeguroPopular').val(ui.item.folioSeguroPopular);
                                  readOnlyInputs(true);
                              }
                          });
                      }
                  });
               }
               if(value.length == 8){
                  $.ajax({
                      type: "GET",
                      url: "autocompleteByFullExpediente",
                      data: {
                          'expediente' : value
                      },
                      dataType: "json",
                      success: function(response){
                        if(response.length > 0){
                          $('#expediente_textField').val(response[0].expediente);
                          $('#apaterno').val(response[0].apellidoPaterno);
                          $('#amaterno').val(response[0].apellidoMaterno);
                          $('#nombre').val(response[0].nombre);
                          $('#poblacion').val(response[0].poblacion);
                          $('#telefono').val(response[0].numeroTelefono);
                          $('#curp').val(response[0].curp);
                          $('#folioSeguroPopular').val(response[0].folioSeguroPopular);
                          readOnlyInputs(true);
                        }
                      }
                  });
               }
           // }
        });
    }
    function autocompleteNombre() {
        $('#nombre').on("keyup", function(){
            value = $(this).val();
       ///     if($('#tipoCita').val() == '1'){ //esto para que solo haga el autocomplete en tipo de cita Subsecuente
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
                                telefono: item.numeroTelefono,
                                curp: item.curp,
                                folioSeguroPopular: item.folioSeguroPopular
                            }
                        });

                        $("#nombre").autocomplete({
                            source: datos,
                            select: function (event, ui){
                                event.preventDefault();
                                $('#expediente_textField').val(ui.item.expediente);
                                $('#apaterno').val(ui.item.apaterno);
                                $('#amaterno').val(ui.item.amaterno);
                                $('#nombre').val(ui.item.nombre);
                                $('#poblacion').val(ui.item.poblacion);
                                $('#telefono').val(ui.item.telefono);
                                $('#curp').val(ui.item.curp);
                                $('#folioSeguroPopular').val(ui.item.folioSeguroPopular);
                                readOnlyInputs(true);
                            }
                        });
                    }
                });
      //      }
        });
        $('#apaterno').on("keyup", function(){
            value = $(this).val();
         //   if($('#tipoCita').val() == '1'){ //esto para que solo haga el autocomplete en tipo de cita Subsecuente
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
                                value: item.apellidoPaterno + " " + item.apellidoMaterno + " " +item.nombre,//busca por apellidoPaterno
                                expediente: item.expediente,
                                nombre: item.nombre,
                                apaterno: item.apellidoPaterno,
                                amaterno: item.apellidoMaterno,
                                poblacion: item.poblacion,
                                telefono: item.numeroTelefono,
                                curp: item.curp,
                                folioSeguroPopular: item.folioSeguroPopular
                            }
                        });

                        $("#apaterno").autocomplete({
                            source: datos,
                            select: function (event, ui){
                                event.preventDefault();
                                $('#expediente_textField').val(ui.item.expediente);
                                $(this).val(ui.item.apaterno);
                                $('#amaterno').val(ui.item.amaterno);
                                $('#nombre').val(ui.item.nombre);
                                $('#poblacion').val(ui.item.poblacion);
                                $('#telefono').val(ui.item.telefono);
                                 $('#curp').val(ui.item.curp);
                                $('#folioSeguroPopular').val(ui.item.folioSeguroPopular);
                                readOnlyInputs(true);
                            }
                        });
                    }
                });
          //  }
        });
        $('#amaterno').on("keyup", function(){
            value = $(this).val();
         //   if($('#tipoCita').val() == '1'){ //esto para que solo haga el autocomplete en tipo de cita Subsecuente
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
                                telefono: item.numeroTelefono,
                                curp: item.curp,
                                folioSeguroPopular: item.folioSeguroPopular
                            }
                        });

                        $("#amaterno").autocomplete({
                            source: datos,
                            select: function (event, ui){
                                event.preventDefault();
                                $('#expediente_textField').val(ui.item.expediente);
                                $('#apaterno').val(ui.item.apaterno);
                                $(this).val(ui.item.amaterno);
                                $('#nombre').val(ui.item.nombre);
                                $('#poblacion').val(ui.item.poblacion);
                                $('#telefono').val(ui.item.telefono);
                                 $('#curp').val(ui.item.curp);
                                $('#folioSeguroPopular').val(ui.item.folioSeguroPopular);
                                readOnlyInputs(true);
                            }
                        });
                    }
                });
       //     }
        });
    }
    return{
        autoCompleteByExpediente : autocompleteExpediente,
        autoCompleteByNombre : autocompleteNombre
    }
}();

$(function(){
    changeTipoCita();
    focus();
    Autocomplete.autoCompleteByExpediente();
    Autocomplete.autoCompleteByNombre();
});