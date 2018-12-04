
<%@ page import="doctor.Servicio" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainAdmin">
		<g:set var="entityName" value="${message(code: 'servicio.label', default: 'Servicio')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
				
		<div id="list-servicio" class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main panel panel-info" role="main">					
			<div class="panel-heading">
			  		<div class="row">
			  			<h1 class="col-md-9"><g:message code="default.list.label" args="[entityName]" /></h1>
						<g:link class="btn btn-primary col-md-3" action="create" role="button" sytle="margin-top: 20px;"
						 data-toggle="tooltip" title="Crea un nuevo Servicio">
							<g:message code="default.new.label" args="[entityName]" /> &nbsp;&nbsp;
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
						</g:link>
					</div>
			</div>
			
			<table class="table table-striped">
			<thead>
					<tr>
						<g:sortableColumn property="nombre" title="${message(code: 'servicio.nombre.label', default: 'Nombre')}" />
						<g:sortableColumn property="descripcion" title="${message(code: 'servicio.descripcion.label', default: 'Descripcion')}" />					
					</tr>
				</thead>
				<tbody>
				
				<g:each in="${servicioInstanceList}" status="i" var="servicioInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">						
						<td> <g:link action="show" id="${servicioInstance.id}">${fieldValue(bean: servicioInstance, field: "nombre")} </g:link></td>
						<td>${fieldValue(bean: servicioInstance, field: "descripcion")}</td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${servicioCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
