
<%@ page import="doctor.SubServicio"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="mainAdmin">
<g:set var="entityName"
	value="${message(code: 'SubServicio.label', default: 'SubServicio')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>

	<div id="list-SubServicio"
		class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main panel panel-info"
		role="main">
		<g:if test="${flash.message}">
			<div class="alert alert-warning" role="alert">
				${flash.message}
			</div>
		</g:if>

		<div class="panel-heading">
			<div class="row">
				<h1 class="col-md-9">
					<g:message code="default.list.label" args="[entityName]" />
				</h1>
				<g:link class="btn btn-primary col-md-3" action="create"
					role="button" sytle="margin-top: 20px;" data-toggle="tooltip"
					title="Crea un nuevo subServicio">
					<g:message code="default.new.label" args="[entityName]" /> &nbsp;&nbsp;
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
				</g:link>
			</div>
		</div>

		<table class="table table-striped">
			<thead>
				<tr>
					<g:sortableColumn property="nombre"
						title="${message(code: 'subServicio.nombre.label', default: 'Nombre')}" />
					<g:sortableColumn property="descripcion"
						title="${message(code: 'subServicio.descripcion.label', default: 'Descripcion')}" />

				</tr>
			</thead>
			<tbody>
				<g:each in="${subServicioInstanceList}" status="i"
					var="subServicioInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td><g:link action="show" id="${subServicioInstance.id}">
								${fieldValue(bean: subServicioInstance, field: "nombre")}
							</g:link></td>
						<td>
							${fieldValue(bean: subServicioInstance, field: "descripcion")}
						</td>
					</tr>
				</g:each>
			</tbody>
		</table>
		<div class="pagination">
			<g:paginate total="${subServicioCount ?: 0}" />
		</div>
	</div>
</body>
</html>
