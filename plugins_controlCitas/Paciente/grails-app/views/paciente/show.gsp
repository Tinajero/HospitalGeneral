
<%@ page import="paciente.Paciente" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainVentanilla">
		<g:set var="entityName" value="${message(code: 'paciente.label', default: 'Paciente')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">
			
			<div id="show-paciente" class="content scaffold-show" role="main">
				<h1><g:message code="default.show.label" args="[entityName]" /></h1>
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>												
				<table class="table table-bordered">
  					<tbody>
  						<tr>
  							<td>${pacienteInstance.expediente}</td>  							
  						</tr>
  						<tr>
  							<td rowspan="2">Datos</td>
  							<td><h4>Nombre</h4></td>
  							<td><h4>Apellido Paterno</h4></td>
  							<td><h4>Apellido Materno</h4></td>
  						</tr>
  						<tr>
  							<td>${pacienteInstance.nombre}</td>
  							<td>${pacienteInstance.apellidoPaterno}</td>
  							<td>${pacienteInstance.apellidoMaterno}</td>
  						</tr>
  						<tr>
  							<td><b>Telefono<b></td>
  							<td colspan="3">${pacienteInstance.numeroTelefono}</td>  					
  						</tr>
  						<tr>
  							<td><b>Localidad</b></td>
  							<td colspan="3">${pacienteInstance.poblacion}</td>
  						</tr>
  					</tbody>	
				</table>
				<div align="center">
					<g:form url="[resource:pacienteInstance, action:'delete']" method="DELETE">
					<fieldset class="buttons">
						<g:link class="btn btn-info" action="edit" id="${pacienteInstance.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
				</div>
				
        <h3> Historial </h3>
        <table class="table table-bordered">
          <thead>
            <tr>
              <th>Fecha</th>
              <th>Hora</th>
              <th>M&eacutoe;dico</th>
              <th>Tipo de Cita</th>
            </tr>
          </thead>
          <g:each in="${historialCitas}" var="historial">
            <tr>
              <td><g:formatDate format=" EEEE dd 'de' MMMMMM 'del' yyyy" date="${historial.fecha}"/></td>
              <td><g:formatDate format="HH:mm" date="${historial.fecha}"/></td>
              <td>${historial.doctor.nombre} ${historial.doctor.apellidoPat} ${historial.doctor.apellidoMat}</td>
              <td>${historial.doctor.tipoCita}</td>              
            </tr>
          </g:each>
        </table>


			</div>
		</div>
	</body>
</html>
