
<%@ page import="doctor.DiaSinCita"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="mainAdmin">
<g:set var="entityName"
	value="${message(code: 'diaSinCita.label', default: 'DiaSinCita')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
	<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">
		<%--		<a href="#list-diaSinCita" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>--%>
		<%--		<div class="nav" role="navigation">--%>
		<%--			<ul>--%>
		<%--				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--%>
		<%--				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>--%>
		<%--			</ul>--%>
		<%--		</div>--%>
		<div id="list-diaSinCita" class="content scaffold-list" role="main">
			<h1>
				<g:message code="default.list.label" args="[entityName]" />
			</h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">
					${flash.message}
				</div>
			</g:if>
			
			<div class="panel panel-info">
			<div class="panel-heading">
		  		<div class="row">
		  			<h1 class="col-md-9"><g:message code="default.list.label" args="[entityName]" /></h1>
					<g:link class="btn btn-primary col-md-3" action="create" role="button" sytle="margin-top: 20px;" data-toggle="tooltip" title="Crea un nuevo Doctor">
					<g:message code="default.new.label" args="[entityName]" /> &nbsp;&nbsp;
					<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
					</g:link>
				</div>
		  	</div>
			<table class="table table-striped">
				<thead>
					<tr>

						<th><g:message code="diaSinCita.medico.label"
								default="Medico" /></th>
						
							<g:sortableColumn property="fechaInicio" 
							title="${message(code: 'diaSinCita.fechaInicio.label', default: 'Fecha Inicio')}" />
							<g:sortableColumn property="fechaFin" 
							title="${message(code: 'diaSinCita.fechaInicio.label', default: 'Fecha Fin')}" />
						

					</tr>
				</thead>
				<tbody>
					<g:each in="${diaSinCitaInstanceList}" status="i" var="diaSinCita">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
							
							<td>
								<g:link action="show" id="${diaSinCita.id}">
									${fieldValue(bean: diaSinCita, field: "medico.nombre")}
									${fieldValue(bean: diaSinCita, field: "medico.apellidoPat")}
									${fieldValue(bean: diaSinCita, field: "medico.apellidoMat")}
								</g:link>
							</td>
							<td>
								<g:formatDate format="dd/MMMM/yyyy" date="${diaSinCita.fechaInicio}" />								
							</td>
							<td>
								<g:formatDate format="dd/MMMM/yyyy" date="${diaSinCita.fechaFin}" />								
							</td>
						</tr>
					</g:each>
				</tbody>
			</table>
			</div>
			<div class="pagination">
				<g:paginate total="${diaSinCitaCount ?: 0}" />
			</div>
		</div>
	</div>
</body>
</html>
