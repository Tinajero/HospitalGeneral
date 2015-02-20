<%@ page import="controlcitas.Usuario" %>



<div class="form-group ${hasErrors(bean: usuarioInstance, field: 'username', 'error')} required">
	<label for="username" class="col-sm-2 control-label">
		<g:message code="usuario.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<div  class="col-sm-4">
		<g:textField name="username" class="form-control" required="" value="${usuarioInstance?.username}"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: usuarioInstance, field: 'password', 'error')} required">
	<label for="password" class="col-sm-2 control-label">
		<g:message code="usuario.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<div  class="col-sm-4">
		<g:passwordField  name="password" required=""  class="form-control"  value="${usuarioInstance?.password}"/>
	</div>
</div>

<%--<div class="form-group ${hasErrors(bean: usuarioInstance, field: 'accountExpired', 'error')} ">--%>
<%--	<label for="accountExpired" class="col-sm-2 control-label">--%>
<%--		<g:message code="usuario.accountExpired.label" default="Account Expired" />--%>
<%--		--%>
<%--	</label>--%>
<%--	--%>
<%--	<div  class="col-sm-4">--%>
<%--		<g:checkBox name="accountExpired"  value="${usuarioInstance?.accountExpired}" />--%>
<%--	</div>--%>
<%--</div>--%>
<%----%>
<%--<div class="form-group ${hasErrors(bean: usuarioInstance, field: 'accountLocked', 'error')} ">--%>
<%--	<label for="accountLocked" class="col-sm-2 control-label">--%>
<%--		<g:message code="usuario.accountLocked.label" default="Account Locked" />--%>
<%--		--%>
<%--	</label>--%>
<%--	<div  class="col-sm-4">--%>
<%--		<g:checkBox name="accountLocked" value="${usuarioInstance?.accountLocked}" />--%>
<%--	</div>--%>
<%--</div>--%>
<%----%>
<%--<div class="form-group ${hasErrors(bean: usuarioInstance, field: 'enabled', 'error')} ">--%>
<%--	<label for="enabled" class="col-sm-2 control-label">--%>
<%--		<g:message code="usuario.enabled.label" default="Enabled" />--%>
<%--		--%>
<%--	</label>--%>
<%--	<div  class="col-sm-4">--%>
<%--		<g:checkBox name="enabled" value="${usuarioInstance?.enabled}" />--%>
<%--	</div>--%>
<%--</div>--%>
<%----%>
<%--<div class="form-group ${hasErrors(bean: usuarioInstance, field: 'passwordExpired', 'error')} ">--%>
<%--	<label for="passwordExpired" class="col-sm-2 control-label">--%>
<%--		<g:message code="usuario.passwordExpired.label" default="Password Expired" />--%>
<%--		--%>
<%--	</label>--%>
<%--	<div  class="col-sm-4">--%>
<%--		<g:checkBox name="passwordExpired" value="${usuarioInstance?.passwordExpired}" />--%>
<%--	</div>--%>
<%--</div>--%>

