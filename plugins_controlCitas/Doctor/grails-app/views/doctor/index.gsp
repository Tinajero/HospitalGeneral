
<%@ page import="doctor.Doctor" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainAdmin">
		<g:set var="entityName" value="${message(code: 'doctor.label', default: 'Médico')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">
<%--		<a href="#list-doctor" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>--%>
<%--		<div class="nav" role="navigation">--%>
<%--			<ul>--%>
<%--				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--%>
<%--				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>--%>
<%--			</ul>--%>
<%--		</div>--%>
		<div id="list-doctor" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<div class="panel panel-info">
			  <!-- Default panel contents -->
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
						<g:sortableColumn property="nombre" title="${message(code: 'doctor.nombre.label', default: 'Nombre')}" />
						
						<g:sortableColumn property="apellidoPat" title="${message(code: 'doctor.apellidoPat.label', default: 'Apellido Paterno')}" />
						
						<g:sortableColumn property="apellidoMat" title="${message(code: 'doctor.apellidoMat.label', default: 'Apellido Materno')}" />
					
						<g:sortableColumn property="tipoCita" title="${message(code: 'doctor.tipoCita.label', default: 'Tipo de Cita')}" />
						<g:sortableColumn property="diasLaborales" title="${message(code: 'doctor.diasLaborales.label', default: 'Dias Laborales')}" />
<%--						<g:sortableColumn property="diasLaborales" title="${message(code: 'doctor.diasLaborales.label', default: 'Dias Laborales')}" />--%>
<%--					--%>
<%--						<g:sortableColumn property="diasNoLaborales" title="${message(code: 'doctor.diasNoLaborales.label', default: 'Dias No Laborales')}" />--%>
<%--					--%>
<%--						<g:sortableColumn property="horario" title="${message(code: 'doctor.horario.label', default: 'Horario')}" />--%>
					
						<td><b>Opciones</b></td>	
					
					</tr>
				</thead>
				<tbody>
<%--				<g:each in="${doctorList}" status="i" var="doctor">--%>
					<g:each in="${doctorInstanceList}" status="i" var="doctorInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
<%--						<td><g:link action="show" id="${doctor.id}">${fieldValue(bean: doctor, field: "apellidoMat")}</g:link></td>--%>
						<td>${fieldValue(bean: doctorInstance, field: "nombre")}</td>
					
						<td>${fieldValue(bean: doctorInstance, field: "apellidoPat")}</td>
						
						<td>${fieldValue(bean: doctorInstance, field: "apellidoMat")}</td>
						
						<td>${fieldValue(bean: doctorInstance, field: "tipoCita.nombre")}</td>

						<td>${fieldValue(bean: doctorInstance, field: "diasLaborales")}</td>
					
<%--						<td>${fieldValue(bean: doctorInstance, field: "diasLaborales")}</td>--%>

<%--						<td>${fieldValue(bean: doctorInstance, field: "diasNoLaborales")}</td>--%>

<%--						<td>${fieldValue(bean: doctorInstance, field: "horario")}</td>--%>
						<td> 
							<g:link action="show" id="${doctorInstance.id}"><span class="glyphicon glyphicon-eye-open" aria-hidden="true" data-toggle="tooltip" title="Mostrar"></span></g:link> &nbsp;
<%--							<g:link action="delete" id="${doctorInstance.id}"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></g:link> &nbsp;--%>
							<g:link action="edit" id="${doctorInstance.id}"><span class="glyphicon glyphicon-pencil" aria-hidden="true" data-toggle="tooltip" title="Editar"></span></g:link> &nbsp;
						</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			</div>
			</div>
			<div class="pagination">
				<g:paginate total="${doctorCount ?: 0}" />
			</div>
		</div>
	</div>
	</body>
</html>
