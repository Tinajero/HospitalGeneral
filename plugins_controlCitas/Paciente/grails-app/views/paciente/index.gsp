
<%@ page import="paciente.Paciente" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainVentanilla">
		<g:set var="entityName" value="${message(code: 'paciente.label', default: 'Paciente')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">
			
			<div id="list-paciente" class="content scaffold-list" role="main">
				<h1><g:message code="default.list.label" args="[entityName]" /></h1>
				<g:if test="${flash.message}">
					<div class="message" role="status">${flash.message}</div>
				</g:if>
				<table class="table table-striped">
				<thead>
						<tr>

							<g:sortableColumn property="apellidoPaterno" title="${message(code: 'paciente.apellidoPaterno.label', default: 'Apellido Paterno')}" />

							<g:sortableColumn property="apellidoMaterno" title="${message(code: 'paciente.apellidoMaterno.label', default: 'Apellido Materno')}" />

							<g:sortableColumn property="nombre" title="${message(code: 'paciente.nombre.label', default: 'Nombre')}" />

							<g:sortableColumn property="expediente" title="${message(code: 'paciente.expediente.label', default: 'Expediente')}" />

						</tr>
					</thead>
					<tbody>
					<g:each in="${pacienteInstanceList}" status="i" var="pacienteInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

							<td><g:link action="show" id="${pacienteInstance.id}">${fieldValue(bean: pacienteInstance, field: "apellidoPaterno")}</g:link></td>

							<td>${fieldValue(bean: pacienteInstance, field: "apellidoMaterno")}</td>

							<td>${fieldValue(bean: pacienteInstance, field: "nombre")}</td>

							<td>${fieldValue(bean: pacienteInstance, field: "expediente")}</td>

						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<g:paginate total="${pacienteCount ?: 0}" />
				</div>
			</div>
		</div>
	</body>
</html>
