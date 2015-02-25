
<%@ page import="controlcitas.Usuario" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainAdmin">
		<g:set var="entityName" value="${message(code: 'usuario.label', default: 'Usuario')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">
<%--		<a href="#show-usuario" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>--%>
		<div class="nav" role="navigation" id="navTemp">
			<ul >
<%--				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--%>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-usuario" class="content scaffold-show" role="main">
			<div class="row">
				<g:if test="${flash.message}">
					<div  class="alert alert-success col-sm-4" role="alert">${flash.message}</div>
				</g:if>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading"><h1><g:message code="default.show.label" args="[entityName]" /></h1></div>
  				<div class="panel-body">
<%--					<ol class="list-group">--%>
					<table class = "table table-bordered">
						<tbody>
						<g:if test="${usuarioInstance?.username}">
						<tr>
							<td><span id="username-label" class="property-label"><g:message code="usuario.username.label" default="Username" /></span></td>
							
								<td>
									<span class="property-value" aria-labelledby="username-label"> 
										<g:fieldValue bean="${usuarioInstance}" field="username"/>
									</span>
								</td>
							
						</tr>
						</g:if>
					
<%--						<g:if test="${usuarioInstance?.password}">--%>
<%--						<tr>--%>
<%--							<td><span id="password-label" class="property-label"><g:message code="usuario.password.label" default="Password" /></span></td>--%>
<%--							--%>
<%--								<td><span class="property-value" aria-labelledby="password-label"><g:fieldValue bean="${usuarioInstance}" field="password"/></span></td>--%>
<%--							--%>
<%--						</tr>--%>
<%--						</g:if>--%>
					
						<g:if test="${usuarioInstance?.accountExpired}">
						<tr>
							<td><span id="accountExpired-label" class="property-label"><g:message code="usuario.accountExpired.label" default="Account Expired" /></span></td>
							
								<td><span class="property-value" aria-labelledby="accountExpired-label"><g:formatBoolean boolean="${usuarioInstance?.accountExpired}" /></span></td>
							
						</tr>
						</g:if>
					
						<g:if test="${usuarioInstance?.accountLocked}">
						<tr>
							<td><span id="accountLocked-label" class="property-label"><g:message code="usuario.accountLocked.label" default="Account Locked" /></span></td>
							
								<td><span class="property-value" aria-labelledby="accountLocked-label"><g:formatBoolean boolean="${usuarioInstance?.accountLocked}" /></span></td>
							
						</tr>
						</g:if>
					
						<g:if test="${usuarioInstance?.enabled}">
						<tr>
							<td><span id="enabled-label" class="property-label"><g:message code="usuario.enabled.label" default="Enabled" /></span></td>
							
								<td><span class="property-value" aria-labelledby="enabled-label"><g:formatBoolean boolean="${usuarioInstance?.enabled}" /></span></td>
							
						</tr>
						</g:if>
					
						<g:if test="${usuarioInstance?.passwordExpired}">
						<tr>
							<td><span id="passwordExpired-label" class="property-label"><g:message code="usuario.passwordExpired.label" default="Password Expired" /></span></td>
							
								<td><span class="property-value" aria-labelledby="passwordExpired-label"><g:formatBoolean boolean="${usuarioInstance?.passwordExpired}" /></span></td>
							
						</tr>
						</g:if>
					
<%--					</ol>--%>
						</tbody>
					</table>
				
					<g:form url="[resource:usuarioInstance, action:'delete']" method="DELETE">
						<div  role="group" aria-label="...">
							<g:link class="btn btn-info" action="edit" resource="${usuarioInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
							<g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
						</div>
					</g:form>
				</div>
			</div>
		</div>
		</div>
		<script>
		$(document).ready( function(){
			var navhere = $(".nav ul");
			var botones=navhere.html()
			navhere = $("#navTemp");
			navhere.remove();
			setNavBarShowEdit(botones) 
		});
		</script>
	</body>
</html>
