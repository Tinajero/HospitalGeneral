<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainAdmin">
		<g:set var="entityName" value="${message(code: 'tipoSubServicio.label', default: 'TipoSubServicio')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="col-sm-9 col-md-10 col-sm-offset-3 col-md-offset-2 main">
			<div id="create-tipoSubServicio" class="content scaffold-create" role="main">
				<h1><g:message code="default.create.label" args="[entityName]" /></h1>
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<g:hasErrors bean="${tipoSubServicio}">
				<ul class="errors" role="alert">
					<g:eachError bean="${tipoSubServicio}" var="error">
					<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
					</g:eachError>
				</ul>
				</g:hasErrors>
				<g:form url="[resource:tipoSubServicio, action:'save']" >
					<fieldset class="form-horizontal">
						<g:render template="form"/>
					</fieldset>
					<fieldset class="buttons col-sm-offset-4">
						<g:submitButton name="create" class="save  btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
					</fieldset>
				</g:form>
			</div>
		</div>
	</body>
</html>
