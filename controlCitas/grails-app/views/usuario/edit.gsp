<%@ page import="controlcitas.Usuario" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainAdmin">
		<g:set var="entityName" value="${message(code: 'usuario.label', default: 'Usuario')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">
<%--		<a href="#edit-usuario" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>--%>
		<div class="nav" role="navigation" id="navTemp">
			<ul>
<%--				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--%>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="edit-usuario" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<div class="row">
				<g:if test="${flash.message}">
					<div class="alert alert-danger col-md-8" role="alert">${flash.message}</div>
				</g:if>
				<g:hasErrors bean="${usuarioInstance}">
				as
				<ul class="alert alert-danger col-md-8" role="alert">
					asdad
					<g:eachError bean="${usuarioInstance}" var="error">
					<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
					</g:eachError>
				</ul>
				</g:hasErrors>
			</div>
			<g:form url="[resource:usuarioInstance, action:'update']" method="PUT" class="form-horizontal" >
				<g:hiddenField name="version" value="${usuarioInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons col-sm-offset-2">
					<g:actionSubmit class="save" class="btn btn-success" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
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
