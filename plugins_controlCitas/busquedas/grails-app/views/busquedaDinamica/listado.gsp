<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="mainVentanilla">
    <g:set var="entityName" value="${message(code: 'BusquedaDinamica.label', default: 'Busqueda Dinamica')}" />
    <title>
        <g:message code="default.create.label" args="[entityName]" />
    </title>
</head>
<body>
    <div class="col-sm-5 col-md-6 col-sm-offset-3 col-md-offset-2 main"> 
            <button id="btnExport" onclick="fnExcelReport();"> Exportar a Excel </button>
            <iframe id="txtArea1" style="display:none"></iframe>
            <table class="table table-striped" id="listaResultados">
            <thead>
                <tr>
                        <g:each in="${propiedades}" status="i" var="propiedad">
                                <td>${propiedad}</td>
                        </g:each>
                    
                    
                </tr>

            </thead>
            <tbody>
                <g:each in="${lista}" status="i" var="dato">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <g:each in="${propiedades}" status="j" var="propiedad">
                                <td>${dato[propiedad]}</td>
                        </g:each>                                          
                    </tr>                                
                </g:each>
            </tbody>
        </table>
    </div>
    <script>
            function fnExcelReport()
{
    var tab_text="<table border='2px'><tr bgcolor='#87AFC6'>";
    var textRange; var j=0;
    tab = document.getElementById('listaResultados'); // id of table

    for(j = 0 ; j < tab.rows.length ; j++) 
    {     
        tab_text=tab_text+tab.rows[j].innerHTML+"</tr>";
        //tab_text=tab_text+"</tr>";
    }

    tab_text=tab_text+"</table>";
    tab_text= tab_text.replace(/<A[^>]*>|<\/A>/g, "");//remove if u want links in your table
    tab_text= tab_text.replace(/<img[^>]*>/gi,""); // remove if u want images in your table
    tab_text= tab_text.replace(/<input[^>]*>|<\/input>/gi, ""); // reomves input params

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
    else                 //other browser not tested on IE 11
        sa = window.open('data:application/vnd.ms-excel,' + encodeURIComponent(tab_text));  

    return (sa);
}
    </script>

</body>

</html>