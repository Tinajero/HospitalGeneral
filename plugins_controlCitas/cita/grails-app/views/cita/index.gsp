
<%@ page import="cita.Cita" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainVentanilla">
		<g:set var="entityName" value="${message(code: 'cita.label', default: 'Cita')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">
	<%--<a href="#list-cita" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>--%>
	<%--<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>--%>
		<div id="list-cita" class="content scaffold-list" role="main">
			<%--<h1><g:message code="default.list.label" args="[entityName]" /></h1>--%>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<div class="panel panel-info">
				<!-- Default panel contents -->
			  	<div class="panel-heading">
			  		<div class="row">
			  			<h1 class="col-md-9"><g:message code="default.list.label" args="[entityName]" /></h1>
						<g:link class="btn btn-primary col-md-2" action="create" role="button" sytle="margin-top: 20px;" data-toggle="tooltip" title="Crea una nueva Cita">
						<g:message code="default.new.label" args="[entityName]" /> &nbsp;&nbsp;
						<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
						</g:link>
					</div>
			  	</div>
				<table class="table table-striped">
					<thead>
						<tr>
						
						<g:sortableColumn property="fecha" title="${message(code: 'cita.fecha.label', default: 'Fecha')}" />
						

							<th><g:message code="cita.doctor.label" default="M&eacute;dico" /></th>
							
							<th><g:message code="cita.paciente.label" default="Expediente" /></th>		
							<th><g:message code="cita.paciente.label" default="Paciente" /></th>
							
							<td><b>Opciones</b></td>	
						
						</tr>
					</thead>
					<tbody>
						<g:each in="${citaInstanceList}" status="i" var="citaInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
							
							<td><g:formatDate format="dd/MM/yyyy" date="${citaInstance.fecha}" /></td>

							<td>${citaInstance.doctor.nombre} ${citaInstance.doctor.apellidoPat} ${citaInstance.doctor.apellidoMat}</td>
							<td>${citaInstance.paciente.expediente}</td>
							<td> ${citaInstance.paciente.apellidoPaterno} ${citaInstance.paciente.apellidoMaterno} ${citaInstance.paciente.nombre} </td>							
				
		
							<td> 
								<g:link action="show" id="${citaInstance.id}"><span class="glyphicon glyphicon-eye-open" aria-hidden="true" data-toggle="tooltip" title="Mostrar"></span></g:link> &nbsp;
<%--								<g:link action="delete" id="${citaInstance.id}"><span class="glyphicon glyphicon-trash" --%>
<%--									aria-hidden="true"></span>--%>
<%--								</g:link> --%>
<%--									&nbsp;--%>
								<g:link action="edit" id="${citaInstance.id}"><span class="glyphicon glyphicon-pencil" aria-hidden="true" data-toggle="tooltip" title="Editar"></span></g:link> &nbsp;
							</td>
						</tr>
						</g:each>
					</tbody>
				</table>
				</div>
				</div>
			<div class="pagination">
				<g:paginate total="${citaCount ?: 0}" />
			</div>
		</div>
	</div>
	</body>
</html>
