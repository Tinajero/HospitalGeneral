
<%@ page import="controlcitas.Usuario" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainAdmin">
		<g:set var="entityName" value="${message(code: 'usuario.label', default: 'Usuario')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">
<%--		<a href="#list-usuario" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>--%>
<%--		<div class="nav" role="navigation">--%>
<%--			<ul>--%>
<%--				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--%>
<%--				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>--%>
<%--			</ul>--%>
<%--		</div>--%>
		<div id="list-usuario" class="content scaffold-list" role="main">
			
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<div class="panel panel-info">
			  <!-- Default panel contents -->
			  <div class="panel-heading">
			  	<div class="row">
			  		
				  	<h1 class="col-md-9"><g:message code="default.list.label" args="[entityName]" /></h1>
<%--					<div class="btn-group col-md-2" role="group" aria-label="..."> --%>
						<g:link class="btn btn-primary col-md-2" action="create" role="button" sytle="margin-top: 20px;" data-toggle="tooltip" title="Crea un nuevo usuario">
							<g:message code="default.new.label" args="[entityName]" /> &nbsp;&nbsp;
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
						</g:link>
<%--					</div>--%>
				</div>
			  </div>
				<table class="table table-striped">
				<thead>
						<tr>
						
							<g:sortableColumn property="username" title="${message(code: 'usuario.username.label', default: 'Usuario')}" />
						
<%--							<g:sortableColumn property="password" title="${message(code: 'usuario.password.label', default: 'Password')}" />--%>
						
							<g:sortableColumn property="accountExpired" title="${message(code: 'usuario.accountExpired.label', default: 'Account Expired')}" />
						
							<g:sortableColumn property="accountLocked" title="${message(code: 'usuario.accountLocked.label', default: 'Account Locked')}" />
						
							<g:sortableColumn property="enabled" title="${message(code: 'usuario.enabled.label', default: 'Enabled')}" />
						
							<g:sortableColumn property="passwordExpired" title="${message(code: 'usuario.passwordExpired.label', default: 'Password Expired')}" />
							
							<td>Opciones</td>
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${usuarioInstanceList}" status="i" var="usuarioInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td>${fieldValue(bean: usuarioInstance, field: "username")}</td>
						
<%--							<td>${fieldValue(bean: usuarioInstance, field: "password")}</td>--%>
						
							<td><g:formatBoolean boolean="${usuarioInstance.accountExpired}" /></td>
						
							<td><g:formatBoolean boolean="${usuarioInstance.accountLocked}" /></td>
						
							<td><g:formatBoolean boolean="${usuarioInstance.enabled}" /></td>
						
							<td><g:formatBoolean boolean="${usuarioInstance.passwordExpired}" /></td>
							<td> 
								<g:link action="show" id="${usuarioInstance.id}"><span class="glyphicon glyphicon-eye-open" aria-hidden="true" data-toggle="tooltip" title="Mostrar"></span></g:link> &nbsp;
<%--								<g:link action="delete" id="${usuarioInstance.id}"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></g:link> &nbsp;--%>
								<g:link action="edit" id="${usuarioInstance.id}"><span class="glyphicon glyphicon-pencil" aria-hidden="true" data-toggle="tooltip" title="Editar"></span></g:link> &nbsp;
							</td>
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			<div class="pagination">
				<g:paginate total="${usuarioInstanceCount ?: 0}" />
			</div>
		</div>
	</div>

	</body>
</html>
