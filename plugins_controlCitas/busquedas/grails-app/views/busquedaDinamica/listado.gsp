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
            
             <g:if test="${ lista.size() != 0 }">
	            <button id="btnExport" onclick="fnExcelReport();"> Exportar a Excel </button>
	            <iframe id="txtArea1" style="display:none"></iframe>
            </g:if>
            <g:if test="${ lista.size() == 0 }">
            	No se encontraron datos.
            </g:if>
            
            <g:each in="${lista}" status="i" var="doctor">
            	
            	<g:each in="${doctor.fechas}" status="j" var="fecha">
            		
		            <table class="table table-striped" id="listaResultados${doctor.idDoctor}${j}">
			            <thead>
			            	
				            	<tr >
				            		<g:if test="${doctor.containsKey('nombreDoctor')}">
				            			<td colspan="${propiedades.size()-1}">Doctor: ${doctor.nombreDoctor} ${doctor.paternoDoctor} ${doctor.maternoDoctor}</td>
				            		</g:if>
				            		<td> ${fecha.fecha} </td>
				            	<tr>
				            
				            	
			                <tr>
		                        <g:each in="${propiedades}" status="n" var="propiedad">
		                                <g:if test="${propiedad == "Telefono" }">
		                                	<td>Tel&eacute;fono</td>
		                                </g:if>
		                                <g:else>
		                                	<td>${propiedad}</td>
		                                </g:else>
		                                
		                                
		                        </g:each>                                        
			                </tr>
			            </thead>
			            <tbody>
			            	
			                <g:each in="${fecha.citas}" status="m" var="dato">
			                    <tr class="${(m % 2) == 0 ? 'even' : 'odd'}">
			                        <g:each in="${propiedades}" status="n" var="propiedad">
			                                <td>${dato[propiedad]}</td>
			                        </g:each>                                          
			                    </tr>                                
			                </g:each>
			            </tbody>
		        	</table>
		        	<br>
		        </g:each>
	        </g:each>
        
    </div>
    <script>




    </script>

</body>

 </html>


